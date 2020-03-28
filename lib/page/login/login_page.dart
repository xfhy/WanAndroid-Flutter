import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///登录界面
///2020年03月28日10:45:04
///xfhy
class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPagePage();
  }
}

class _LoginPagePage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: _pushBack,
        ),
        title: Text(
          "登录",
          style: TextStyle(color: Colors.white),
        ),
        //标题栏居中
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(
          children: <Widget>[Text('dasdas')],
        ),
      ),
    );
  }

  void _pushBack() {}
}
