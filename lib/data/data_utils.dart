import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wanandroidflutter/common/application.dart';
import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/constant/constants.dart';
import 'package:wanandroidflutter/data/http_util.dart';
import 'package:wanandroidflutter/data/model/banner_data.dart';
import 'package:wanandroidflutter/util/log_util.dart';
import 'package:wanandroidflutter/util/shared_preferences.dart';

import 'model/article_data_entity.dart';
import 'model/login_data_entity.dart';

///数据获取帮助类
///2020年03月21日15:16:55
///xfhy
///dart 单例: 使用static变量+工厂构造函数的方式,可以保证new DataUtils始终返回都是同一个实例

DataUtils dataUtils = DataUtils();

class DataUtils {
  //私有构造函数
  DataUtils._internal();

  //保存单例
  static DataUtils _singleton = new DataUtils._internal();

  //工厂构造函数
  //当实现一个使用 factory 关键词修饰的构造函数时，这个构造函数不必创建类的新实例。
  //当实现构造函数但是不想每次都创建该类的一个实例的时候使用
  factory DataUtils() => _singleton;

  ///首页数据模块
  //获取首页banner数据
  //在Future一个函数内,加了async的,会同步执行的.先等前面的执行完再执行后面的.
  Future<List<BannerData>> getBannerData() async {
    //首先从服务端获取最外层的json数据的data
    List datas = await httpUtils.get(Api.BANNER);
    //然后将data(list)解析成一个一个的BannerData对象,然后组装成list
    return datas == null ? null : datas.map((item) => BannerData.fromJson(item)).toList();
  }

  ///首页数据模块
  //获取首页最新文章数据
  Future<ArticleDataEntity> getArticleData(int pageIndex) async {
    //首先从服务端获取最外层的json数据的data
    var datas = await httpUtils.get(Api.ARTICLE_LIST + "$pageIndex/json");
    return datas == null ? null : ArticleDataEntity().fromJson(datas);
  }

  ///获取首页置顶文章数据
  Future<List<ArticleData>> getTopArticleData() async {
    List datas = await httpUtils.get(Api.ARTICLE_TO_LIST);
    return datas == null ? null : datas.map((item) => ArticleData().fromJson(item)).toList();
  }

  // 按照作者昵称搜索文章(点击文章作者头像)
  Future<ArticleDataEntity> getAuthorArticleData(String author, int pageIndex) async {
    String path = 'article/list/$pageIndex/json';
    Map<String, dynamic> params = {"author": author};
    var datas = await httpUtils.get(path, params: params);
    return datas == null ? null : ArticleDataEntity().fromJson(datas);
  }

  // 获取分享人的列表数据
  Future<ArticleDataEntity> getShareAuthorArticleData(int userId, int pageIndex) async {
    String path = 'user/$userId/share_articles/$pageIndex/json';
    var datas = await httpUtils.get(path);
    var articleData = datas['shareArticles'];
    return articleData == null ? null : ArticleDataEntity().fromJson(articleData);
  }

  //登录
  Future<LoginDataEntity> login(String userName, String password, BuildContext context) async {
    FormData formData = FormData.fromMap({"username": userName, "password": password});
    var data = await httpUtils.post(Api.LOGIN, formData: formData, isAddLoading: true, context: context, loadingText: "正在登录...");
    //登录失败,则为null
    LogUtil.d(data);
    if (data != null) {
      Application.isLogin = true;
    }
    return data == null ? null : LoginDataEntity().fromJson(data);
  }

  //退出登录
  Future loginOut() async {
    var data = await httpUtils.get(Api.LOGIN_OUT);
    //LogUtil.d(data);
    //return data == null ? null : LoginDataEntity().fromJson(data);
    Application.isLogin = false;
    return data;
  }

  ///收藏文章  articleId:文章id
  Future collectArticle(int articleId) async {
    //https://www.wanandroid.com/lg/collect/1165/json
    //格式化语法 使用了一个三方库才能格式化 print(sprintf("%s %s", ["Hello", "World"]));
    var data = await httpUtils.post(sprintf(Api.COLLECT_ARTICLE, [articleId]));
    //LogUtil.d(data);
    return data;
  }

  //取消收藏文章
  Future cancelCollectArticle(int articleId) async {
    var data = await httpUtils.post(sprintf(Api.CANCEL_COLLECT_ARTICLE, [articleId]));
    //LogUtil.d(data);
    return data;
  }

  ///获取收藏文章列表
  Future<ArticleDataEntity> getCollectArticles(int pageIndex) async {
    var data = await httpUtils.get(sprintf(Api.COLLECT_ARTICLE_LIST, [pageIndex]));
    //LogUtil.d(data);
    return data == null ? null : ArticleDataEntity().fromJson(data);
  }

  //设置登录状态
  void setLoginState(bool isLogin) {
    spUtil.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY, isLogin);
  }

  ///当前是否已经登录
  Future<bool> isLogin() {
    return spUtil.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }
}
