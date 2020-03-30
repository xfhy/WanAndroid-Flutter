import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/constant/routes.dart';
import 'package:wanandroidflutter/data/data_utils.dart';
import 'package:wanandroidflutter/data/model/knowledge_entity.dart';

///知识体系 发现
class KnowledgeSystemPage extends StatefulWidget {
  @override
  State createState() => _KnowledgeSystemPageState();
}

class _KnowledgeSystemPageState extends State<KnowledgeSystemPage> with AutomaticKeepAliveClientMixin {
  List<KnowledgeEntity> knowledgeEntityList = [];

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    super.initState();
    loadKnowledgeData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: buildTreeItems(),
    );
  }

  ///加载知识体系数据
  void loadKnowledgeData() async {
    await dataUtils.getKnowledgeSystem().then((list) {
      if (list == null || list.length == 0) {
        //数据加载失败
      } else {
        if (mounted) {
          setState(() {
            knowledgeEntityList = list;
          });
        }
      }
    });
  }

  List<Widget> buildTreeItems() {
    if (knowledgeEntityList == null || knowledgeEntityList.length == 0) {
      return [
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(
                  color: AppColors.colorPrimary,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '正在加载...',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    } else {
      List<Widget> widgets = [];
      for (KnowledgeEntity knowledgeEntity in knowledgeEntityList) {
        //分组的标题
        widgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            knowledgeEntity.name,
            style: TextStyle(color: AppColors.colorPrimary, fontSize: 18.0),
          ),
        ));

        //流式布局
        widgets.add(Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Wrap(
            //主轴方向上的间距
            spacing: 5.0,
            runSpacing: 5.0,
            children: buildTreeChildItems(knowledgeEntity.children),
          ),
        ));
      }
      return widgets;
    }
  }

  List<Widget> buildTreeChildItems(List<KnowledgeChild> childrenList) {
    List<Widget> widgets = [];
    if (childrenList != null || childrenList.length > 0) {
      for (KnowledgeChild knowledgeChild in childrenList) {
        ActionChip actionChip = getActionChip(knowledgeChild);
        widgets.add(actionChip);
      }
    } else {
      //分组内无数据
      var child = KnowledgeChild();
      child.name = "暂无数据";
      widgets.add(getActionChip(child));
    }
    return widgets;
  }

  //构建item  标签
  ActionChip getActionChip(KnowledgeChild knowledgeChild) {
    return ActionChip(
      backgroundColor: Colors.blue,
      label: Text(
        knowledgeChild.name,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        //todo xfhy 将cid 传入知识体系列表页
        //Navigator.pushNamed(context, Routes.searchResultPage, arguments: text);
      },
    );
  }
}
