import 'package:wanandroidflutter/data/model/hot_key_entity.dart';

hotKeyEntityFromJson(HotKeyEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['link'] != null) {
		data.link = json['link']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotKeyEntityToJson(HotKeyEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['visible'] = entity.visible;
	return data;
}