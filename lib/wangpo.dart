import 'dart:async';

import 'package:flutter/services.dart';

class Wangpo {
  static const MethodChannel _channel = const MethodChannel('wangpo');
  static const String _methodNameKey = 'methodName';
  static const String _methodParamsKey = 'methodParams';

  ///调用Native方法，并且获取返回数据
  ///[methodName] 是Native定义的方法名
  ///[methodParams] 传给Native方法的参数
  static Future<Map<String, dynamic>> callNativeMethod(
      String methodName, Map<String, dynamic> methodParams) async {
    assert((null != methodName) && (methodName.length != 0),
        'callNativeMethod :method name should not be null');
    var params = {
      _methodNameKey: methodName,
      _methodParamsKey: methodParams ?? {}
    };
    final Map<String, dynamic> resultMap = await _channel
        .invokeMapMethod<String, dynamic>('callNativeMethod', params);
    return resultMap;
  }
}
