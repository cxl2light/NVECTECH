
import 'dart:ui';

import 'package:flutter/services.dart';

import 'plugins_platform_interface.dart';

class Plugins {
  static const MethodChannel _channel = MethodChannel('plugins');

  static Future<String?> getPlatformVersion() async{
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // Java
  static void callJavaMethod() async{
    await _channel.invokeMethod('callJavaMethod');
  }

}
