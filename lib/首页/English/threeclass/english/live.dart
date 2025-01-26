import 'package:education_app/course/oneclass/mathxiyoujiclass/Tab.dart';

import 'package:flutter/material.dart';

import '../../../../course/oneclass/oneenglishdown/Tab.dart';

import '../../../../course/threeclass/threeclassenglish/Tab.dart';

class ThreeClassEnglishLive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.live_tv,
                    size: 35,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '热门课程',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 160,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool A = false;
                        await Future.delayed(Duration(seconds: 0));
                        A = true;
                        if (A) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Video1(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/course/english/english18.jpg',
                        title: '【动画】三年级英语配套课程...',
                        category: '英语',
                        time: '2024-09-02 19:30',
                      ),
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
                              builder: (context) => OneEnglishdown(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/course/english/english19.jpg',
                        title: '三年级英语动画课堂',
                        category: '动画课程',
                        time: '今天 14:00',
                      ),
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
                              builder: (context) => Threeclassenglish(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/course/english/english20.jpg',
                        title: '【英语】三年级动画教学',
                        category: '欢迎来看',
                        time: '07-22 06:30',
                      ),
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
                              builder: (context) => Threeclassenglish(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/live/oneclassenglish.jpg',
                        title: '【英语】训练英语口语\n欢迎进来',
                        category: '口语',
                        time: '2024-09-01 19:30',
                      ),
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
                              builder: (context) => OneEnglishdown(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/live/oneclassenglish1.jpg',
                        title: '三年纪英语口语训练，培养孩子英语能力',
                        category: '口语',
                        time: '下周六 19:30',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class LiveCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String time;

  LiveCard({
    required this.image,
    required this.title,
    required this.category,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: 80,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '【$category】 $title',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
