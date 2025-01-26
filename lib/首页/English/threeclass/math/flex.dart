import 'package:education_app/course/oneclass/onemathclassdown/Tab.dart';
import 'package:education_app/course/twoclass/twoclassmath/Tab.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../course/oneclass/onemathclassup/Tab.dart';
import '../../../../course/threeclass/threeclassmath/Tab.dart';
import '../../../../teacher.dart';

class ThreeClassMathflex extends StatefulWidget {
  @override
  _flexState createState() => _flexState();
}

class _flexState extends State<ThreeClassMathflex> {
  final List<String> imgList = [
    "assets/images/course/math/math1.jpg",
    "assets/images/course/math/math25.jpg",
    "assets/images/course/math/math30.jpg",
  ];

  // 对应每张图片的目标页面
  final List<Widget> targetPages = [
    OneMathclassup(), // 对应第一个图像的页面
    OneMathclassdown(), // 对应第二个图像的页面
    Threeclassmath(), // 对应第三个图像的页面
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
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
                        aspectRatio: 0.75,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                      items: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => targetPages[entry.key],
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                entry.value,
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
                            ),
                          );
                        }
                      },
                      child:
                          _buildCard("来进入", "数学动画课堂", "assets/images/举手.png"),
                    ),
                    SizedBox(height: 16),
                    _buildCard("进入动画课堂", "课堂互动精选推荐", "assets/images/举手.png"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
            child: Image.asset(imagePath),
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
