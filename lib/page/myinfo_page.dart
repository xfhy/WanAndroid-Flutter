import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/application.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

import 'login/login_event.dart';

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

    //监听事件总线上数据变化
    Application.eventBus.on<LoginEvent>().listen((event) {
      if (mounted) {
        setState(() {
          userName = event.username;
        });
      }
    });
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
      //我的收藏
      buildMyCollect(),
      //每日一问
      buildEveryDayQuestion(),
      //清楚缓存
      buildClearCache(),
      //关于我们
      buildAboutUs(),
      //退出登录
      buildLoginOut(),
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

  //我的收藏
  Widget buildMyCollect() {
    return buildCommonItem(Icons.favorite, "我的收藏", () {
      //需要登录
      LogUtil.d("跳转我的收藏");
      if (Application.isLogin) {
        Navigator.pushNamed(context, Routes.favoritePage);
      } else {
        Navigator.pushNamed(context, Routes.loginPage);
      }
    });
  }

  //构建每日一问
  Widget buildEveryDayQuestion() {
    return buildCommonItem(Icons.question_answer, "每日一问", () {
      //需要登录
      LogUtil.d("跳转每日一问");
      if (Application.isLogin) {
        Navigator.pushNamed(context, Routes.questionPage);
      } else {
        Navigator.pushNamed(context, Routes.loginPage);
      }
    });
  }

  //构建清除缓存
  Widget buildClearCache() {
    return buildCommonItem(Icons.clear, "清除缓存", () {
      //需要登录
      LogUtil.d("展示对话框  是否确认清除");
      ToolUtils.showAlertDialog(context, "确定清除缓存么?", confirmText: "确定", confirmCallback: () {
        ToolUtils.clearCookie();
        ToolUtils.showToast(msg: "清除成功");
      });
    });
  }

  //构建关于我们
  Widget buildAboutUs() {
    return buildCommonItem(Icons.supervised_user_circle, "关于我们", () {
      //需要登录
      LogUtil.d("跳转关于我们");
    });
  }

  //构建退出
  Widget buildLoginOut() {
    return buildCommonItem(Icons.exit_to_app, "退出登录", () {
      //需要登录
      LogUtil.d("退出登录");

      ToolUtils.showAlertDialog(context, "确定要退出登录么?", confirmText: "确定", confirmCallback: () {
        ToolUtils.clearCookie();
        loginOut();
        setState(() {
          Application.isLogin = false;
          dataUtils.setLoginState(false);
          dataUtils.clearUserName();
          userName = null;
          ToolUtils.showToast(msg: "退出登录成功");
        });
      });
    });
  }

  //构建通用item
  Widget buildCommonItem(IconData iconData, String itemContent, Function clickListener) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0, top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(iconData),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  itemContent,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
      onTap: clickListener,
    );
  }

  //退出登录
  void loginOut() async {
    await dataUtils.loginOut();
  }

  //获取用户名
  void getUserName() async {
    await dataUtils.getUserName().then((value) {
      setState(() {
        LogUtil.d("userName = $userName");
        userName = value;
      });
    });
  }
}
