import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/data/http_util.dart';
import 'package:wanandroidflutter/data/model/banner_data.dart';
import 'package:wanandroidflutter/util/log_util.dart';

import 'model/article_data_entity.dart';

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
    return datas.map((item) => BannerData.fromJson(item)).toList();
  }

  ///首页数据模块
  //获取首页最新文章数据
  Future<ArticleDataEntity> getArticleData(int pageIndex) async {
    //首先从服务端获取最外层的json数据的data
    var datas = await httpUtils.get(Api.ARTICLE_LIST + "$pageIndex/json");
    return ArticleDataEntity().fromJson(datas);
  }

  ///获取首页置顶文章数据
  Future<List<ArticleData>> getTopArticleData() async {
    List datas = await httpUtils.get(Api.ARTICLE_TO_LIST);
    return datas.map((item) => ArticleData().fromJson(item)).toList();
  }
}
