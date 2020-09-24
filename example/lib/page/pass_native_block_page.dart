import 'package:flutter/material.dart';

class PassNativeBlockPage extends StatefulWidget {
  final Future<dynamic> Function(dynamic) nativeCallback;

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
        dynamic resultMap = await widget.nativeCallback(param);
        print('Result String from Native is $resultMap');
      },
    );
  }
}
