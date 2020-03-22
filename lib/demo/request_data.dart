import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';

void main() => runApp(RequestDemo());

class RequestDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('请求网络'),
            onPressed: () {
              dataUtils.getArticleData();
            },
          ),
        ),
      ),
    );
  }
}
