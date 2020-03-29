import 'package:flutter/material.dart';
import 'package:wanandroidflutter/constant/app_colors.dart';
import 'package:wanandroidflutter/page/search/hot_search_widget.dart';
import 'package:wanandroidflutter/page/search/search_list_widget.dart';

///搜索页面
///2020年03月29日11:49:08
///xfhy
class SearchPage extends StatefulWidget {
  @override
  State createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  bool inputContentEmpty = true;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: _buildSearchField(),
        actions: _buildAppBarActions(),
      ),
      body: _buildContentBody(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      textInputAction: TextInputAction.search,
      //键盘按下enter键
      onSubmitted: (inputContent) {
        startSearch();
      },
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "搜索关键词",
        hintStyle: TextStyle(color: Colors.white),
      ),
      controller: _searchController,
    );
  }

  ///开始搜索
  void startSearch() {
    String inputContent = _searchController.text;
    setState(() {
      inputContentEmpty = (inputContent == null || inputContent == "");
    });
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          startSearch();
        },
      ),
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _searchController.clear();
          });
        },
      ),
    ];
  }

  Widget _buildContentBody() {
    return inputContentEmpty ? HotSearchWidget() : SearchResultWidget();
  }
}
