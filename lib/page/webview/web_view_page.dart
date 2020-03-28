import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/page/webview/route_web_page_data.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///网页详情
///2020年03月22日08:15:28
///xfhy

class WebViewPage extends StatefulWidget {
  @override
  State createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  RouteWebPageData pageData;

  @override
  Widget build(BuildContext context) {
    initData();

    LogUtil.d("访问url : ${pageData.url}");

    return new WebviewScaffold(
      url: pageData.url,
      appBar: new AppBar(
        title: Text(ToolUtils.signToStr(pageData.title)),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
    );
  }

  void initData() {
    pageData = ModalRoute.of(context).settings.arguments as RouteWebPageData;

    //如果数据为空 则直接打开首页
    if (pageData == null) {
      pageData = RouteWebPageData();
    }
    if (pageData.url == null || pageData.url == "") {
      pageData.title = "首页";
      pageData.url = Api.BASE_URL;
    }
  }
}
