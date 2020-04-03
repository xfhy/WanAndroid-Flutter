import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/widget/stroke_widget.dart';
import 'package:cookie_jar/cookie_jar.dart';

/// 一些常用的工具类方法
class ToolUtils {
  ///判断 字符串 是否为空
  static bool isNullOrEmpty(String str) {
    return str == null || str.length <= 0;
  }

  ///标题符号转换
  static String signToStr(String str) {
    if (null == str || "" == str) {
      return "";
    }
    return str
        .replaceAll(RegExp("(<em[^>]*>)|(</em>)"), "")
        .replaceAll(RegExp("\n{2,}"), "\n")
        .replaceAll(RegExp("\s{2,}"), " ")
        .replaceAll("&ndash;", "–")
        .replaceAll("&mdash;", "—")
        .replaceAll("&lsquo;", "‘")
        .replaceAll("&rsquo;", "’")
        .replaceAll("&sbquo;", "‚")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll("&bdquo;", "„")
        .replaceAll("&amp;", "&")
        .replaceAll("&permil;", "‰")
        .replaceAll("&lsaquo;", "‹")
        .replaceAll("&rsaquo;", "›")
        .replaceAll("&euro;", "€")
        .replaceAll("&quot;", "'")
        .replaceAll("<p>", "")
        .replaceAll("&middot;", "·")
        .replaceAll("&hellip;", "...")
        .replaceAll("</p>", "")
        .replaceAll("</br>", "\n")
        .replaceAll("<br>", "\n");
  }

  ///创建 tag widget 抽取的方法
  static Widget buildStrokeTagWidget(String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: StrokeWidget(
        color: color,
        strokeWidth: 0.5,
        childWidget: Text(
          text,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }

  ///将传入的时间根据空格切割  只要前半部分
  static String getFirstDate(String date) {
    if (date == null) {
      return "";
    }
    if (date.contains(" ")) {
      return date.split(" ")[0];
    } else {
      return date;
    }
  }

  ///展示toast
  static void showToast({String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  ///get通用状态栏
  static AppBar getCommonAppBar(BuildContext context, String title, {double fontSize, List<Widget> actions}) {
    if (title == null) {
      title = "";
    }
    return AppBar(
      backgroundColor: AppColors.colorPrimary,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        //点击返回
        onPressed: () {
          if (context != null) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize == null ? 18.0 : fontSize,
        ),
      ),
      //标题栏居中
      centerTitle: true,
      //右边的action 按钮
      actions: actions == null ? <Widget>[] : actions,
      //action 颜色
      //actionsIconTheme: IconThemeData(color: Colors.white),
    );
  }

  ///展示loading dialog
  static void showLoading(BuildContext context, String loadingText) {
    //展示一个loading dialog
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return SpinKitFadingCircle(
            color: AppColors.colorPrimary,
          );
        });
  }

  ///隐藏loading dialog
  static void disMissLoadingDialog(bool isAddLoading, BuildContext context) {
    if (isAddLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  //获取本地资源图片
  static String getImage(String imageName, {String format: 'png'}) {
    return "images/$imageName.$format";
  }

  ///获取非空字符串  如果是null,则返回""
  static String getNotEmptyStr(String text) {
    return text == null ? "" : text;
  }

  ///获取非空bool  如果是null,则返回false
  static bool getNotNullBool(bool value) {
    return value == null ? false : value;
  }

  ///清除 cookie 缓存
  static void clearCookie() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = Directory("$documentsPath/coolies");
    await dir.create();
    PersistCookieJar(dir: dir.path).deleteAll();
  }

  //Dialog 封装
  static void showAlertDialog(BuildContext context, String contentText,
      {Function confirmCallback, Function dismissCallback, String confirmText = ""}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(contentText),
          actions: <Widget>[
            FlatButton(
              child: Text('手滑了'),
              onPressed: () {
                if (dismissCallback != null) {
                  dismissCallback();
                }
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(confirmText == "" ? '注销' : confirmText),
              onPressed: () {
                if (confirmCallback != null) {
                  confirmCallback();
                }
                Navigator.of(context).pop();
              },
            )
          ],
          elevation: 20, //阴影
        );
      },
    );
  }
}
