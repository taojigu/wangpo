import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:wangpo/wangpo.dart';
import 'package:wangpo_example/page/pass_native_block_page.dart';

import 'page/call_native_method_page.dart';
import 'page/receive_native_method_page.dart';

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
        //执行method转换的方法
        return PassNativeBlockPage(
          nativeCallback: (param) {
            return {};
          },
        );
      }
      // 'first': (pageName, params, _) => FirstRouteWidget(),
      // 'second': (pageName, params, _) => SecondRouteWidget(),
      // 'tab': (pageName, params, _) => TabRouteWidget(),
      // 'platformView': (pageName, params, _) => PlatformRouteWidget(),
      // 'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),
      // ///可以在native层通过 getContainerParams 来传递参数
      // 'flutterPage': (pageName, params, _) {
      //   print("flutterPage params:$params");

      //   return FlutterRouteWidget(params:params);
      // },
    });

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Wangpo.platformVersion;
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
