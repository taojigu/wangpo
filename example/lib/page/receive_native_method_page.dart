import 'package:flutter/material.dart';
import 'package:wangpo/wangpo_native_message_receiver.dart';

class ReceiveNativeMethodPage extends StatefulWidget {
  @override
  _ReceiveNativeMethodPageState createState() =>
      _ReceiveNativeMethodPageState();
}

class _ReceiveNativeMethodPageState extends State<ReceiveNativeMethodPage> {
  String _textFromNative = 'no message yet';
  WangpoNativeMessageReceiver _receiver =
      WangpoNativeMessageReceiver('from/demo/flutter/boost/page');
  //WangpoNativeListener _listener = Wangpo
  @override
  void initState() {
    super.initState();
    _receiver.listen((WangpoNativeMessage nativeMessage) {
      if (nativeMessage.methodName == 'increse') {
        return _processIncreaseMessage(nativeMessage);
      }

      if (nativeMessage.methodName == 'decrease') {
        return _processDecreaseMessage(nativeMessage);
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('接受Native调用Demo页面'),
      ),
      body: ListView(
        children: <Widget>[Text(_textFromNative)],
      ),
    );
  }

  dynamic _processIncreaseMessage(WangpoNativeMessage nativeMessage) {
    setState(() {
      _textFromNative = '来自于Native的数据是 ${nativeMessage.methodParams}';
    });
    return 'increase successed';
  }

  dynamic _processDecreaseMessage(WangpoNativeMessage nativeMessage) {
    setState(() {
      _textFromNative = '来自于Native的数据是 ${nativeMessage.methodParams}';
    });
    return 'decrease Done';
  }
}
