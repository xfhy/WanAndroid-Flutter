import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override //一般是需要下划线开头,然后后面加一个State
  State createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
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
              Container(
                color: Colors.deepOrange,
              ),
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.blue,
              ),
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
              icon: Icon(Icons.toys),
              title: Text('toys'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tap_and_play),
              title: Text("play"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              title: Text("landscape"),
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

/*class BottomNavigationDemo extends StatelessWidget {
  final appBarTitles = ['首页', '发现', '我的'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.colorPrimary, accentColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '首页',
            style: TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              title: Text(appBarTitles[0]),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.widgets),
              title: Text(appBarTitles[1]),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              title: Text(appBarTitles[2]),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}*/
