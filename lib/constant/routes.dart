import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/web_view_page.dart';

///路由
///2020年03月22日12:44:43
///xfhy

class Routes {
  static String root = "/";
  static String webViewPage = '/web_view_page';

  static Map<String, WidgetBuilder> routes = {};

  static void init() {
    routes[webViewPage] = (context) => WebViewPage();
  }
}
