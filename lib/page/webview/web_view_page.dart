import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
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

    WebviewScaffold webviewScaffold = WebviewScaffold(
      url: pageData.url,
      appBar: getAppBar(),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
    );
    return webviewScaffold;
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
    //WebviewScaffold不能和PopupMenuButton一起使用,下面是原生WebView,appbar是Flutter View.会导致在appBar展示PopupMenuButton有问题,只能展示部分
    AppBar appBar = ToolUtils.getCommonAppBar(context, ToolUtils.signToStr(pageData.title), fontSize: 14.0, actions: [
      IconButton(
        icon: Icon(
          pageData.collect ? Icons.favorite : Icons.favorite_border,
          color: pageData.collect ? Colors.red : Colors.white,
        ),
        onPressed: _collectArticle,
      ),
      IconButton(
        icon: Icon(
          Icons.link,
          color: Colors.white,
        ),
        onPressed: _launchURL,
      ),
      //WebPageMenu(pageData),
    ]);
    return appBar;
  }

  ///用系统浏览器打开
  _launchURL() async {
    String url = pageData.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToolUtils.showToast(msg: "打开浏览器失败");
    }
  }

  ///收藏文章
  void _collectArticle() async {
    bool isLogin = await dataUtils.isLogin();
    if (!isLogin) {
      //未登录,跳转到登录界面
      Navigator.pushNamed(context, Routes.loginPage);
      return;
    }

    //已登录

    //之前已收藏  那么就是取消收藏
    if (pageData.collect) {
      await dataUtils.cancelCollectArticle(pageData.id);
      setState(() {
        pageData.collect = false;
      });
      ToolUtils.showToast(msg: "取消收藏成功");
    } else {
      //收藏
      await dataUtils.collectArticle(pageData.id);
      setState(() {
        pageData.collect = true;
      });
      ToolUtils.showToast(msg: "收藏成功");
    }
  }
}
