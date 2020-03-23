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

  ///一共有多少个数据  后端返回的
  int listTotalSize = 0;

  ///文章数据
  List<ArticleData> articleDataList = [];

  ///listview控制器
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;
      if (maxScroll == pixels && articleDataList.length < listTotalSize) {
        getArticleData();
      }
    });
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

    //正常展示数据
    Widget listView = ListView.builder(
      itemCount: articleDataList.length + 1,
      itemBuilder: (context, i) => buildItem(i),
      controller: _scrollController,
    );
    return RefreshIndicator(
      child: listView,
      onRefresh: _pullToRefresh,
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
  void getArticleData() async {
    //请求列表  顶部数据+下面的文章数据
    List<Future> requestList = [];
    if (pageIndex == 0) {
      requestList.add(dataUtils.getTopArticleData());
    }
    requestList.add(dataUtils.getArticleData(pageIndex));

    //所有请求都回来了,才执行后面的操作
    await Future.wait(requestList).then((List listData) {
      //需要将顶部数据List<ArticleData> 和 正常文章数据ArticleDataEntity中的datas进行合并,组成一个新的List
      if (listData == null) {
        return;
      }

      //更新state
      setState(() {
        //操作当前Widget的数据,必须放到setState中,不然可能不起效果!
        //操作当前Widget的数据,必须放到setState中,不然可能不起效果!
        //操作当前Widget的数据,必须放到setState中,不然可能不起效果!

        //第一页 清空数据
        if (pageIndex == 0) {
          articleDataList.clear();
        }

        //添加数据到集合中
        for (var value in listData) {
          if (value is List<ArticleData>) {
            //标记 置顶的数据
            articleDataList.addAll(value);
          } else if (value is ArticleDataEntity) {
            articleDataList.addAll(value.datas);
            listTotalSize = value.total;
          }
        }

        //页数+1
        pageIndex++;
      });
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

  ///刷新
  Future<void> _pullToRefresh() {
    pageIndex = 0;
    articleDataList.clear();
    loadData();
    return Future(() => LogUtil.d("lalala"));
  }
}
