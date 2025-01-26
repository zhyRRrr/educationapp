import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../public.dart';

class FollowListPage extends StatefulWidget {
  @override
  FollowListPageState createState() => FollowListPageState();
}

class FollowListPageState extends State<FollowListPage> {
  ScrollController mListController = new ScrollController();

  num curPage = 1;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  var mTextController = new TextEditingController();

  //加载更多
  FollowListPageState() {
    mListController.addListener(() {
      var maxScroll = mListController.position.maxScrollExtent;
      var pixels = mListController.position.pixels;
      if (maxScroll == pixels) {
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              curPage += 1;
            });
          } else {
            print('没有更多数据');
            setState(() {
              ishasMore = false;
            });
          }
        }
      }
    });
  }

  Widget mFollowTop() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
          child: InkWell(
            child: Container(
                padding: new EdgeInsets.only(
                    top: 7.0, bottom: 7.0, left: 5.0, right: 5.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Image.asset(
                        Constant.ASSETS_IMG + "ic_search.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "搜索全部关注",
                      style: TextStyle(fontSize: 14, color: Color(0xff999999)),
                    ))
                  ],
                )),
            onTap: () {
              print("点击关注");
            },
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 10,
            bottom: 5,
          ),
          child: Text(
            "全部关注",
            style: TextStyle(fontSize: 12, color: Color(0xff666666)),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadMore() {
    return isloadingMore
        ? Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    height: 12.0,
                    width: 12.0,
                  ),
                ),
                Text("加载中..."),
              ],
            )),
          ))
        : new Container(
            child: ishasMore
                ? new Container()
                : Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "没有更多数据",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ))),
          );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
