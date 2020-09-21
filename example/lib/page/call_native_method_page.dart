import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wangpo/wangpo.dart';

class CallNativeMethodPage extends StatefulWidget {
  @override
  _CallNativeMethodPageState createState() => _CallNativeMethodPageState();
}

class _CallNativeMethodPageState extends State<CallNativeMethodPage> {
  String _resultString = 'no result yet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('调用NativeCallBack'),
      ),
      body: ListView(
        children: <Widget>[
          Text(_resultString),
          //_pushPageWidget(context,'demoTitle',null),
          _buttonClickWidget(context),
        ],
      ),
    );
  }

  Widget _buttonClickWidget(BuildContext context) {
    return RaisedButton(
      child: Text('获取Native数据'),
      onPressed: () async {
        var params = {
          'resultName': 'FromCallNativeMehtodPage',
          'index': 123,
          'resultData': {'name': 'Frodo', 'age': 35}
        };
        Map<String, dynamic> resultMap =
            await Wangpo.callNativeMethod('refresh/gate/page', params);
        setState(() {
          _resultString = jsonEncode(resultMap);
        });
      },
    );
  }
}
