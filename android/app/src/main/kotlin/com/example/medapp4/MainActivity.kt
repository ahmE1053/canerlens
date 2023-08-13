package com.example.medapp4

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import com.example.medapp4.ml.LungCancerModelWithoutSaved
import com.example.medapp4.ml.SkinModel
import com.google.mlkit.common.model.DownloadConditions
import com.google.mlkit.nl.translate.TranslateLanguage
import com.google.mlkit.nl.translate.Translation
import com.google.mlkit.nl.translate.TranslatorOptions
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.label.ImageLabeling
import com.google.mlkit.vision.label.defaults.ImageLabelerOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.DataType
import org.tensorflow.lite.support.tensorbuffer.TensorBuffer
import java.io.IOException
import java.nio.ByteBuffer
import java.nio.ByteOrder


class MainActivity : FlutterActivity() {

    private val CHANNEL = "myDetectionChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "runSkin") {
                try {
                    val path = call.argument<String>("path")
                    val bitmap = BitmapFactory.decodeFile(path)
                    val scaledBitmap = Bitmap.createScaledBitmap(bitmap, 150, 150, false)
                    val results = skinModelFunction(scaledBitmap)
                    result.success(results)
                } catch (e: IOException) {
                    result.error("an error occurred", null, null)
                }
            } else if (call.method == "runLung") {
                try {
                    val path = call.argument<String>("path")
                    val bitmap = BitmapFactory.decodeFile(path)
                    val scaledBitmap = Bitmap.createScaledBitmap(bitmap, 150, 150, false)
                    val results = lungModelFunction(scaledBitmap)
                    result.success(results)
                } catch (e: IOException) {
                    result.error("an error occurred", null, null)
                }
            } else if (call.method == "checkImage") {
                val path = call.argument<String>("path")
                if (path != null) {
                    checkImageFirst(path, result)
                }
            } else if (call.method == "translate") {
                val text = call.argument<String>("text")
                if (text != null) {
                    call.argument<Boolean>("accepted")?.let { translateText(text, it, result) }
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun translateText(text: String, accepted: Boolean, result: MethodChannel.Result) {
        val options = TranslatorOptions.Builder()
            .setSourceLanguage(TranslateLanguage.ENGLISH)
            .setTargetLanguage(TranslateLanguage.ARABIC)
            .build()
        val englishArabicTranslator = Translation.getClient(options)
        englishArabicTranslator.translate(text)
            .addOnSuccessListener { word ->
                result.success(word)
            }
            .addOnFailureListener {
                if (!accepted) {
                    result.success(null)
                } else {
                    val conditions = DownloadConditions.Builder()
                        .build()
                    englishArabicTranslator.downloadModelIfNeeded(conditions)
                        .addOnSuccessListener {
                            englishArabicTranslator.translate(text).addOnSuccessListener { word ->
                                result.success(word)
                            }
                        }
                        .addOnFailureListener { exception ->
                            println(exception)
                        }
                }
            }
    }

    private fun checkImageFirst(path: String, result: MethodChannel.Result) {
        val bitmapImage = BitmapFactory.decodeFile(path)
        val image = InputImage.fromBitmap(bitmapImage, 0)
        val labeler = ImageLabeling.getClient(ImageLabelerOptions.DEFAULT_OPTIONS)
        labeler.process(image).addOnSuccessListener { labels ->
            val labelsList = mutableListOf<Map<String, Any>>()
            for (label in labels) {
                labelsList.add(
                    mapOf<String, Any>(
                        "text" to label.text,
                        "confidence" to label.confidence
                    )
                )
            }
            result.success(labelsList)
        }.addOnFailureListener { e ->
            result.error("an error occurred", e.message, null)
        }
    }

    @Throws(IOException::class)
    private fun skinModelFunction(image: Bitmap): FloatArray {
        return try {
            val model: SkinModel = SkinModel.newInstance(applicationContext)
            val byteBuffer = ByteBuffer.allocate(4 * 150 * 150 * 3)
            byteBuffer.order(ByteOrder.nativeOrder())
            val intValues = IntArray(150 * 150)
            image.getPixels(intValues, 0, 150, 0, 0, 150, 150)
            var pixel = 0
            for (i in 0..149) {
                for (j in 0..149) {
                    val `val` = intValues[pixel++]
                    byteBuffer.putFloat((`val` shr 16 and 0xFF) * 1f)
                    byteBuffer.putFloat((`val` shr 8 and 0xFF) * 1f)
                    byteBuffer.putFloat((`val` and 0xFF) * 1f)
                }
            }
            // Creates inputs for reference.
            val inputFeature0 =
                TensorBuffer.createFixedSize(intArrayOf(1, 150, 150, 3), DataType.FLOAT32)
            inputFeature0.loadBuffer(byteBuffer)

            // Runs model inference and gets result.
            val outputs: SkinModel.Outputs = model.process(inputFeature0)
            val outputFeature0: TensorBuffer = outputs.outputFeature0AsTensorBuffer
            // Releases model resources if no longer used.
            model.close()
            outputFeature0.floatArray
        } catch (e: IOException) {
            // TODO Handle the exception
            throw IOException()
        }
    }

    @Throws(IOException::class)
    private fun lungModelFunction(image: Bitmap): FloatArray {
        return try {
            val model: LungCancerModelWithoutSaved = LungCancerModelWithoutSaved.newInstance(
                applicationContext
            )
            val byteBuffer = ByteBuffer.allocate(4 * 150 * 150 * 3)
            byteBuffer.order(ByteOrder.nativeOrder())
            val intValues = IntArray(150 * 150)
            image.getPixels(intValues, 0, 150, 0, 0, 150, 150)
            var pixel = 0
            for (i in 0..149) {
                for (j in 0..149) {
                    val `val` = intValues[pixel++]
                    byteBuffer.putFloat((`val` shr 16 and 0xFF) * 1f)
                    byteBuffer.putFloat((`val` shr 8 and 0xFF) * 1f)
                    byteBuffer.putFloat((`val` and 0xFF) * 1f)
                }
            }
            // Creates inputs for reference.
            val inputFeature0 =
                TensorBuffer.createFixedSize(intArrayOf(1, 150, 150, 3), DataType.FLOAT32)
            inputFeature0.loadBuffer(byteBuffer)

            // Runs model inference and gets result.
            val outputs: LungCancerModelWithoutSaved.Outputs = model.process(inputFeature0)
            val outputFeature0: TensorBuffer = outputs.outputFeature0AsTensorBuffer
            // Releases model resources if no longer used.
            model.close()
            outputFeature0.floatArray
        } catch (e: IOException) {
            // TODO Handle the exception
            throw IOException()
        }
    }
}
