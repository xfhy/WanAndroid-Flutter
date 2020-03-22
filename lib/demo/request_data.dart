import 'package:flutter/material.dart';
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
    await Future.wait(
            [dataUtils.getTopArticleData(), dataUtils.getArticleData(0)])
        .then((List listData) {
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
