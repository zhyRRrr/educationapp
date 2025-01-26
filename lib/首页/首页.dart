import 'package:education_app/%E9%A6%96%E9%A1%B5/English/oneclass/english/flex.dart';
import 'package:education_app/%E9%A6%96%E9%A1%B5/English/twoclass/english/flex.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import '精选/Guesslove.dart';
import 'English/oneclass/chinese/ClassRank.dart';
import 'English/oneclass/chinese/flex.dart';
import 'English/oneclass/chinese/live.dart';
import 'English/oneclass/english/ClassRank.dart';
import 'English/oneclass/english/live.dart';
import 'English/oneclass/jingxuan/flex.dart';
import 'English/oneclass/jingxuan/live.dart';
import 'English/oneclass/jingxuan/ClassRank.dart';
// import 'English/oneclass/jingxuan/HotClass.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'English/oneclass/live.dart';
import 'English/oneclass/math/ClassRank.dart';
import 'English/oneclass/math/flex.dart';
import 'English/oneclass/math/live.dart';
import 'English/threeclass/ClassRank.dart';
import 'English/threeclass/chinese/ClassRank.dart';
import 'English/threeclass/chinese/flex.dart';
import 'English/threeclass/chinese/live.dart';
import 'English/threeclass/english/ClassRank.dart';
import 'English/threeclass/english/flex.dart';
import 'English/threeclass/english/live.dart';
import 'English/threeclass/jingxuan/flex.dart';
import 'English/threeclass/jingxuan/live.dart';
import 'English/threeclass/math/ClassRank.dart';
import 'English/threeclass/math/flex.dart';
import 'English/threeclass/math/live.dart';
import 'English/twoclass/ClassRank.dart';
import 'English/twoclass/chinese/ClassRank.dart';
import 'English/twoclass/chinese/flex.dart';
import 'English/twoclass/chinese/live.dart';
import 'English/twoclass/english/ClassRank.dart';
import 'English/twoclass/english/live.dart';
import 'English/twoclass/jingxuan/flex.dart';
import 'English/twoclass/jingxuan/live.dart';
import 'English/twoclass/math/ClassRank.dart';
import 'English/twoclass/math/flex.dart';
import 'English/twoclass/math/live.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  EasyRefreshController _refreshController = EasyRefreshController();
  String selectedGrade = "未设置";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _showGradeSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('选择9月后所在年级',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: [
                  '一年级',
                  '二年级',
                  '三年级',
                ].map((grade) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGrade = grade;
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: Center(child: Text(grade)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _refreshController.finishRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: TextButton(
                onPressed: () => _showGradeSelectionSheet(context),
                child: Row(
                  children: [
                    Text(selectedGrade, style: TextStyle(color: Colors.black)),
                    Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '英语',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.alarm, color: Colors.black),
              onPressed: () {
                // 信息图标点击处理逻辑
              },
            ),
          ],
        ),
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blue,
          indicatorWeight: 3.0,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 18.0),
          tabs: [
            Tab(text: '精选'),
            Tab(text: '英语'),
            Tab(text: '数学'),
            Tab(text: '语文'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabBarViews(),
      ),
    );
  }

  List<Widget> _buildTabBarViews() {
    switch (selectedGrade) {
      case '一年级':
        return _buildGradeOneContent();
      case '二年级':
        return _buildGradeTwoContent();
      case '三年级':
        return _buildGradeThreeContent();
      default:
        return _buildGradeOneContent();
    }
  }

  List<Widget> _buildGradeOneContent() {
    return [
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Container(
                  color: Color.fromARGB(250, 250, 250, 250),
                  child: Column(
                    children: [
                      Oneflex(),
                      OneEnglishLive(),
                      OneClassRank(),
                      // HotClass(),
                    ],
                  ))
            ],
          )),
      EasyRefresh(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    OneClassEnglishflex(),
                    OneClassEnglishLive(),
                    OneClassEnglishRank(),
                    SizedBox(
                      height: 8,
                    ),
                    // HotClass()
                  ],
                ))
          ],
        ),
      ),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  OneClassMathflex(),
                  OneclassMathLive(),
                  OneClassMathRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  OneClassChineseflex(),
                  OneclassChineseLive(),
                  OneClassChineseRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
    ];
  }

  List<Widget> _buildGradeTwoContent() {
    return [
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Container(
                  color: Color.fromARGB(250, 250, 250, 250),
                  child: Column(
                    children: [
                      Twoflex(),
                      TwoEnglishLive(),
                      TwoClassRank(),
                      // HotClass(),
                    ],
                  ))
            ],
          )),
      EasyRefresh(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TwoClassEnglishflex(),
                    TwoClassEnglishLive(),
                    TwoClassEnglishRank(),
                    SizedBox(
                      height: 8,
                    ),
                    // HotClass()
                  ],
                ))
          ],
        ),
      ),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  TwoClassMathflex(),
                  TwoclassMathLive(),
                  TwoClassMathRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  TwoClassChineseflex(),
                  TwoclassChineseLive(),
                  TwoClassChineseRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
    ];
  }

  List<Widget> _buildGradeThreeContent() {
    return [
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Container(
                  color: Color.fromARGB(250, 250, 250, 250),
                  child: Column(
                    children: [
                      Threeflex(),
                      ThreeEnglishLive(),
                      ThreeClassRank(),
                      // HotClass(),
                    ],
                  ))
            ],
          )),
      EasyRefresh(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ThreeClassEnglishflex(),
                    ThreeClassEnglishLive(),
                    ThreeClassEnglishRank(),
                    SizedBox(
                      height: 8,
                    ),
                    // HotClass()
                  ],
                ))
          ],
        ),
      ),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  ThreeClassMathflex(),
                  ThreeclassMathLive(),
                  ThreeClassMathRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
      EasyRefresh(
          onRefresh: _refresh,
          child: ListView(
            children: [
              Column(
                children: [
                  ThreeClassChineseflex(),
                  ThreeclassChineseLive(),
                  ThreeClassChineseRank(),
                  SizedBox(
                    height: 8,
                  ),
                  // HotClass()
                ],
              )
            ],
          )),
    ];
  }
}
