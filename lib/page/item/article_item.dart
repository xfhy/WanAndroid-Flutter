import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/page/knowledge/knowledge_page.dart';
import 'package:wanandroidflutter/page/knowledge/knowledge_page_data.dart';
import 'package:wanandroidflutter/page/webview/route_web_page_data.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///2020年03月22日22:01:38
///文章的item
///xfhy

class ArticleItem extends StatefulWidget {
  final ArticleData itemData;

  ///是否为首页展示  如果是则可以点击进入知识体系
  final bool isHomeShow;

  ///是否可以点击作者,跳转作者的文章
  final bool isClickUser;

  //是否为我的收藏页  调用取消收藏的API不同
  final bool isMyFavoritePage;

  ArticleItem(
    this.itemData, {
    Key key,
    this.isHomeShow = true,
    this.isClickUser = true,
    this.isMyFavoritePage = false,
  }) : super(key: key);

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
                child: IconButton(
                  icon: Icon(ToolUtils.getNotNullBool(widget.itemData.collect) ? Icons.favorite : Icons.favorite_border),
                  color: ToolUtils.getNotNullBool(widget.itemData.collect) ? Colors.deepOrange : Colors.grey,
                  onPressed: collectArticle,
                ),
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
    RouteWebPageData pageData =
        new RouteWebPageData(id: widget.itemData.id, title: widget.itemData.title, url: widget.itemData.link, collect: widget.itemData.collect);
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
    if (widget.itemData.fresh != null && widget.itemData.fresh) {
      tagsList.add(ToolUtils.buildStrokeTagWidget('新', Colors.redAccent));
    }
    //加入 tag 标签
    if (widget.itemData.tags != null && widget.itemData.tags.length > 0) {
      tagsList.addAll(widget.itemData.tags.map((item) => ToolUtils.buildStrokeTagWidget(item.name, Colors.green)).toList());
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
      color: AppColors.colorPrimary,
      size: 20.0,
    ));

    //作者 或者  分享者
    infoList.add(
      GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(
              /*top: 10.0, bottom: 10.0,*/
              left: 5.0,
              right: 6.0),
          child: Text(
            ToolUtils.isNullOrEmpty(itemData.author) ? ToolUtils.getNotEmptyStr(itemData.shareUser) : itemData.author,
            //只展示一行
            maxLines: 1,
            //超出 展示...
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.isClickUser ? Colors.blue : Colors.black54,
              fontSize: 10.0,
            ),
          ),
        ),
        onTap: gotoAuthorListPage,
      ),
    );

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
        child: GestureDetector(
          child: Text(
            ToolUtils.getNotEmptyStr(itemData.superChapterName) + " / " + ToolUtils.getNotEmptyStr(itemData.chapterName),
            maxLines: 1,
            style: TextStyle(
              color: widget.isHomeShow ? Colors.blue : Colors.black54,
              fontSize: 10.0,
              decoration: TextDecoration.none,
            ),
          ),
          onTap: gotoKnowledgeArticleList,
        ),
      ),
    );

    return Row(
      children: infoList,
    );
  }

  //收藏文章
  void collectArticle() async {
    bool isLogin = await dataUtils.isLogin();
    if (!isLogin) {
      //未登录,跳转到登录界面
      Navigator.pushNamed(context, Routes.loginPage);
      return;
    }

    //已登录

    //之前已收藏  那么就是取消收藏
    if (ToolUtils.getNotNullBool(widget.itemData.collect)) {
      //这里区分一下  在我的收藏页调用取消收藏的接口 不一样
      if (widget.isMyFavoritePage) {
        await dataUtils.cancelCollectArticleForMyFavoritePage(widget.itemData.id, widget.itemData.originId == null ? "-1" : widget.itemData.originId);
      } else {
        await dataUtils.cancelCollectArticle(widget.itemData.id);
      }
      setState(() {
        widget.itemData.collect = false;
      });
      ToolUtils.showToast(msg: "取消收藏成功");
    } else {
      //收藏
      await dataUtils.collectArticle(widget.itemData.id);
      setState(() {
        widget.itemData.collect = true;
      });
      ToolUtils.showToast(msg: "收藏成功");
    }
  }

  ///查看作者文章  or  分享人的文章
  void gotoAuthorListPage() {
    if (widget.isClickUser) {
      //如果作者不为空，说明可以根据作者昵称查看文章 否则查看 分享人 列表数据
      if (widget.itemData.author == "") {
        KnowledgePageData knowledgePageData =
            KnowledgePageData(KnowledgePage.SHARE_AUTHOR_PAGE_TYPE, userId: widget.itemData.userId, title: widget.itemData.shareUser);
        Navigator.pushNamed(context, Routes.knowledgePage, arguments: knowledgePageData);
      } else {
        KnowledgePageData knowledgePageData =
            KnowledgePageData(KnowledgePage.AUTHOR_PAGE_TYPE, userId: widget.itemData.userId, title: widget.itemData.author);
        Navigator.pushNamed(context, Routes.knowledgePage, arguments: knowledgePageData);
      }
      LogUtil.d(widget.itemData.toString());
    }
  }

  ///跳转到 知识体系文章列表
  void gotoKnowledgeArticleList() {
    if (widget.isHomeShow) {
      KnowledgePageData knowledgePageData =
          KnowledgePageData(KnowledgePage.KNOWLEDGE_ARTICLE_PAGE_TYPE, title: widget.itemData.chapterName, cid: widget.itemData.chapterId);
      Navigator.pushNamed(context, Routes.knowledgePage, arguments: knowledgePageData);
    }
  }
}
