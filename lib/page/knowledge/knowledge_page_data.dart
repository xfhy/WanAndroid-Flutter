///2020年03月26日22:57:21
///传递给KnowledgePage的数据
///xfhy

class KnowledgePageData {
  ///页面类型
  int pageType;
  int userId;
  //作者名称 or  分享人名称
  String author;

  KnowledgePageData(this.pageType, this.userId, this.author);
}
