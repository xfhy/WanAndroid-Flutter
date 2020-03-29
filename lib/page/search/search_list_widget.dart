import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/item/article_item.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';
import 'package:wanandroidflutter/widget/refresh/refresh_page.dart';

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
        body: RefreshPage(
          requestApi: getSearchKeyData,
          renderItem: buildArticleItem,
        ),
      );
    } else {
      widget = RefreshPage(
        requestApi: getSearchKeyData,
        renderItem: buildArticleItem,
      );
    }

    return widget;
  }

  ///构建文章item
  Widget buildArticleItem(int index, ArticleData itemData) {
    return ArticleItem(
      itemData,
      isHomeShow: false,
      isClickUser: false,
    );
  }

  Future<Map> getSearchKeyData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    //组装一个json 方便刷新页page 那边取数据
    Map<String, dynamic> result = {"list": [], 'total': 0, 'pageIndex': pageIndex};

    //当前是展示作者的文章
    await dataUtils.search(widget.inputKey, pageIndex, context).then((ArticleDataEntity articleDataEntity) {
      if (articleDataEntity != null && articleDataEntity.datas != null) {
        //页数+1
        pageIndex++;
        result = {
          "list": articleDataEntity.datas,
          'total': articleDataEntity.total,
          'pageIndex': pageIndex,
        };
      }
    }, onError: (e) {
      LogUtil.d("发送错误 ${e.toString()}");
    });

    return result;
  }
}
