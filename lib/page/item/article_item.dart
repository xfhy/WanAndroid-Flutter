import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/args/route_web_page_data.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

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
    List<Widget> rightWidgetList = [];

    rightWidgetList.add(
      Text(
        ToolUtils.signToStr(widget.itemData.title),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        //只展示一行
        maxLines: 1,
        //超出一行 显示...
        overflow: TextOverflow.ellipsis,
      ),
    );

    //构建中间的tag
    var tagsList = _buildMiddleTags();
    if (tagsList != null) {
      rightWidgetList.add(tagsList);
    }

    //底部的作者 时间 等信息
    rightWidgetList.add(_buildBottomInfo());

    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      //加了InkWell 点击有水波纹效果
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rightWidgetList,
              ),
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
    List<Widget> tagsList = [];
    //加入置顶标签
    if (1 == widget.itemData.type) {
      tagsList.add(ToolUtils.buildStrokeTagWidget('置顶', Colors.redAccent));
    }
    //加入 新 标签
    if (widget.itemData.fresh) {
      tagsList.add(ToolUtils.buildStrokeTagWidget('新', Colors.redAccent));
    }
    //加入 tag 标签
    if (widget.itemData.tags.length > 0) {
      tagsList.addAll(widget.itemData.tags
          .map(
              (item) => ToolUtils.buildStrokeTagWidget(item.name, Colors.green))
          .toList());
    }
    if (tagsList.length > 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
        child: Row(
          children: tagsList,
        ),
      );
    } else {
      return Container(
        height: 18,
      );
    }
  }

  Widget _buildBottomInfo() {
    List<Widget> infoList = [];
    var itemData = widget.itemData;

    //图标
    infoList.add(Icon(
      itemData.author == "" ? Icons.folder_shared : Icons.person,
      size: 20.0,
    ));

    //作者 或者  分享者
    infoList.add(Padding(
      padding: EdgeInsets.only(
          /*top: 10.0, bottom: 10.0,*/
          left: 5.0,
          right: 6.0),
      child: Text(
        itemData.author == "" ? itemData.shareUser : itemData.author,
        //只展示一行
        maxLines: 1,
        //超出 展示...
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 10.0,
        ),
      ),
    ));

    //时间
    infoList.add(Expanded(
      child: Text(
        '时间: ' + ToolUtils.getFirstDate(itemData.niceDate),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 10.0,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ));

    //chapter 分类
    infoList.add(
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          itemData.superChapterName + " / " + itemData.chapterName,
          maxLines: 1,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 10.0,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );

    return Row(
      children: infoList,
    );
  }
}
