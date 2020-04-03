import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/item/article_item.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';
import 'package:wanandroidflutter/widget/refresh/refresh_page.dart';

///2020年04月03日20:20:41
///我的收藏
///xfhy

class FavoritePage extends StatefulWidget {
  @override
  State createState() {
    return _FavoritePageState();
  }
}

class _FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: ToolUtils.getCommonAppBar(context, "我的收藏"),
      body: RefreshPage(
        requestApi: _getArticleData,
        renderItem: _buildArticleItem,
      ),
    );
  }

  Future<Map> _getArticleData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    //组装一个json 方便刷新页page 那边取数据
    Map<String, dynamic> result = {"list": [], 'total': 0, 'pageIndex': pageIndex};

    //当前是展示作者的文章
    await dataUtils.getCollectArticles(pageIndex).then((ArticleDataEntity articleDataEntity) {
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

  ///构建文章item
  Widget _buildArticleItem(int index, ArticleData itemData) {
    return ArticleItem(
      itemData,
      isHomeShow: false,
      isClickUser: false,
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
