import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/util/tool_utils.dart';

///2020年04月03日21:18:12
///关于作者
///xfhy

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolUtils.getCommonAppBar(context, "关于作者"),
      body: ListView(
        children: <Widget>[
          //头像
          buildAvatar(),
          buildAboutItem("GitHub地址", "这个项目是我在学习Flutter之后,写的练手项目.功能还是比较完善,基本把WanAndroid核心功能都实现了", "https://github.com/xfhy/WanAndroid-Flutter"),
          buildAboutItem("CSDN", "一名Android菜鸟的进阶之路", "https://blog.csdn.net/xfhy_"),
          buildAboutItem("掘金", "一名Android菜鸟", "https://juejin.im/user/5983fc6b6fb9a03c5539c8bb"),
        ],
      ),
    );
  }

  ///构建头像
  Widget buildAvatar() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: 200,
        height: 200,
        child: Image.network("https://i.loli.net/2018/11/09/5be4f534dd326.jpg"),
      ),
    );
  }

  buildAboutItem(String title, String content, String url) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    content,
                    style: TextStyle(color: Colors.black54, fontSize: 13.0),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.colorPrimary,
            ),
          ],
        ),
      ),
      onTap: () async {
        ///用系统浏览器打开
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          ToolUtils.showToast(msg: "打开浏览器失败");
        }
      },
    );
  }
}
