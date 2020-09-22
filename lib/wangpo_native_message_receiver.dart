import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String WangpoNativeMessageNotProcessed = 'WangpoNativeMessageNotProcess';

///来自Native的调用Message数据结构
///[methodName] 方法名
///[methodParams] Native 传递过来的参数
class WangpoNativeMessage {
  final String methodName;
  final dynamic methodParams;

  WangpoNativeMessage(this.methodName, this.methodParams);
}

///监听来自于Native的调用
class WangpoNativeMessageReceiver {
  BasicMessageChannel _messageChannel;

  WangpoNativeMessageReceiver(String channelName) {
    _messageChannel = BasicMessageChannel(channelName, StandardMessageCodec());
    return;
  }
  void listen(dynamic Function(WangpoNativeMessage) nativeMesaageHandler) {
    _messageChannel.setMessageHandler((params) async {
      print('received params is $params');
      String methodName = params['methodName'];
      assert(methodName != null, 'methodName from native should not be nil');
      dynamic methodParam = params['methodParam'];
      WangpoNativeMessage nm = WangpoNativeMessage(methodName, methodParam);
      dynamic result = await nativeMesaageHandler(nm);
      if (result is String) {
        String resultString = result;
        if (resultString == WangpoNativeMessageNotProcessed) {
          throw FlutterError(
              'method $methodName in channel ${this._messageChannel.name} is not processed');
        }
      }
      return result;
    });
  }
}
