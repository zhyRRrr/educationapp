import 'package:education_app/course/threeclass/threeclasschinese/Tab.dart';
import 'package:flutter/material.dart';

import '../course/twoclass/twoclassmath/Tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoursePage(),
    );
  }
}

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 返回按钮
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 33, 243, 145),
                  Colors.white,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // 图片
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/myhome/lianxi.png',
                    fit: BoxFit.cover,
                  ),
                  // 课程介绍
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '小学暑假专题训练营v2.0',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '3.9k  •  4.9  •  12小时45分钟',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '课程简介：\n小学动课堂是一个基础课程，丰富有趣的动画内容',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), // 课程列表
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '课程列表',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // 课程项目
                    GestureDetector(
                      onTap: () async {
                        bool A = false;
                        await Future.delayed(Duration(seconds: 0));
                        A = true;
                        if (A) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TwoMathclass(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: CourseItem(
                          title: '01  第1-4月：基础技能学习与练习', duration: '12小时45分钟'),
                    ),
                    GestureDetector(
                      onTap: () async {
                        bool A = false;
                        await Future.delayed(Duration(seconds: 0));
                        A = true;
                        if (A) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Threeclasschinese(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: CourseItem(
                          title: '02  第1-4月：基础技能学习与练习', duration: '2.5k'),
                    ),
                    CourseItem(title: '03  第1-4月：基础技能学习与练习', duration: '2.5k'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final String title;
  final String duration;

  CourseItem({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(duration),
          Icon(Icons.play_arrow),
        ],
      ),
    );
  }
}
