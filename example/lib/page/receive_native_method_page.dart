import 'package:flutter/material.dart';

class ReceiveNativeMethodPage extends StatefulWidget {
  @override
  _ReceiveNativeMethodPageState createState() => _ReceiveNativeMethodPageState();
}

class _ReceiveNativeMethodPageState extends State<ReceiveNativeMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('接受Native调用Demo页面'),
      ),
      body: ListView(
        children: <Widget>[
          _pushPageWidget(context, 'demoTitle', null),
          _buttonClickWidget(context),
        ],
      ),
    );
  }

  Widget _pushPageWidget(
      BuildContext context, String title, Widget pageWidget) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => pageWidget));
      },
    );
  }

  Widget _buttonClickWidget(BuildContext context) {
    return RaisedButton(
      child: Text('ClickDemo'),
      onPressed: () {},
    );
  }
}
