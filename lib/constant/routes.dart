import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/knowledge/knowledge_page.dart';
import 'package:wanandroidflutter/page/login/login_page.dart';
import 'package:wanandroidflutter/page/search/search_page.dart';
import 'package:wanandroidflutter/page/webview/web_view_page.dart';

///路由
///2020年03月22日12:44:43
///xfhy

class Routes {
  static String root = "/";

  //webview
  static String webViewPage = '/web_view_page';

  //知识体系  作者文章列表
  static String knowledgePage = '/knowledge_page';

  //登录界面
  static String loginPage = '/login_page';

  //搜索页面
  static String searchPage = '/search_page';

  static Map<String, WidgetBuilder> routes = {};

  static void init() {
    routes[webViewPage] = (context) => WebViewPage();
    routes[knowledgePage] = (context) => KnowledgePage();
    routes[loginPage] = (context) => LoginPage();
    routes[searchPage] = (context) => SearchPage();
  }
}
