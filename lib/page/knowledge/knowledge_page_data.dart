///2020年03月26日22:57:21
///传递给KnowledgePage的数据
///xfhy

class KnowledgePageData {
  ///页面类型
  int pageType;
  int userId;

  //知识体系的id
  int cid;

  //作者名称 or  分享人名称 or 知识体系
  String title;

  KnowledgePageData(this.pageType, {this.userId, this.title, this.cid});
}
