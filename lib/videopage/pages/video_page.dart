import 'package:education_app/tiktok/tiktok.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../http/dio_manager.dart';
import '../model/videocategory.dart';
import '../model/VedioCategoryList.dart';
import '../public.dart';
import 'vedio/video_hot_page.dart';
import 'vedio/video_recommend_page.dart';
import 'vedio/video_smallvideo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.init();
  runApp(videopage123());
}

class videopage123 extends StatelessWidget {
  videopage123() {
    _initialize();
  }

  Future<void> _initialize() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffffffff),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0x333333),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    Routes.configureRoutes(Routes.router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.router.generator,
      home: VideoPage(),
    );
  }
}

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  TabController? mTabController;
  List<VedioCategory> mTabList = [];

  @override
  void initState() {
    super.initState();
    mTabList.add(VedioCategory(id: 1, cname: "推荐"));
    mTabList.add(VedioCategory(id: 2, cname: "热门"));
    mTabList.add(VedioCategory(id: 3, cname: "小视频"));
    mTabController = TabController(length: mTabList.length, vsync: this);
    DioManager.instance.post(ServiceUrl.getVedioCategory, null, (data) {
      List<VedioCategory> mList = VedioCategoryList.fromJson(data).data;
      setState(() {
        mTabList = mList;
        mTabController = TabController(length: mTabList.length, vsync: this);
      });
    }, (error) {
      //ToastUtil.show(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Color(0xffF78005),
                unselectedLabelColor: Color(0xff666666),
                labelStyle:
                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(fontSize: 16.0),
                indicatorSize: TabBarIndicatorSize.label,
                controller: mTabController,
                tabs: mTabList.map((value) {
                  return Text(value.cname);
                }).toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  VideoRecommendPage(),
                  VideoHotPage(),
                  VideoSmall(),
                ],
                controller: mTabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('mTabController', mTabController));
  }
}
