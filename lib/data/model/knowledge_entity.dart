import 'package:wanandroidflutter/generated/json/base/json_convert_content.dart';

///知识体系
class KnowledgeEntity with JsonConvert<KnowledgeEntity> {
	List<Knowledgechild> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}

class Knowledgechild with JsonConvert<Knowledgechild> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
