import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/AppColors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/page/tree_page.dart';

import 'home_list_page.dart';
import 'myinfo_page.dart';

///主页面

class WanAndroidApp extends StatefulWidget {

  WanAndroidApp() {
    //初始化路由
    Routes.init();
  }

  //一般是需要下划线开头,然后后面加一个State
  @override
  State createState() => _WanAndroidAppState();
}

class _WanAndroidAppState extends State<WanAndroidApp> {
  var currentPage = 0;
  PageController _pageController;
  final appBarTitles = ['首页', '发现', '我的'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.colorPrimary, accentColor: Colors.blue),
      routes: Routes.routes,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[currentPage],
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: getBody(),
      ),
    );
  }

  getBody() {
    return Column(
      children: <Widget>[
        //上面把空间占满
        Expanded(
          //PageView类似于Android中的ViewPager
          child: PageView(
            children: <Widget>[
              HomeListPage(),
              TreePage(),
              MyInfoPage(),
            ],
            //设置controller,可以控制PageView的当前页
            controller: _pageController,
            //滑动的那种控制,
            // BouncingScrollPhysics是用来适用于
            // 允许滚动偏移超出内容范围，然后将内容反弹到那些范围边缘的环境的滚动物理。iOS上经常有这种效果
            physics: BouncingScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
        ),
        //下面的bottomNavigationBar
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(appBarTitles[0]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              title: Text(appBarTitles[1]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(appBarTitles[2]),
            ),
          ],
          onTap: (page) {
            //滑动到相应页面   curve是动画效果
            _pageController.animateToPage(page,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          },
          currentIndex: currentPage,
        ),
      ],
    );
  }
}
