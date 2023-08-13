import 'dart:io';

import '../../domain/entities/normal.dart';
import '../platform_channel/platform.dart';

Future<List<Normal>> checkImageFirst(String imageFile) async {
  final result = await MyPlatform().checkImage(imageFile);
  return result
      .map((e) => Normal.fromJson(e))
      .where((element) => element.confidence > 0.9)
      .toList();
}
