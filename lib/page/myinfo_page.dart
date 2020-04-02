import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/application.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///我的
class MyInfoPage extends StatefulWidget {
  @override
  State createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String userName;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildListChild(),
    );
  }

  List<Widget> _buildListChild() {
    return [
      //头像
      buildAvatar(),
      //登录按钮
      buildLoginBtn(),
      RaisedButton(
        child: Text('退出登录'),
        onPressed: () {
          LogUtil.d("跳转");
          setState(() {
            Application.isLogin = false;
            dataUtils.setLoginState(false);
            dataUtils.clearUserName();
            userName = null;
          });
          loginOut();
        },
      ),
    ];
  }

  List<Widget> getWidget() {
    if (Application.isLogin) {
      return [
        RaisedButton(
          child: Text('退出登录'),
          onPressed: () {
            LogUtil.d("跳转");
            setState(() {
              Application.isLogin = false;
            });
            loginOut();
          },
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text('跳转登录界面'),
          onPressed: () {
            LogUtil.d("跳转");
            Navigator.pushNamed(context, Routes.loginPage);
          },
        ),
      ];
    }
  }

  void loginOut() async {
    await dataUtils.loginOut();
  }

  ///构建头像
  Widget buildAvatar() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: 100,
        height: 100,
        child: CircleAvatar(
//          backgroundColor: Colors.white,
          backgroundImage: AssetImage(
              Application.isLogin ? ToolUtils.getImage("ic_launcher_foreground") : ToolUtils.getImage("ic_default_avatar", format: "webp")),
        ),
      ),
    );
  }

  //构建登录按钮
  Widget buildLoginBtn() {
    return RaisedButton(
      color: AppColors.colorPrimary,
      child: Text(
        (userName == null || userName == "") ? "请登录" : userName,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if (!Application.isLogin) {
          Navigator.pushNamed(context, Routes.loginPage);
        }
      },
    );
  }

  void getUserName() async {
    await dataUtils.getUserName().then((value) {
      setState(() {
        LogUtil.d("userName = $userName");
        userName = value;
      });
    });
  }
}
