import 'package:education_app/course/oneclass/onemathclassdown/Tab.dart';
import 'package:education_app/course/oneclass/onemathclassup/Tab.dart';
import 'package:education_app/course/threeclass/threeclassmath/Tab.dart';
import 'package:education_app/course/twoclass/twoclassmath/Tab.dart';
import 'package:flutter/material.dart';

class ThreeClassMathRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<ThreeClassMathRank> {
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
                    builder: (context) => Threeclassmath(),
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
              "欢迎观看",
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
                    builder: (context) => OneMathclassdown(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "听有趣的数学故事，感受数学的魅力！",
              "数学故事会",
              "数学的魅力！",
              "assets/images/course/math/math26.jpg",
              "欢迎观看",
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
                    builder: (context) => TwoMathclass(),
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
              "欢迎观看",
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
                    builder: (context) => Threeclassmath(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "小学三年级数学精讲",
              "小小数学家",
              "让数学变得轻松有趣！",
              "assets/images/course/math/math14.jpg",
              "欢迎进来收看",
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
                    builder: (context) => OneMathclassup(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "探索数字的基本概念",
              "了解日常生活中的数学应用！",
              "数的规律",
              "assets/images/course/math/math24.jpg",
              "欢迎进来观看",
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
                    builder: (context) => OneMathclassdown(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "学习如何将数字进行分类与应用",
              "考得上在线",
              "踏上数学的探险之旅",
              "assets/images/course/math/math11.jpg",
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
                    builder: (context) => TwoMathclass(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "小学图形精讲",
              "几何图形大观",
              "探索各种几何图形",
              "assets/images/course/math/math16.jpg",
              "欢迎来看",
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
                    builder: (context) => Threeclassmath(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "现数字的奇妙世界！",
              "数学探险之旅",
              "踏上数学的探险之旅",
              "assets/images/course/math/math18.jpg",
              "欢迎来看",
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
                    builder: (context) => Threeclassmath(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildCard(
              "体会数学的奥秘",
              "数学探险之旅",
              "踏上数学的探险之旅",
              "assets/images/course/math/math22.jpg",
              "欢迎来看",
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
