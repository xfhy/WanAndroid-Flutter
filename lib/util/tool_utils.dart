import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/widget/stroke_widget.dart';

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
      Navigator.of(context).pop();
    }
  }
}
