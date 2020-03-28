import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/common/application.dart';

///日志打印
///可以动态生产环境和开发环境,且长度不限
class LogUtil {
  static var _separator = "-";
  static var _split =
      "$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator";
  static var _title = "xfhy-Log";
  static var _isDebug = Application.isDebug;

  ///print默认是有长度限制的
  static int _limitLength = 800;

  ///开始行  =========xfhy========
  static String _startLine = "$_split$_title$_split";

  //末行 就是很多等号
  static String _endLine = "$_split$_separator$_separator$_separator$_split";

  static void init({String title, @required bool isDebug, int limitLength}) {
    _title = title;
    _isDebug = isDebug;
    _limitLength = limitLength ??= _limitLength;
    _startLine = "$_split$_title$_split";
    var endLineStr = StringBuffer();
    var cnCharReg = RegExp("[\u4e00-\u9fa5]");
    for (int i = 0; i < _startLine.length; i++) {
      if (cnCharReg.stringMatch(_startLine[i]) != null) {
        endLineStr.write(_separator);
      }
      endLineStr.write(_separator);
    }
    _endLine = endLineStr.toString();
  }

  //仅Debug模式可见
  static void d(dynamic obj) {
    if (_isDebug) {
      _log(obj.toString());
    }
  }

  static void v(dynamic obj) {
    _log(obj.toString());
  }

  static void _log(String msg) {
    print("$_startLine");
    //_logEmptyLine();
    if (msg.length < _limitLength) {
      print(msg);
    } else {
      segmentationLog(msg);
    }
    //_logEmptyLine();
    print("$_endLine");
  }

  static void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }

  static void _logEmptyLine() {
    print("");
  }
}
