import 'package:education_app/%E9%A6%96%E9%A1%B5/baoming.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../course/twoclass/twoclassmath/Tab.dart';

void main() {
  runApp(TainCamp());
}

class TainCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '暑假抢分营',
            style: TextStyle(color: Colors.pink),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: MyLayout(),
      ),
    );
  }
}

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                  'assets/images/TainCamp.jpg'), // Replace with your image asset
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                '￥0.01',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: CountdownTimer(
                                endTime: DateTime.now().add(Duration(
                                    days: 1,
                                    hours: 4,
                                    minutes: 38,
                                    seconds: 19)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(06, 16, 6, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '小学课程暑假营',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '报名人数: 358\n课时: 2',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Chip(label: Text('亮点')),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015),
                                Chip(label: Text('名师授课')),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015),
                                Chip(label: Text('微信答疑')),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015),
                                Chip(label: Text('直播授课')),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '永久有效',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '简介',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '报名后务必扫码添加助教微信：xxxx，解锁以下福利\n'
                      '1. 单词打卡+小程序测试+督学服务\n'
                      '2. 领取《写作打卡高频表达及其例句》《小学日常学习规划》等课程资料\n'
                      '训练营期间，微信听课群每天\n',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/TainCamp1.jpg'),
              Image.asset('assets/images/TainCamp2.jpg'),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavBar(),
        ),
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  CountdownTimer({required this.endTime});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.endTime.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds <= 0) {
        _timer.cancel();
      } else {
        setState(() {
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_duration.inHours.toString().padLeft(2, '0')}时 '
      '${(_duration.inMinutes % 60).toString().padLeft(2, '0')}分 '
      '${(_duration.inSeconds % 60).toString().padLeft(2, '0')}秒',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.home),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                ),
                Text('主页'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.star_border),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                ),
                Text('收藏'),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              //设置圆角不能设置颜色
              // color: Colors.blue,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.pink,
              ),
              child: TextButton(
                onPressed: () async {
                  bool A = false;
                  await Future.delayed(Duration(seconds: 0));
                  A = true;
                  if (A) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoursePage(),
                        settings:
                            RouteSettings(arguments: {'disableBack': true}),
                      ),
                    );
                  }
                },
                child: Text('立即报名'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
