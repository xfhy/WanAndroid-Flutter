import 'package:wanandroidflutter/data/model/article_data_entity.dart';

articleDataEntityFromJson(ArticleDataEntity data, Map<String, dynamic> json) {
	if (json['curPage'] != null) {
		data.curPage = json['curPage']?.toInt();
	}
	if (json['datas'] != null) {
		data.datas = new List<ArticleData>();
		(json['datas'] as List).forEach((v) {
			data.datas.add(new ArticleData().fromJson(v));
		});
	}
	if (json['offset'] != null) {
		data.offset = json['offset']?.toInt();
	}
	if (json['over'] != null) {
		data.over = json['over'];
	}
	if (json['pageCount'] != null) {
		data.pageCount = json['pageCount']?.toInt();
	}
	if (json['size'] != null) {
		data.size = json['size']?.toInt();
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> articleDataEntityToJson(ArticleDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['curPage'] = entity.curPage;
	if (entity.datas != null) {
		data['datas'] =  entity.datas.map((v) => v.toJson()).toList();
	}
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}

articleDataDataFromJson(ArticleData data, Map<String, dynamic> json) {
	if (json['apkLink'] != null) {
		data.apkLink = json['apkLink']?.toString();
	}
	if (json['audit'] != null) {
		data.audit = json['audit']?.toInt();
	}
	if (json['author'] != null) {
		data.author = json['author']?.toString();
	}
	if (json['canEdit'] != null) {
		data.canEdit = json['canEdit'];
	}
	if (json['chapterId'] != null) {
		data.chapterId = json['chapterId']?.toInt();
	}
	if (json['chapterName'] != null) {
		data.chapterName = json['chapterName']?.toString();
	}
	if (json['collect'] != null) {
		data.collect = json['collect'];
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId']?.toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	if (json['descMd'] != null) {
		data.descMd = json['descMd']?.toString();
	}
	if (json['envelopePic'] != null) {
		data.envelopePic = json['envelopePic']?.toString();
	}
	if (json['fresh'] != null) {
		data.fresh = json['fresh'];
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['link'] != null) {
		data.link = json['link']?.toString();
	}
	if (json['niceDate'] != null) {
		data.niceDate = json['niceDate']?.toString();
	}
	if (json['niceShareDate'] != null) {
		data.niceShareDate = json['niceShareDate']?.toString();
	}
	if (json['origin'] != null) {
		data.origin = json['origin']?.toString();
	}
	if (json['prefix'] != null) {
		data.prefix = json['prefix']?.toString();
	}
	if (json['projectLink'] != null) {
		data.projectLink = json['projectLink']?.toString();
	}
	if (json['publishTime'] != null) {
		data.publishTime = json['publishTime']?.toInt();
	}
	if (json['selfVisible'] != null) {
		data.selfVisible = json['selfVisible']?.toInt();
	}
	if (json['shareDate'] != null) {
		data.shareDate = json['shareDate']?.toInt();
	}
	if (json['shareUser'] != null) {
		data.shareUser = json['shareUser']?.toString();
	}
	if (json['superChapterId'] != null) {
		data.superChapterId = json['superChapterId']?.toInt();
	}
	if (json['superChapterName'] != null) {
		data.superChapterName = json['superChapterName']?.toString();
	}
	if (json['tags'] != null) {
		data.tags = new List<dynamic>();
		data.tags.addAll(json['tags']);
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	if (json['zan'] != null) {
		data.zan = json['zan']?.toInt();
	}
	return data;
}

Map<String, dynamic> articleDataDataToJson(ArticleData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['apkLink'] = entity.apkLink;
	data['audit'] = entity.audit;
	data['author'] = entity.author;
	data['canEdit'] = entity.canEdit;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['collect'] = entity.collect;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['descMd'] = entity.descMd;
	data['envelopePic'] = entity.envelopePic;
	data['fresh'] = entity.fresh;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['niceShareDate'] = entity.niceShareDate;
	data['origin'] = entity.origin;
	data['prefix'] = entity.prefix;
	data['projectLink'] = entity.projectLink;
	data['publishTime'] = entity.publishTime;
	data['selfVisible'] = entity.selfVisible;
	data['shareDate'] = entity.shareDate;
	data['shareUser'] = entity.shareUser;
	data['superChapterId'] = entity.superChapterId;
	data['superChapterName'] = entity.superChapterName;
	if (entity.tags != null) {
		data['tags'] =  [];
	}
	data['title'] = entity.title;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	return data;
}