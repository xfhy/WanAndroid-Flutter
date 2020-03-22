import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/widget/home_banner.dart';

import 'item/article_item.dart';

///首页
class HomeListPage extends StatefulWidget {
  @override
  State createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  var bannerData;
  HomeBanner _homeBanner;

  ///当前页index
  int pageIndex = 0;

  ///文章数据
  List<ArticleData> articleDataList = [];
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //当还没有加载出数据的时候,展示一个默认的加载器 loading
    if (bannerData == null || articleDataList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget listView = ListView.builder(
      itemCount: articleDataList.length + 1,
      itemBuilder: (context, i) => buildItem(i),
      controller: _scrollController,
    );
    //TODO 列表刷新
    return listView;
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

  void getArticleData() async {
    await Future.wait([
      dataUtils.getTopArticleData(),
      dataUtils.getArticleData(pageIndex)
    ]).then((List listData) {
      //需要将顶部数据List<ArticleData> 和 正常文章数据ArticleDataEntity中的datas进行合并,组成一个新的List
      for (var value in listData) {
        if (value is List<ArticleData>) {
          //标记 置顶的数据
          value.forEach((item) => item.isTop = true);
          articleDataList.addAll(value);
        } else if (value is ArticleDataEntity) {
          articleDataList.addAll(value.datas);
        }
      }
      setState(() {});
    });
  }

  ///构建item
  Widget buildItem(int index) {
    if (index == 0) {
      return Container(
        child: _homeBanner,
      );
    }
    index -= 1;
    ArticleData itemData = articleDataList[index];

    //构建item视图
    return ArticleItem(itemData);
  }
}
