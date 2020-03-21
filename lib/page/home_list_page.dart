import 'package:flutter/material.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/widget/home_banner.dart';

///首页
class HomeListPage extends StatefulWidget {
  @override
  State createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  var bannerData;
  HomeBanner _homeBanner;

  @override
  void initState() {
    super.initState();
    getBannerData();
  }

  @override
  Widget build(BuildContext context) {
    //当还没有加载出数据的时候,展示一个默认的加载器 loading
    if (bannerData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: <Widget>[
        _homeBanner,
      ],
    );
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
}
