import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPlatform {
  static const platform = MethodChannel('myDetectionChannel');
  Future<List<double>> runSkin(String path) async {
    try {
      final List<double> result =
          await platform.invokeMethod('runSkin', {'path': path});
      print(result);
      return result;
    } on PlatformException catch (e) {
      print('error');
      return [];
    }
  }

  Future<String?> translate(String text, bool accepted) async {
    final String? result = await platform
        .invokeMethod('translate', {'text': text, 'accepted': accepted});
    return result;
  }

  Future<List<Map<String, Object>>> checkImage(String path) async {
    try {
      final List<Object?> result =
          await platform.invokeMethod('checkImage', {'path': path});

      return result
          .map((e) => Map<String, Object>.from(e as Map<Object?, Object?>))
          .toList();
    } on PlatformException catch (e) {
      print('error');
      return [];
    }
  }

  Future<List<double>> runLung(String path) async {
    try {
      final List<double> result =
          await platform.invokeMethod('runLung', {'path': path});
      return result;
    } on PlatformException catch (e) {
      print('error');
      return [];
    }
  }
}
