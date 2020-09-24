import 'package:flutter/material.dart';

class PassNativeBlockPage extends StatefulWidget {
  final Future<dynamic> Function(dynamic) nativeCallback;

  const PassNativeBlockPage({Key key, this.nativeCallback}) : super(key: key);
  @override
  _PassNativeBlockPageState createState() => _PassNativeBlockPageState();
}

class _PassNativeBlockPageState extends State<PassNativeBlockPage> {
  String _resultText = 'not result yet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('调用Native在构造函数中传入的block'),
      ),
      body: ListView(
        children: <Widget>[
          Text(_resultText),
          _buttonClickWidget(context),
        ],
      ),
    );
  }

  Widget _buttonClickWidget(BuildContext context) {
    return RaisedButton(
      child: Text('调用Native传递过来的block'),
      onPressed: () async {
        var param = {
          'pageName': 'PassNativeBlockPage',
        };
        dynamic result = await widget.nativeCallback(param);
        setState(() {
          _resultText = result.toString();
        });
      },
    );
  }
}
