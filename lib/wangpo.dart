import 'dart:async';

import 'package:flutter/services.dart';

class Wangpo {
  static const MethodChannel _channel =
      const MethodChannel('wangpo');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
