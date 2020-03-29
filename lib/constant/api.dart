class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";

  //玩Android api https://www.wanandroid.com/blog/show/2

  ///首页banner
  static const String BANNER = "banner/json";

  //首页文章列表 http://www.wanandroid.com/article/list/0/json
  // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60
  static const String ARTICLE_LIST = "article/list/";

  //置顶文章
  static const String ARTICLE_TO_LIST = "article/top/json";

  //登录
  static const String LOGIN = "user/login";

  //注册
  static const String REGISTER = "user/register";

  //退出登录
  static const String LOGIN_OUT = "user/logout/json";

  //收藏 站内文章
  static const String COLLECT_ARTICLE = "lg/collect/%s/json";
  //取消收藏文章
  static const String CANCEL_COLLECT_ARTICLE = "lg/uncollect_originId/%s/json";

  //收藏的文章列表
  static const String COLLECT_ARTICLE_LIST = "lg/collect/list/%s/json";
  //知识体系下面的文章
  static const String KNOWLEDGE_ARTICLE_LIST = "article/list/%s/json";
  //搜索
  static const String SEARCH = "article/query/%s/json";
  //热搜关键字
  static const String SEARCH_HOT_KEY = "hotkey/json";


}
