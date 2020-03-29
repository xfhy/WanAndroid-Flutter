import 'package:flutter/material.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///搜索结果列表
///2020年03月29日15:31:15
///xfhy

class SearchResultWidget extends StatefulWidget {
  String inputKey;

  SearchResultWidget({this.inputKey});

  @override
  State createState() {
    return _SearchResultWidgetState();
  }
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  ///是否需要构建标题栏  如果是传入了key,则需要构建  点了关键词进来的
  bool needBuildAppBar = false;

  @override
  Widget build(BuildContext context) {
    //获取传过来的结果
    String key = ModalRoute.of(context).settings.arguments as String;
    if (key != null) {
      needBuildAppBar = true;
      widget.inputKey = key;
    }

    return buildPageWidget(widget.inputKey);
  }

  Widget buildPageWidget(String key) {
    Widget widget;
    if (needBuildAppBar) {
      widget = Scaffold(
        appBar: ToolUtils.getCommonAppBar(context, key),
        body: Container(
          color: Colors.blue,
        ),
      );
    } else {
      widget = Container(
        color: Colors.blue,
      );
    }

    return widget;
  }
}
