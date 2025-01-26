import 'package:education_app/course/twoclass/twoclassmath/Tab.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../items.dart';
import '../../tree.dart';

class Twoflex extends StatefulWidget {
  @override
  _flexState createState() => _flexState();
}

class _flexState extends State<Twoflex> {
  final List<String> imgList = [
    "assets/images/course/chinese/chinese6.jpg",
    "assets/images/course/english/english13.jpg",
    "assets/images/course/chinese/chinese8.jpg",
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Items(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧轮播图
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 0.75, // 调整比例
                          enlargeCenterPage: false, // 禁用中心放大效果
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                        ),
                        items: imgList
                            .map(
                              (item) => Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              _currentPage = entry.key;
                            }),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == entry.key
                                    ? Colors.blue
                                    : Color.fromARGB(255, 200, 200, 200),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                // 右侧卡片
                Expanded(
                  child: Column(
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
                                builder: (context) => TwoMathclass(),
                                settings: RouteSettings(
                                    arguments: {'disableBack': true}),
                              ),
                            );
                          }
                        },
                        child:
                            _buildCard("来进入", "动画课堂", "assets/images/举手.png"),
                      ),
                      SizedBox(height: 16),
                      _buildCard("进入动画课堂", "课堂互动精选推荐", "assets/images/举手.png"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                bool A = false;
                await Future.delayed(Duration(seconds: 1));
                A = true;
                if (A) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tree()),
                  );
                }
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/images/草原.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '认知训练营',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('限时互动 >')
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight * 0.07,
                    left: screenWidth * 0.3,
                    child: Image.asset(
                      'assets/images/bird.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.03,
                    left: screenWidth * 0.3,
                    child: Image.asset(
                      'assets/images/bird.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.4,
                    child: Image.asset(
                      'assets/images/bird.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * -0.01,
                    left: screenWidth * 0.34,
                    child: Image.asset(
                      'assets/images/chicken.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * -0.005,
                    left: screenWidth * 0.575,
                    child: Image.asset(
                      'assets/images/lion.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    top: screenHeight * -0.005,
                    left: screenWidth * 0.0,
                    child: Image.asset(
                      'assets/images/elephant.gif', // 替换为你的图片路径
                      width: 90, // 根据需要调整图片宽度
                      height: 90, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * -0.01,
                    right: screenWidth * 0.025,
                    child: Image.asset(
                      'assets/images/tiger.gif', // 替换为你的图片路径
                      width: 70, // 根据需要调整图片宽度
                      height: 70, // 根据需要调整图片高度
                    ),
                  ),
                  Positioned(
                    top: screenHeight * -0.005,
                    right: screenWidth * -0.025,
                    child: Image.asset(
                      'assets/images/fox.gif', // 替换为你的图片路径
                      width: 80, // 根据需要调整图片宽度
                      height: 80, // 根据需要调整图片高度
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildCard(String title, String subtitle, String imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.115,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              imagePath,
              // width: 80,
              // height: 800,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
