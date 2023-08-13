import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<ByteArrayAndroidBitmap?> getBase64NetworkImage(String? url) async {
  if (url == null) return null;
  final response = await Dio().get<Uint8List>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  if (response.data == null) return null;
  final image = response.data!;
  final imageWithoutMetadata = await removeMetadataFromImageBytes(image);
  if (imageWithoutMetadata == null) return null;
  return ByteArrayAndroidBitmap.fromBase64String(
      base64Encode(imageWithoutMetadata));
}

Future<Uint8List?> removeMetadataFromImageBytes(Uint8List imageBytes) async {
  final result = await FlutterImageCompress.compressWithList(
    imageBytes,
    quality: 60,
    format: CompressFormat.jpeg,
    keepExif: false,
  );
  return result;
}
