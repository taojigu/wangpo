import 'package:flutter/material.dart';

class PassNativeBlockPage extends StatefulWidget {
  final Map<String, dynamic> Function(Map<String, dynamic>) nativeCallback;

  const PassNativeBlockPage({Key key, this.nativeCallback}) : super(key: key);
  @override
  _PassNativeBlockPageState createState() => _PassNativeBlockPageState();
}

class _PassNativeBlockPageState extends State<PassNativeBlockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('调用Native在构造函数中传入的block'),
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
      child: Text('调用Native传递过来的block'),
      onPressed: () {
        var param = {
          'pageName': 'PassNativeBlockPage',
        };
        Map<String, dynamic> resultMap = widget.nativeCallback(param);
        print('Result String from Native is $resultMap');
      },
    );
  }
}
