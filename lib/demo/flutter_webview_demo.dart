import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView Demo',
      routes: {
        '/widget': (context) => WebViewPage(),
      },
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('跳转网页'),
          onPressed: () {
            //命名路由   且 传递参数
            Navigator.pushNamed(context, '/widget',
                arguments: WebData("https://www.baidu.com", false));
          },
        ),
      ),
    );
  }
}

class WebData {
  String url;
  bool isLiked;

  WebData(this.url, this.isLiked);
}

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //通过RouteSettings 获取传递过来的参数
    WebData webData = ModalRoute.of(context).settings.arguments as WebData;
    return new WebviewScaffold(
      url: webData.url,
      appBar: new AppBar(
        title: const Text('Widget webview'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
    );
  }
}
