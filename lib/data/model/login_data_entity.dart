import 'package:wanandroidflutter/generated/json/base/json_convert_content.dart';

class LoginDataEntity with JsonConvert<LoginDataEntity> {
  bool admin;
  List<dynamic> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;
}
