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
      appBar: getAppBar(),
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

  AppBar getAppBar() {
    AppBar appBar = ToolUtils.getCommonAppBar(context, ToolUtils.signToStr(pageData.title), fontSize: 14.0, actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onPressed: () {
          //todo xfhy 网页标题栏菜单
        },
      ),
    ]);
    return appBar;
  }
}
