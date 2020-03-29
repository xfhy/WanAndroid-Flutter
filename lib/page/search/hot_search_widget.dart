import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/hot_key_entity.dart';
import 'package:wanandroidflutter/util/log_util.dart';

///热搜
///2020年03月29日15:28:59
///xfhy

class HotSearchWidget extends StatefulWidget {
  @override
  State createState() {
    return _HotSearchWidgetState();
  }
}

class _HotSearchWidgetState extends State<HotSearchWidget> {
  List<Widget> hotKeyWidgets = List();

  @override
  void initState() {
    super.initState();
    loadSearchHotKeys();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '热搜关键词',
            style: TextStyle(color: AppColors.colorPrimary, fontSize: 18.0),
          ),
        ),

        //流式布局
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Wrap(
            //主轴方向上的间距
            spacing: 5.0,
            runSpacing: 5.0,
            children: hotKeyWidgets,
          ),
        ),
      ],
    );
  }

  ///获取热搜关键词
  void loadSearchHotKeys() async {
    List<HotKeyEntity> kotKeys = await dataUtils.getSearchHotKeys();
    if (mounted) {
      setState(() {
        hotKeyWidgets.clear();
        if (kotKeys == null || kotKeys.length == 0) {
          hotKeyWidgets.add(getActionChip("暂无数据"));
        } else {
          for (HotKeyEntity value in kotKeys) {
            ActionChip actionChip = getActionChip(value.name);
            hotKeyWidgets.add(actionChip);
          }
        }
      });
    }
  }

  //构建item  标签
  ActionChip getActionChip(String text) {
    return ActionChip(
      backgroundColor: AppColors.colorPrimary,
      label: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        LogUtil.d("跳转搜索详情页");
        Navigator.pushNamed(context, Routes.searchResultPage, arguments: text);
      },
    );
  }
}
