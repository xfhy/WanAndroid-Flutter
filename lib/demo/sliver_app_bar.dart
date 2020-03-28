import 'package:flutter/material.dart';

///SliverAppBar 效果
///2020年03月28日08:00:19
///xfhy

void main() => runApp(MySliverApp());

class MySliverApp extends StatefulWidget {
  @override
  State createState() {
    return _MySliverAppState();
  }
}

class _MySliverAppState extends State<MySliverApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 230.0,
              floating: false,
              pinned: true,
              snap: false,
              //滑动时 标题上移效果
              flexibleSpace: FlexibleSpaceBar(
                title: Text('标题标题标题'),
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                //背景图
                background: Image.asset(
                  "images/ic_zone_background.webp",
                  fit: BoxFit.cover,
                ),
              ),
              //返回按钮
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              //右边按钮区域
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print("添加");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    print("更多");
                  },
                ),
              ],
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text("Item $index"),
                ),
                childCount: 88,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
