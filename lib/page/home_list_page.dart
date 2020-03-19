import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/data/http_util.dart';
import 'package:wanandroidflutter/util/log_util.dart';

///首页
class HomeListPage extends StatefulWidget {
  @override
  State createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Center(
        child: RaisedButton(
          child: Text('请求网络'),
          onPressed: () {
            var httpUtils = HttpUtils();
            httpUtils
                .get(Api.BASE_URL + Api.ARTICLE_LIST + "0/json")
                .then((value) {
              LogUtil.d(value.toString());
            });
          },
        ),
      ),
    );
  }
}
