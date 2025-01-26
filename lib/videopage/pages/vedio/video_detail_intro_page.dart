import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../model/VideoModel.dart';
import '../../public.dart';
import '../../routers/routers.dart';
import '../../util/date_util.dart';

class VideoDetailIntroPage extends StatefulWidget {
  final VideoModel mVideo;

  VideoDetailIntroPage(this.mVideo);

  @override
  _VideoDetailIntroPageState createState() => _VideoDetailIntroPageState();
}

class _VideoDetailIntroPageState extends State<VideoDetailIntroPage> {
  bool mZiDongPlaySwitch = false;
  List<VideoModel> mRecommendVideoList = [];

  @override
  void initState() {
    super.initState();
    // 使用硬编码的数据填充推荐视频列表
    mRecommendVideoList = [
      VideoModel(
        id: 31,
        coverimg:
            "https://img.zcool.cn/community/01211a5dda760ca8012129e20de012.jpg@1280w_1l_2o_100sh.jpg",
        videotime: 31,
        playnum: 5647,
        userid: 11,
        tag: null,
        recommengstr: "数字课堂冲呀",
        type: 2,
        introduce: "生动有趣的数学启蒙视频，让孩子轻松爱上数学",
        createtime: 1588325248000,
        username: "数字课堂",
        userheadurl: "https://www.fo9c.cn/multimedia/10002.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "我是测试号0011",
      ),
      VideoModel(
        id: 32,
        coverimg: "https://img95.699pic.com/photo/40135/5825.jpg_wh860.jpg",
        videotime: 42,
        playnum: 8679,
        userid: 12,
        tag: null,
        recommengstr: "角度清奇",
        type: 2,
        introduce: "能读懂学生内心的数学课堂",
        createtime: 1588325252000,
        username: "Hrl测试号007",
        userheadurl: "http://175.27.193.33:8080/hrlweibo/file/gaoxiao.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "我是测试号0012",
      ),
      VideoModel(
        id: 32,
        coverimg: "https://www.fo9c.cn/multimedia/10004.jpg",
        videotime: 42,
        playnum: 8679,
        userid: 12,
        tag: null,
        recommengstr: "角度清奇",
        type: 2,
        introduce: "小学课程精讲",
        createtime: 1588325252000,
        username: "Hrl测试号007",
        userheadurl: "https://www.fo9c.cn/multimedia/10004.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "我是测试号0012",
      ),
      VideoModel(
        id: 32,
        coverimg: "https://www.fo9c.cn/multimedia/10005.jpg",
        videotime: 42,
        playnum: 8679,
        userid: 12,
        tag: null,
        recommengstr: "角度清奇",
        type: 2,
        introduce: "行驶在美妙的互动课堂，感受美妙的课堂",
        createtime: 1588325252000,
        username: "Hrl测试号007",
        userheadurl: "https://www.fo9c.cn/multimedia/10005.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "行驶在美妙的互动课堂，感受美妙的课堂",
      ),
      VideoModel(
        id: 32,
        coverimg:
            "https://img.zcool.cn/community/01211a5dda760ca8012129e20de012.jpg@1280w_1l_2o_100sh.jpg",
        videotime: 42,
        playnum: 8679,
        userid: 12,
        tag: null,
        recommengstr: "学生都在看",
        type: 2,
        introduce: "小学课堂中的那些意难平",
        createtime: 1588325252000,
        username: "智趣课堂",
        userheadurl:
            "https://img.zcool.cn/community/01211a5dda760ca8012129e20de012.jpg@1280w_1l_2o_100sh.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "我是这个json数据使用post请求我如何修改我这个数据",
      ),
      VideoModel(
        id: 32,
        coverimg:
            "https://img.zcool.cn/community/0192416015053b11013e39915cab5d.jpg@3000w_1l_2o_100sh.jpg",
        videotime: 42,
        playnum: 8679,
        userid: 12,
        tag: null,
        recommengstr: "智趣课堂",
        type: 2,
        introduce: "生动有趣的数学启蒙视频，让孩子轻松爱上数学",
        createtime: 1588325252000,
        username: "6千转发",
        userheadurl:
            "https://img.zcool.cn/community/0192416015053b11013e39915cab5d.jpg@3000w_1l_2o_100sh.jpg",
        userisvertify: 0,
        zannum: 0,
        videourl: "null",
        userfancount: 4,
        userdesc: "我是这个json数据使用post请求我如何修改我这个数据",
      ),
      // 可以添加更多硬编码的视频数据
    ];

    // 刷新 UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _authorRow(context, widget.mVideo),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Text(
                    widget.mVideo.introduce,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Text(
                    DateUtil.getFormatTime(DateTime.fromMillisecondsSinceEpoch(
                                widget.mVideo.createtime))
                            .toString() +
                        "   " +
                        widget.mVideo.playnum.toString() +
                        "次观看",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG +
                                    'video_detail_zhuanfa.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "转发",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG + 'video_detail_zan.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "点赞",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG + 'video_detail_share.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "分享",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG +
                                    'video_detail_downlaod.png',
                                width: 27.0,
                                height: 27.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "下载",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "接下来播放",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "自动播放",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Switch(
                        value: this.mZiDongPlaySwitch,
                        activeColor: Colors.blue, // 激活时原点颜色
                        onChanged: (bool val) {
                          this.setState(() {
                            this.mZiDongPlaySwitch = val;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return mRecommendVideoWidget(
                      mRecommendVideoList[index], index, context);
                },
                childCount: mRecommendVideoList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget mRecommendVideoWidget(
    VideoModel mModel, int index, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 80,
          width: MediaQuery.of(context).size.width * 3 / 8,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 3 / 8,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder:
                        AssetImage(Constant.ASSETS_IMG + 'img_default.png'),
                    image: NetworkImage(mModel.coverimg),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            DateUtil.getFormatTime4(mModel.videotime)
                                .toString(),
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  mModel.introduce,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${mModel.username}  ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "${mModel.playnum}次观看",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// 发布者昵称头像布局
Widget _authorRow(BuildContext context, VideoModel mVideo) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 2.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            Routes.navigateTo(context, Routes.personinfoPage, params: {
              'userid': mVideo.userid.toString(),
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: mVideo.userisvertify == 0
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: NetworkImage(mVideo.userheadurl),
                        fit: BoxFit.cover,
                      ),
                    ))
                : Stack(
                    children: <Widget>[
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: NetworkImage(mVideo.userheadurl),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: Image.asset(
                            mVideo.userisvertify == 1
                                ? Constant.ASSETS_IMG + 'home_vertify.webp'
                                : Constant.ASSETS_IMG + 'home_vertify2.webp',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                  child: Text(
                    mVideo.username,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '作者',
                    style: TextStyle(color: Colors.black, fontSize: 8),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
              child: Text(
                "${mVideo.userfancount}粉丝  视频博主",
                style: TextStyle(color: Color(0xff808080), fontSize: 11.0),
              ),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.centerRight,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  '+ 关注',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
