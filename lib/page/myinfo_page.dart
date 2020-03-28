import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/util/log_util.dart';

///我的
class MyInfoPage extends StatefulWidget {
  @override
  State createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('跳转登录界面'),
            onPressed: () {
              LogUtil.d("跳转");
              Navigator.pushNamed(context, Routes.loginPage);
            },
          ),
          RaisedButton(
            child: Text('退出登录'),
            onPressed: () {
              LogUtil.d("跳转");
            },
          ),
        ],
      ),
    );
  }
}
