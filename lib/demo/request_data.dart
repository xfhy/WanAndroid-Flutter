import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/article_data_entity.dart';
import 'package:wanandroidflutter/util/log_util.dart';

void main() => runApp(RequestDemo());

class RequestDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: EdgeInsets.all(20.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
                  RaisedButton(
                    child: Text('获取文章'),
                    onPressed: () {
                      dataUtils.getArticleData(0);
                    },
                  ),
                  RaisedButton(
                    child: Text('获取置顶文章'),
                    onPressed: () {
                      dataUtils.getTopArticleData();
                    },
                  ),
                  RaisedButton(
                    child: Text('获取置顶文章和正常文章'),
                    onPressed: () {
                      getTopAndArticleList();
                    },
                  ),
                  RaisedButton(
                    child: Text('搜索作者文章'),
                    onPressed: () {
                      dataUtils.getAuthorArticleData("扔物线", 0);
                    },
                  ),
                  RaisedButton(
                    child: Text('分享人列表数据'),
                    onPressed: () {
                      dataUtils.getShareAuthorArticleData(2, 0);
                    },
                  ),
                  RaisedButton(
                    child: Text('登录'),
                    onPressed: () {
                      dataUtils.login("xxxxxxx415456465465", "xxxxxxx", context);
                    },
                  ),
                  RaisedButton(
                    child: Text('注册'),
                    onPressed: () {
                      dataUtils.register("xxxxxxx415456465465qqqqq", "xxxxxxx", context);
                    },
                  ),
                  RaisedButton(
                    child: Text('退出登录'),
                    onPressed: () {
                      dataUtils.loginOut();
                    },
                  ),
                  RaisedButton(
                    child: Text('收藏文章'),
                    onPressed: () {
                      LogUtil.d(sprintf("lg/collect/%s/json", [15615]));
                      dataUtils.collectArticle(12424);
                    },
                  ),
                  RaisedButton(
                    child: Text('取消收藏文章'),
                    onPressed: () {
                      dataUtils.cancelCollectArticle(12424);
                    },
                  ),
                  RaisedButton(
                    child: Text('收藏的文章列表'),
                    onPressed: () {
                      //LogUtil.d(sprintf("lg/collect/%s/json", [15615]));
                      dataUtils.getCollectArticles(0);
                    },
                  ),
                  RaisedButton(
                    child: Text('请求知识体系'),
                    onPressed: () {
                      dataUtils.getKnowledgeArticleData(60, 0);
                    },
                  ),
                  const Text('C'),
                  const Text('D'),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getTopAndArticleList() async {
    await Future.wait([dataUtils.getTopArticleData(), dataUtils.getArticleData(0)]).then((List listData) {
      //需要将顶部数据List<ArticleData> 和 正常文章数据ArticleDataEntity中的datas进行合并,组成一个新的List
      List<ArticleData> articleDataList = [];
      for (var value in listData) {
        if (value is List<ArticleData>) {
          articleDataList.addAll(value);
        } else if (value is ArticleDataEntity) {
          articleDataList.addAll(value.datas);
        }
      }
      LogUtil.d("合并数据成功了");
    });
  }
}
