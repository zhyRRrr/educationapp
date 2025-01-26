import 'package:education_app/Book/ClassAfter.dart';
import 'package:flutter/material.dart';
import '../Studentpkgame/pk_results_page.dart';
import '../chat/studentchat/StudentHomePage.dart';
import '../student.dart';
import '../statistics/statistics_page.dart';
import '设置.dart';
import '../学生注册.dart';

bool isLoggedIn = false;

class UserProfilePage1 extends StatefulWidget {
  const UserProfilePage1({super.key});

  @override
  State<UserProfilePage1> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage1> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 34, 255, 192),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Color.fromARGB(255, 34, 255, 192),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: _isLoggedIn
                          ? AssetImage('assets/images/3.0x/1.jpg') // 替换为你的头像路径
                          : null,
                      radius: 30,
                      child: _isLoggedIn ? null : Icon(Icons.person),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _isLoggedIn
                          ? [
                              Text('学生',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('Lv.2 山川',
                                  style: TextStyle(color: Colors.grey)),
                            ]
                          : [
                              GestureDetector(
                                onTap: () async {
                                  //跳转到登录页面
                                  final result = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return register();
                                  }));
                                  if (result == true) {
                                    setState(() {
                                      _isLoggedIn = true;
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text('登录/注册  >',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 10),
          // 内容部分
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 四个 Column 布局
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            bool A = false;
                            await Future.delayed(Duration(seconds: 0));
                            A = true;
                            if (A) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PKResultsPage(),
                                  settings: RouteSettings(
                                      arguments: {'disableBack': true}),
                                ),
                              );
                            }
                          },
                          child: buildColumnItem(
                              'assets/images/myhome/1.png', 'PK数据'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            bool A = false;
                            await Future.delayed(Duration(seconds: 0));
                            A = true;
                            if (A) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentChatApp(),
                                  settings: RouteSettings(
                                      arguments: {'disableBack': true}),
                                ),
                              );
                            }
                          },
                          child: buildColumnItem(
                              'assets/images/myhome/2.png', '班级管理'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            bool A = false;
                            await Future.delayed(Duration(seconds: 0));
                            A = true;
                            if (A) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => classwork(),
                                  settings: RouteSettings(
                                      arguments: {'disableBack': true}),
                                ),
                              );
                            }
                          },
                          child: buildColumnItem(
                              'assets/images/myhome/3.png', '课后练习'),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            bool A = false;
                            await Future.delayed(Duration(seconds: 0));
                            A = true;
                            if (A) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Tabs(initialIndex: 0),
                                  settings: RouteSettings(
                                      arguments: {'disableBack': true}),
                                ),
                              );
                            }
                          },
                          child: buildColumnItem(
                              'assets/images/myhome/4.png', '动画课堂'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '更多功能',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  // ListTile 布局
                  ListTile(
                    leading: Image.asset(
                      'assets/images/myhome/5.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ), // 替换为你的图标路径
                    title: Text('邀请好友'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Statistics()));
                    },
                    leading: Image.asset(
                      'assets/images/myhome/6.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ), // 替换为你的图标路径
                    title: Text('我的统计'),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/myhome/7.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ), // 替换为你的图标路径
                    title: Text('客服电话'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SettingsPage();
                      }));
                    },
                    leading: Image.asset(
                      'assets/images/myhome/8.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ), // 替换为你的图标路径
                    title: Text('我的设置'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Column buildColumnItem(String imagePath, String title) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter, // 设置文本在图片底部居中
          children: [
            Image.asset(
              imagePath,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ), // 替换为你的图标路径
            Container(
              color: const Color.fromARGB(137, 255, 255, 255), // 半透明背景
              padding: EdgeInsets.symmetric(vertical: 4.0), // 上下内边距
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black, // 文本颜色
                  fontSize: 14, // 文本大小
                  fontWeight: FontWeight.bold, // 文本加粗
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
