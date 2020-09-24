import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:wangpo_example/page/pass_native_block_page.dart';

import 'page/call_native_method_page.dart';
import 'page/receive_native_method_page.dart';
import 'package:wangpo/wangpo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.registerPageBuilders({
      'call/native/method/page': (pageName, params, _) =>
          CallNativeMethodPage(),
      'receive/native/method/page': (pageName, params, _) =>
          ReceiveNativeMethodPage(),
      'pass/native/block/page': (pageName, params, _) {
        var blockParam = params['blockParam'];
        String blockKey = blockParam['blockKey'];
        Future<dynamic> Function(dynamic) block = this.translateBlock(blockKey);
        //执行method转换的方法
        return PassNativeBlockPage(
          nativeCallback: block,
        );
      }
    });

    initPlatformState();
  }

  Future<dynamic> Function(dynamic) translateBlock(String blockKey) {
    Future<dynamic> Function(dynamic) block = (dynamic param) async {
      dynamic result = await Wangpo.callNativeMethod(blockKey, param);
      return result;
    };
    return block;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = 'Demo';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FlutterBoost.init(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
