import 'package:flutter/material.dart';

import '../../../course/oneclass/onechinese/Tab.dart';
import '../../../course/oneclass/onechinese1/Tab.dart';

class ThreeClassRank extends StatefulWidget {
  @override
  _ThreeClassRankState createState() => _ThreeClassRankState();
}

class _ThreeClassRankState extends State<ThreeClassRank> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
              "探索汉字的起源和结构",
              "动画课程带你了解",
              "欢迎免费观看",
              "assets/images/course/chinese/chinese17.jpg",
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
              "来感受诗歌带来的美好情感。",
              "一起欣赏古诗的韵味",
              "欢迎免费观看",
              "assets/images/course/chinese/chinese16.jpg",
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
              "一年级英语配套课程...",
              "欢迎观看",
              "课程优选",
              "assets/images/course/english/english3.jpg",
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
              "一年级英语动画课堂】",
              "动画英语",
              "课程优选",
              "assets/images/course/english/english19.jpg",
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
              "一年级动画教学【英语】",
              "欢迎来看",
              "¥0.01 领券立减",
              "assets/images/course/english/english20.jpg",
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
              "一起踏上数学的探险之旅",
              "数学探险之旅",
              "加法与减法的乐趣",
              "assets/images/course/math/math4.jpg",
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
              "参与数学小达人选拔！",
              "数学小达人",
              "挑战自我！",
              "assets/images/course/math/math27.jpg",
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
              "小学一年级数学精讲",
              "小小数学家",
              "让数学变得轻松有趣！",
              "assets/images/course/math/math14.jpg",
              "685人报名",
              screenHeight,
              screenWidth,
            ),
          ),
        ],
      ),
    ];

    PageController _pageController = PageController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.52,
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
                            fontSize: 18,
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
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: imgList.length,
                    itemBuilder: (context, index) {
                      return imgList[index];
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imgList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
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
          SizedBox(height: 35),
        ],
      ),
    );
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
          Expanded(
            child: Column(
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
          ),
          SizedBox(width: 10), // 调整图像与文本之间的间距
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
