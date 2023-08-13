import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> generateThumbnail(String path) async {
  return VideoThumbnail.thumbnailData(
    timeMs: 1000,
    video: path,
    imageFormat: ImageFormat.JPEG,
  );
}
