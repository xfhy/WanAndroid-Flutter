import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroidflutter/common/application.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/model/banner_data.dart';
import 'package:wanandroidflutter/page/args/route_web_page_data.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///首页的banner
///2020年03月21日21:08:20
///xfhy

class HomeBanner extends StatefulWidget {
  List<BannerData> bannerList;

  HomeBanner({this.bannerList, Key key}) : super(key: key) {
    if (bannerList == null) {
      bannerList = [];
    }
  }

  @override
  State createState() {
    return _HomeBannerState();
  }

  void setBannerData(List<BannerData> bannerList) {
    this.bannerList = bannerList;
    if (this.bannerList == null) {
      this.bannerList = null;
    }
  }
}

///数据 事件
class BannerDataEvent {
  List<BannerData> bannerList;

  BannerDataEvent(this.bannerList);
}

class _HomeBannerState extends State<HomeBanner> {
  int _realIndex = 1;
  int virtualIndex = 0;
  PageController _pageController;
  Timer _timer;

  @override
  void initState() {
    super.initState();
//    LogUtil.d('initState');
    _pageController = PageController(initialPage: _realIndex);
    //周期性的计时
    _timer = createAndStartTimer();

    //监听事件总线上数据变化
    Application.eventBus.on<BannerDataEvent>().listen((event) {
      setState(() {
        widget.bannerList = event.bannerList;
        if (widget.bannerList == null) {
          widget.bannerList = [];
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bannerList.length == 0) {
      stopTimer();
      return Container();
    } else {
      if (_timer == null) {
        _timer = createAndStartTimer();
      }
      return Container(
        height: 226.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //一个类似ViewPager的PageView+小圆点+右上角索引
            //1. PageView
            PageView(
              controller: _pageController,
              //当从一个page滑动到另一个page的时候会回调
              onPageChanged: _onPageChanged,
              children: _buildItems(),
            ),

            //2. 小圆点
            _buildIndicator(),

            //3. 定位
            Positioned(
              top: 0.0,
              right: 0.0,
              child: _numberIndicator(
                  context, virtualIndex, widget.bannerList.length),
            ),
          ],
        ),
      );
    }
  }

  ///当从一个page滑动到另一个page的时候会回调
  ///模拟无限滚动   d abcd a
  void _onPageChanged(int index) {
    _realIndex = index;
    int count = widget.bannerList.length;
    if (index == 0) {
      virtualIndex = count - 1;
      _pageController.jumpToPage(count);
    } else if (index == count + 1) {
      virtualIndex = 0;
      _pageController.jumpToPage(1);
    } else {
      virtualIndex = index - 1;
    }
    setState(() {});
  }

  ///构建PageView的childs
  _buildItems() {
    if (widget.bannerList.length == 0) {
      return [Container()];
    }
    List<Widget> childWidget = [];
    //头部添加一个尾部Item,模拟循环
    childWidget
        .add(_buildBannerItem(widget.bannerList[widget.bannerList.length - 1]));
    for (var bannerData in widget.bannerList) {
      childWidget.add(_buildBannerItem(bannerData));
    }
    // 尾部 添加上第一个
    childWidget.add(_buildBannerItem(widget.bannerList[0]));
    return childWidget;
  }

  ///构建某一个item
  Widget _buildBannerItem(BannerData bannerData) {
    //用GestureDetector包装一下,才能设置点击事件
    return GestureDetector(
      onTap: () {
        _onClickBanner(bannerData);
      },
      child: Stack(
        //未定位widget占满Stack整个空间
        fit: StackFit.expand,
        children: <Widget>[
          //banner图片
          Image.network(
            bannerData.imagePath,
            fit: BoxFit.cover,
          ),
          _buildItemTitle(bannerData.title),
        ],
      ),
    );
  }

  ///构建banner中的标题和背景
  _buildItemTitle(String title) {
    return Container(
      //整个banner的渐变色
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: const Alignment(0.0, -0.8),
        colors: [const Color(0xa0000000), Colors.transparent],
      )),
      //标题对齐方式
      alignment: Alignment.bottomCenter,
      child: Container(
        //底部标题的margin
        margin: EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
        //标题
        child: Text(
          ToolUtils.signToStr(title),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  ///banner底部小圆点
  _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < widget.bannerList.length; i++) {
      indicators.add(Container(
        width: 6.0,
        height: 6.0,
        margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 10.0),
        //修饰
        decoration: BoxDecoration(
            //shape
            shape: BoxShape.circle,
            color: i == virtualIndex ? Colors.white : Colors.grey),
      ));
    }
    //小圆点  放成一行,放中间
    return Row(
      //主轴
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  //构建右上角的角标
  _numberIndicator(BuildContext context, int index, int itemCount) {
    //展示: 1/4  这种效果
    return Container(
      //一般用于背景的效果
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text(
        "${++index}/${itemCount}",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///banner item 点击事件
  void _onClickBanner(BannerData bannerData) {
    RouteWebPageData pageData = new RouteWebPageData(
        id: bannerData.id, title: bannerData.title, url: bannerData.url);
    Navigator.pushNamed(context, Routes.webViewPage, arguments: pageData);
  }

  void stopTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
  }

  Timer createAndStartTimer() {
    return Timer.periodic(Duration(seconds: 5), (timer) {
      //计时然后滑动
      _pageController.animateToPage(_realIndex + 1,
          //线性的动画
          duration: Duration(milliseconds: 300),
          curve: Curves.linear);
    });
  }
}
