import 'package:flutter/material.dart';

class TwoClassMathRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<TwoClassMathRank> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List imgList = [
      Column(
        children: [
          _buildCard(
            "解开数学谜团！数学故事会",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math7.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "认识整数、分数和小数",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math8.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "探索数学的奇妙现象！",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math10.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "听有趣的数学故事",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math11.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "学习透视与比例的基本概念",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math12.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "解开数学谜团！数学故事会",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math13.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "探索数学与科技的结合",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math14.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "面积与周长的计算",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math15.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "通过动画课程学习加法和减法",
            "逻辑推理训练",
            "欢迎来看",
            "assets/images/course/math/math16.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
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
