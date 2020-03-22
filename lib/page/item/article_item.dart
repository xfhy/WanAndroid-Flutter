import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/args/route_web_page_data.dart';

///2020年03月22日22:01:38
///文章的item
///xfhy

class ArticleItem extends StatefulWidget {
  ArticleData itemData;

  ArticleItem(this.itemData);

  @override
  State createState() {
    return _ArticleItemState();
  }
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              child: Center(
                child: Icon(Icons.favorite_border),
              ),
            ),


            //右边   写成三行,标题+tag+底部那些信息   用好看的那个wanandroid的布局
            Column(
              children: <Widget>[
                Text(widget.itemData.title),
                //构建中间的tag
                _buildMiddleTags(),
              ],
            ),
          ],
        ),
        onTap: _onClickArticleItem,
      ),
    );
  }

  ///文章 item 点击事件
  void _onClickArticleItem() {
    RouteWebPageData pageData = new RouteWebPageData(
        id: widget.itemData.id,
        title: widget.itemData.title,
        url: widget.itemData.link);
    Navigator.pushNamed(context, Routes.webViewPage, arguments: pageData);
  }

  //构建中间的tag
  _buildMiddleTags() {
    //widget.itemData.tags
    //tag
    return Row(
      children: <Widget>[

      ],
    );
  }
}
