import '../../domain/entities/skin_percentage.dart';
import '../platform_channel/platform.dart';

Future<SkinPercentage> runSkinModel(String imagePath) async {
  final List<double> output = await MyPlatform().runSkin(imagePath);
  double maximumPercentage = 0.0;
  int maxIndex = 0;
  for (int i = 0; i < output.length; i++) {
    if (output[i] >= maximumPercentage) {
      maximumPercentage = output[i];
      maxIndex = i;
    }
  }
  return SkinPercentage(name: names[maxIndex], percentage: maximumPercentage);
}

final names = [
  'Bowen\'s disease',
  'Basal Cell Carcinoma',
  'Benign Keratosis-like Lesions',
  'Dermatofibroma',
  'Melanoma',
  'Normal',
  'Melanocytic Nevi',
  'Vascular Lesions',
];
