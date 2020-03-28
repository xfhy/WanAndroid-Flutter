import 'package:wanandroidflutter/generated/json/base/json_convert_content.dart';

///文章数据
///mixin 混入 可以重复代码,这里ArticleDataEntity可以有JsonConvert种的方法
class ArticleDataEntity with JsonConvert<ArticleDataEntity> {
  int curPage;
  List<ArticleData> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
}

class ArticleData with JsonConvert<ArticleData> {
  String apkLink;
  int audit;
  String author;
  bool canEdit;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String descMd;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int selfVisible;
  int shareDate;
  String shareUser;
  int superChapterId;
  String superChapterName;
  List<ArticleTags> tags;
  String title;
  ///type=1 是置顶数据
  int type;
  int userId;
  int visible;
  int zan;

  @override
  String toString() {
    return 'ArticleData{apkLink: $apkLink, audit: $audit, author: $author, canEdit: $canEdit, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, descMd: $descMd, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, niceShareDate: $niceShareDate, origin: $origin, prefix: $prefix, projectLink: $projectLink, publishTime: $publishTime, selfVisible: $selfVisible, shareDate: $shareDate, shareUser: $shareUser, superChapterId: $superChapterId, superChapterName: $superChapterName, tags: $tags, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }

}

class ArticleTags with JsonConvert<ArticleTags> {
  String name;
  String url;
}
