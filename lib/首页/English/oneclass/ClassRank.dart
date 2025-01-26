import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../course/oneclass/onechinese/Tab.dart';
import '../../../course/oneclass/onechinese1/Tab.dart';

class ClassRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<ClassRank> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // // 计算自适应字体大小
    // double titleFontSize = screenHeight * 0.025; // 例如，标题字体为屏幕高度的2.5%
    // double subtitleFontSize = screenHeight * 0.022; // 副标题字体为屏幕高度的2.2%
    // double priceFontSize = screenHeight * 0.022; // 价格字体
    // double studentsFontSize = screenHeight * 0.022; // 学生人数字体

    final List imgList = [
      Column(
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
                    builder: (context) => Oneclasschinese1(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "清华附小动画教学",
              "语文",
              "欢迎免费观看",
              "assets/images/course/chinese/chinese18.jpg",
              "685人已观看",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "课程配套动画教学",
              "动画课程带你回顾知识",
              "欢迎免费观看",
              "assets/images/直播7.jpg",
              "69人已观看",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "12国语言畅学卡【周卡】",
              "沪江网校官方店铺",
              "¥0.01 领券立减",
              "assets/images/直播7.jpg",
              "1.1万人次学习",
              screenHeight,
              screenWidth,
            ),
          ),
        ],
      ),
      Column(
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
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "高中英语3500词康哥逐词精讲",
              "考得上在线",
              "¥1 拼团特惠",
              "assets/images/直播7.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "简单高效拼读课【永久有效】",
              "沪江英语",
              "¥9.9 领券立减",
              "assets/images/直播7.jpg",
              "69人报名",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "高中英语3500词康哥逐词精讲",
              "考得上在线",
              "¥1 拼团特惠",
              "assets/images/直播7.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
        ],
      ),
      Column(
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
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "高中英语3500词康哥逐词精讲",
              "考得上在线",
              "¥1 拼团特惠",
              "assets/images/直播7.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "高中英语3500词康哥逐词精讲",
              "考得上在线",
              "¥1 拼团特惠",
              "assets/images/直播7.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Oneclasschinese(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "高中英语3500词康哥逐词精讲",
              "考得上在线",
              "¥1 拼团特惠",
              "assets/images/直播7.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
        ],
      ),
    ];

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
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
            padding: EdgeInsets.fromLTRB(15, 8, 15, 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Color.fromARGB(255, 253, 0, 0)),
                        SizedBox(width: 8),
                        Text(
                          '精品小课排行榜',
                          style: TextStyle(
                            fontSize: screenHeight * 0.025, // 自适应字体
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // 查看全部按钮点击事件
                      },
                      child: Text(
                        '查看更多 >',
                        style: TextStyle(
                          fontSize: screenHeight * 0.020, // 自适应字体
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double carouselHeight =
                        constraints.maxWidth / 1.2; // 根据 aspectRatio 计算高度
                    return Container(
                      height: carouselHeight,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1.2,
                          enlargeCenterPage: true,
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
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: item,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
                Row(
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
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
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
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static Widget _buildCard(
    String title,
    String subtitle,
    String price,
    String imagePath,
    String students,
    double screenHeight,
    double screenWidth,
  ) {
    return Container(
      child: Row(
        children: [
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
              SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                students,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.25,
              height: screenHeight * 0.1,
            ),
          )
        ],
      ),
    );
  }
}
