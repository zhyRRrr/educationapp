import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import '../../model/VideoModel.dart';
import '../../public.dart';
import 'package:video_player/video_player.dart';

import 'video_detail_comment_page.dart';
import 'video_detail_intro_page.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel mVideo;

  VideoDetailPage(this.mVideo);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with SingleTickerProviderStateMixin {
  List<String> mTabList = ["简介", "评论"];
  late TabController mTabController;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    mTabController = TabController(
      length: mTabList.length,
      vsync: this,
    );
    videoPlayerController =
        VideoPlayerController.asset('assets/video/twomath/math1.mp4');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            new Container(
              height: 200,
              child: Chewie(
                controller: chewieController,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Color(0xffFF3700),
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xffFF3700), width: 2),
                      insets: EdgeInsets.only(bottom: 7)),
                  labelColor: Color(0xff333333),
                  unselectedLabelColor: Color(0xff666666),
                  labelStyle:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontSize: 13.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: mTabController,
                  tabs: [
                    new Tab(
                      text: mTabList[0],
                    ),
                    new Tab(
                      text: mTabList[1],
                    ),
                  ]),
            ),
            Container(
              height: 1,
              color: Color(0xffE2E2E2),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  VideoDetailIntroPage(widget.mVideo),
                  VideoDetailCommentPage(),
                ],
                controller: mTabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
