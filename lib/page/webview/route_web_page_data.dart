///2020年03月22日12:55:59
///传递给WebViewPage的数据
///xfhy

class RouteWebPageData {
  //页面id
  int id;

  //页面标题
  String title;

  //url
  String url;

  //是否收藏
  bool collect;

  RouteWebPageData({this.id = -1, this.title, this.url, this.collect = false});
}
