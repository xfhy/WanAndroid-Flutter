import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/widget/home_banner.dart';
import 'package:wanandroidflutter/widget/refresh/refresh_page.dart';

import 'item/article_item.dart';

///首页
class HomeListPage extends StatefulWidget {
  @override
  State createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage>
    with AutomaticKeepAliveClientMixin {
  var bannerData;
  HomeBanner _homeBanner;

  @override
  void initState() {
    super.initState();
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshPage(
            requestApi: getArticleData,
            renderItem: buildItem,
            /*headerView: _homeBanner,
            isHaveHeader: true,*/
          ),
        ),
      ],
    );
  }

  void loadData() {
    getBannerData();
    getArticleData();
  }

  void getBannerData() async {
    var datas = await dataUtils.getBannerData();
    if (datas != null) {
      setState(() {
        bannerData = datas;
        _homeBanner = HomeBanner(datas);
      });
    }
  }

  ///获取文章数据
  Future<Map> getArticleData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    //请求列表  顶部数据+下面的文章数据
    List<Future> requestList = [];
    if (pageIndex == 0) {
      requestList.add(dataUtils.getTopArticleData());
    }
    requestList.add(dataUtils.getArticleData(pageIndex));

    //组装一个json 方便刷新页page 那边取数据
    Map<String, dynamic> result;

    //所有请求都回来了,才执行后面的操作
    await Future.wait(requestList).then((List listData) {
      //需要将顶部数据List<ArticleData> 和 正常文章数据ArticleDataEntity中的datas进行合并,组成一个新的List
      if (listData == null) {
        result = {"list": listData, 'total': 0, 'pageIndex': pageIndex};
      } else {
        List<ArticleData> articleAllList = [];
        var totalCount = 0;

        //添加数据到集合中
        for (var value in listData) {
          if (value is List<ArticleData>) {
            //标记 置顶的数据
            articleAllList.addAll(value);
          } else if (value is ArticleDataEntity) {
            articleAllList.addAll(value.datas);
            //listTotalSize = value.total;
            totalCount = value.total;
          }
        }

        //页数+1
        pageIndex++;

        result = {
          "list": articleAllList,
          'total': totalCount,
          'pageIndex': pageIndex
        };
      }
    });

    return result;
  }

  ///构建item
  Widget buildItem(int index, ArticleData itemData) {
    if (index == 0) {
      return Container(
        child: _homeBanner,
      );
    }
    index -= 1;

    //构建item视图
    return ArticleItem(itemData);
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
