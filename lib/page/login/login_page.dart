import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/application.dart';
import 'package:wanandroidflutter/constant/AppColors.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/login_data_entity.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

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
  bool isShowPassWord = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //设置调试时的数据
    if (Application.isDebug) {
      _nameController.text = "xxxxxxx415456465465";
      _pwdController.text = "xxxxxxx";
    }
  }

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.colorPrimary,
          child: Column(
            //自适应 大小 这里是高
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                //阴影
                elevation: 10.0,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5.0, left: 10.0, right: 10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //顶部图标
                        Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Image.asset(
                            "images/ic_launcher.png",
                            fit: BoxFit.cover,
                          ),
                        ),

                        //输入item
                        buildSignInTextForm(),

                        //有点类似于Android中的Space
                        SizedBox(height: 15.0),

                        //构建底部按钮
                        buildBottomBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pushBack() {
    Navigator.pop(context);
  }

  Widget buildSignInTextForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          //自动获取焦点 打开键盘
          autofocus: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            hintText: "WanAndroid 用户名",
            labelText: "用户名",
            border: UnderlineInputBorder(),
          ),
          controller: _nameController,
          validator: (username) {
            if (username == null || username.isEmpty) {
              return "用户名不能为空!";
            }
            return null;
          },
        ),
        TextFormField(
          autofocus: false,
          keyboardType: TextInputType.visiblePassword,
          //是否隐藏输入内容 true:隐藏
          obscureText: !isShowPassWord,
          decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            hintText: "WanAndroid 登录密码",
            labelText: "密码",
            border: UnderlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              color: Colors.black,
              onPressed: showPassWord,
            ),
          ),
          controller: _pwdController,
        ),
      ],
    );
  }

  ///构建底部按钮
  Widget buildBottomBtn() {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Expanded(
          child: RaisedButton(
            child: Text("登录"),
            color: AppColors.colorPrimary,
            onPressed: () {
              login();
            },
          ),
        ),
        SizedBox(width: 30.0),
        Expanded(
          child: RaisedButton(
            color: AppColors.colorPrimary,
            child: Text("注册"),
            onPressed: () {
              register();
            },
          ),
        ),
        SizedBox(width: 15.0),
      ],
    );
  }

  ///控制是否展示明文密码
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  //登录
  void login() async {
    LoginDataEntity loginDataEntity = await dataUtils.login(_nameController.text, _pwdController.text, context);
    dataUtils.setLoginState(true);
    ToolUtils.showToast(msg: "登录成功");
    Navigator.of(context).pop();
  }

  //注册
  void register() {}
}
