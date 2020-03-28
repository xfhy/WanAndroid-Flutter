import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/item/article_item.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/widget/refresh/refresh_page.dart';

import 'knowledge_page_data.dart';

///2020年03月26日22:53:21
///知识体系  作者的文章列表
///xfhy

class KnowledgePage extends StatefulWidget {
  ///作者页面类型
  static const int AUTHOR_PAGE_TYPE = -1;

  ///分享人页面类型
  static const int SHARE_AUTHOR_PAGE_TYPE = -2;

  ///知识体系 文章 页面类型
  static const int KNOWLEDGE_ARTICLE_PAGE_TYPE = -3;

  @override
  State createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> with AutomaticKeepAliveClientMixin {
  int pageType;
  int userId;
  String title;
  int cid;

  @override
  bool get wantKeepAlive => true;

  ///构建文章item
  Widget buildArticleItem(int index, ArticleData itemData) {
    return ArticleItem(
      itemData,
      isHomeShow: false,
      isClickUser: false,
    );
  }

  Future<Map> getArticleData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    //组装一个json 方便刷新页page 那边取数据
    Map<String, dynamic> result = {"list": [], 'total': 0, 'pageIndex': pageIndex};

    if (KnowledgePage.AUTHOR_PAGE_TYPE == pageType) {
      //当前是展示作者的文章
      await dataUtils.getAuthorArticleData(title, pageIndex).then((ArticleDataEntity articleDataEntity) {
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
    } else if (KnowledgePage.SHARE_AUTHOR_PAGE_TYPE == pageType) {
      //当前是展示 分享人的文章
      await dataUtils.getShareAuthorArticleData(userId, pageIndex).then((ArticleDataEntity articleDataEntity) {
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
    } else if (KnowledgePage.KNOWLEDGE_ARTICLE_PAGE_TYPE == pageType) {
      //当前是展示 知识体系文章
      await dataUtils.getKnowledgeArticleData(cid, pageIndex).then((ArticleDataEntity articleDataEntity) {
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
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    //接收传递过来的参数
    KnowledgePageData pageData = ModalRoute.of(context).settings.arguments as KnowledgePageData;
    pageType = pageData.pageType;
    userId = pageData.userId;
    title = pageData.title;
    cid = pageData.cid;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: _pushBack,
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshPage(
              requestApi: getArticleData,
              renderItem: buildArticleItem,
            ),
          ),
        ],
      ),
    );
  }

  void _pushBack() {
    Navigator.pop(context);
  }
}
