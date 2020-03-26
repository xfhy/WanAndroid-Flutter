import 'package:flutter/material.dart';

import 'knowledge_page_data.dart';

///2020年03月26日22:53:21
///知识体系  作者的文章列表
///xfhy

class KnowledgePage extends StatefulWidget {
  int id;
  String author;

  KnowledgePage({this.id, this.author});

  @override
  State createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    KnowledgePageData pageData =
        ModalRoute.of(context).settings.arguments as KnowledgePageData;
    return Container();
  }
}
