import 'package:flutter/material.dart';
import 'widget/loadmore_error.dart';
import 'widget/loadmore_loading.dart';
import 'widget/loadmore_nodata.dart';
import 'widget/refresh_empty.dart';
import 'widget/refresh_error.dart';
import 'widget/refresh_loading.dart';
import 'item_notifier.dart';

//通用下拉刷新上拉加载更多

class HrlSliverList<T> extends StatefulWidget {
  final int? pageSize;
  final PageRequest<T>? pageFuture;
  final ItemBuilder<T> itemBuilder;
  final SliverToBoxAdapter headView;
  final Widget? centerWidget;

  HrlSliverList({
    this.pageSize,
    this.pageFuture,
    this.centerWidget,
    required this.headView,
    Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  HrlSliverListState<T> createState() => HrlSliverListState<T>();
}

class HrlSliverListState<T> extends State<HrlSliverList<T>> {
  late ItemNotifier<T> itemNotifier;

  @override
  void initState() {
    super.initState();
    itemNotifier = ItemNotifier<T>(pageRequest: widget.pageFuture);
    itemNotifier.addListener(() => mounted ? setState(() {}) : null);
    itemNotifier.onRefresh(true);
  }

  @override
  void dispose() {
    super.dispose();
    itemNotifier.dispose();
  }

  @override
  void didUpdateWidget(HrlSliverList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("HrlListView开始---build");
    if (itemNotifier.isFirstLoading) {
      //第一次进入页面在中间显示loading
      return RefreshLoading();
    } else if (itemNotifier.isShowEmptyView) {
      //下拉刷新为空,显示空布局
      return RefreshEmpty(itemNotifier: itemNotifier);
    } else if (itemNotifier.isShowErrorView) {
      //第一次获取数据失败,
      return RefreshError(itemNotifier: itemNotifier);
    } else {
      //第一次进入获取到数据
      return RefreshIndicator(
          child: new CustomScrollView(slivers: <Widget>[
            widget.headView,
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _itemBuilder(context, index);
                },
                childCount: itemNotifier.mDataList.length + 1,
              ),
            ),
          ]),
          onRefresh: () => itemNotifier.onRefresh(false));
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final total = itemNotifier.mDataList.length + 1;
    if (index == total - 1) {
      //如果加载到最后一个数据
      if (itemNotifier.loadMoreError == true) {
        return LoadMoreError(
          itemNotifier: itemNotifier,
          doLoadMore: false,
        );
      }
      if (this.itemNotifier.hasMoreItems) {
        this.itemNotifier.onLoadMore();
        return LoadMoreLoading();
      } else {
        return LoadMoreNoData();
      }
    } else {
      if (widget.centerWidget == null) {
        return widget.itemBuilder(
            context, this.itemNotifier.mDataList[index], index);
      } else {
        if (index == 3) {
          return widget.centerWidget!;
        } else {
          return widget.itemBuilder(
              context, this.itemNotifier.mDataList[index], index);
        }
      }
    }
  }
}
