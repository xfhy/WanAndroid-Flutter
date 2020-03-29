import 'package:wanandroidflutter/generated/json/base/json_convert_content.dart';

///热搜关键词
///2020年03月29日15:44:54
///xfhy
class HotKeyEntity with JsonConvert<HotKeyEntity> {
	int id;
	String link;
	String name;
	int order;
	int visible;
}
