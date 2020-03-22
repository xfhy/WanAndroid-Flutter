import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/stroke_widget.dart';

/// 一些常用的工具类方法
class ToolUtils {
  ///判断 字符串 是否为空
  static bool isNullOrEmpty(String str) {
    return str == null || str.length <= 0;
  }

  ///标题符号转换
  static String signToStr(String str) {
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
}
