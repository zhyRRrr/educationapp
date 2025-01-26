import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

void main() {
  runApp(TainCamp1());
}

class TainCamp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '暑假抢分营',
            style: TextStyle(
                color: const Color.fromARGB(255, 248, 149, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
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
                  'assets/images/TainCampCopy2.jpg'), // Replace with your image asset
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
                          color: Colors.orange,
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
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '暑期高效培训班',
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

              Image.asset('assets/images/TainCampCopy1.jpg'),
              Image.asset('assets/images/TainCampCopy3.jpg'),
              SizedBox(
                height: 60,
              )
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
                color: Colors.orange,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text('立即报名'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
