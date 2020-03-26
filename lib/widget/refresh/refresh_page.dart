import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanandroidflutter/constant/AppColors.dart';
import 'package:wanandroidflutter/util/log_util.dart';

///专门用于刷新的列表page
///2020年03月24日21:24:03
///xfhy
class RefreshPage extends StatefulWidget {
  // 页面列表展示类型
  //普通 listview 类型
  static const String LIST_PAGE_TYPE = 'list_page_type';

  // 瀑布流 类型
  static const String STAGGERED_GRID_PAGE_TYPE = 'staggered_grid_page_type';

  // ExpansionPanelList
  static const String EXPANSION_PANEL_LIST_PAGE_TYPE =
      'expansion_panel_list_page_type';

  ///模块item 的Widget
  final renderItem;

  ///数据获取方法
  final requestApi;

  ///头部
  final headerView;

  //是否需要添加头部 默认是不添加
  final bool isHaveHeader;

  //是否支持下拉刷新  默认可以下拉刷新
  final bool isCanRefresh;

  //是否支持上拉加载更多  默认可以
  final bool isCanLoadMore;

  //是否需要ScrollController
  final bool isNeedController;

  //页面展示类型
  final String pageType;

  //设置pageIndex 默认是0
  final int startIndex;

  RefreshPage(
      {@required this.renderItem,
      @required this.requestApi,
      this.headerView,
      this.isHaveHeader = false,
      this.isCanRefresh = true,
      this.isCanLoadMore = true,
      this.isNeedController = true,
      this.pageType = LIST_PAGE_TYPE,
      this.startIndex = 0})
      : assert(renderItem is Function),
        assert(requestApi is Function),
        super();

  @override
  State createState() {
    return _RefreshPageState();
  }
}

class _RefreshPageState extends State<RefreshPage> {
  //是否正在请求数据
  bool isLoading = false;

  //是否还有更多数据可加载
  bool _hasMore = true;

  //当前页索引
  int _pageIndex = 0;

  //一共多少页
  int _pageTotal = 0;

  //数据
  List items = [];

  //controller  可以监听
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //第一次进入  加载数据  初始化页面索引 默认是0
    _pageIndex = widget.startIndex;
    //加载数据
    _getMoreData();
    //判断是否滑动到了列表最底部 && 有更多数据 && 可加载更多
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) &&
          _hasMore &&
          widget.isCanLoadMore) {
        _getMoreData();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNeedController) {
      return widget.isCanRefresh
          ? RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _getItem(index);
                },
                //保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
                physics: const AlwaysScrollableScrollPhysics(),
                //根据状态返回绘制 item 数量
                itemCount: _getListCount(),
                //便于监听  方便上拉加载更多
                controller: _scrollController,
              ),
              //下拉刷新
              onRefresh: _handleRefresh,
              //指示器颜色
              color: AppColors.colorPrimary,
            )
          : ListView.builder(
              //不支持下拉刷新  直接返回
              itemBuilder: (context, index) {
                return _getItem(index);
              },
              //item数量
              itemCount: _getListCount(),
              //监听
              controller: _scrollController,
            );
    } else {
      return ListView.builder(
        //不支持下拉刷新  则直接返回listview
        itemBuilder: (context, index) {
          return _getItem(index);
        },
        //根据状态绘制item 数量
        itemCount: _getListCount(),
      );
    }
  }

  ///加载更多 (ListView到达底部)
  Future _getMoreData() async {
    LogUtil.d("上拉加载更多,或第一次加载");
    if (!isLoading && _hasMore) {
      //如果上一次异步请求数据完成  同时有数据可以加载

      //1. mounted 后  设置isLoading的数据,更新Widget 让loading的Widget展示出来
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      //2. 请求网络 加载数据
      List newEntries = await makeHttpRequest(false);

      //3. 加载完成  刷新界面
      if (mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
    } else if (!isLoading && !_hasMore) {
      //没有在加载  并且没有更多数据   此时
      _pageIndex = widget.startIndex;
    }
  }

  Future<List> makeHttpRequest(bool isRefresh) async {
    if (widget.requestApi is Function) {
      Map listObj = new Map<String, dynamic>();
      if (isRefresh) {
        //下拉刷新
        listObj = await widget.requestApi({'pageIndex': widget.startIndex});
      } else {
        //上拉加载更多
        listObj = await widget.requestApi({'pageIndex': _pageIndex});
      }
      _pageIndex = listObj['pageIndex'];
      _pageTotal = listObj['total'];
      //判断是否还能加载更多 并且 判断pageNum是否为 1
      _hasMore = ((widget.startIndex == 1)
          ? _pageIndex <= _pageTotal
          : _pageIndex < _pageTotal);
      return listObj['list'];
    } else {
      //参数有问题  延迟2秒  返回空list
      return Future.delayed(Duration(seconds: 2), () {
        return [];
      });
    }
  }

  ///根据配置状态返回实际列表数量
  int _getListCount() {
    if (widget.isCanLoadMore) {
      //支持加载更多{
      ///是否需要头部
      if (widget.isHaveHeader) {
        ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
        ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
        return (items.length > 0) ? items.length + 2 : items.length + 1;
      } else {
        ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
        if (items.length == 0) {
          return 1;
        }

        ///如果有数据,因为不加载更多选项，需要对列表数据总数+1
        return (items.length > 0) ? items.length + 1 : items.length;
      }
    } else {
      //没有上拉加载更多
      if (widget.isHaveHeader) {
        ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
        return (items.length > 0) ? items.length + 1 : items.length;
      } else {
        ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
        if (items.length == 0) {
          return 1;
        }

        /// 正常数据
        return items.length;
      }
    }
  }

  ///根据配置状态返回实际列表渲染Item
  Widget _getItem(int index) {
    if (!widget.isHaveHeader && index == items.length && items.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.isHaveHeader &&
        index == _getListCount() - 1 &&
        items.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.isHaveHeader && index == 0 && items.length != 0) {
      ///如果需要头部，并且数据不为0，当index =0 ，渲染头部
      return widget.headerView();
    } else if (!widget.isHaveHeader && items.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      if (isLoading) {
        return _buildIsLoading();
      } else {
        return _buildEmptyError();
      }
    } else if (widget.isHaveHeader && items.length == 0) {
      ///如果需要头部，并且数据为0，渲染loading 面
      if (isLoading) {
        return _buildIsLoading();
      } else {
        return _buildEmptyError();
      }
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index，如果有头部 index 减一 保持不会忽略 index = 0 的数据
      return widget.renderItem(
          index, items[widget.isHaveHeader ? index - 1 : index]);
    }
  }

  ///空页面  错误 页面 empty error
  Widget _buildEmptyError() {
    return Container(
      //获取屏幕宽度
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("获取数据为空或页面加载失败！！"),
          RaisedButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text("重新加载"),
            onPressed: () {
              if (mounted) {
                //mounted == true  保证 当前widget 状态可以更新
                setState(() {
                  items.clear();
                  isLoading = false;
                  _hasMore = true;
                  _pageIndex = widget.startIndex;
                });
                _getMoreData();
              }
            },
          )
        ],
      ),
    );
  }

  ///上拉加载更多 Widget
  Widget _buildProgressIndicator() {
    return _hasMore
        ? Container(
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
          )
        : Container(
            child: Center(
              //是否超出一页  简单判断
              child: (items.length) > 8
                  ? Text(
                      '客官,没有数据了~',
                      style: TextStyle(color: Colors.black54, fontSize: 15.0),
                    )
                  : Text(''),
            ),
          );
  }

  ///  loading
  Widget _buildIsLoading() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              //均匀分配
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SpinKitCubeGrid(
                  size: 55.0,
                  color: AppColors.colorPrimary,
                  duration: Duration(milliseconds: 800),
                ),
              ],
            ),
            Padding(
              child: Text('正在加载...',
                  style: TextStyle(color: Colors.black54, fontSize: 15.0)),
              padding: EdgeInsets.all(15.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  ///下拉刷新
  Future<void> _handleRefresh() async {
    LogUtil.d("下拉刷新");
    List newEntries = await makeHttpRequest(true);
    if (mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        //setState 里面不能返回Future
      });
    }
    return Future(() {});
  }
}
