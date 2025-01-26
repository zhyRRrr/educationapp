import 'package:flutter/material.dart';

class TwoClassChineseRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<TwoClassChineseRank> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List imgList = [
      Column(
        children: [
          _buildCard(
            "课程配套动画解说。",
            "跟我一起进行语文大冒险吧",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese21.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "来欣赏语文动画课堂。",
            "跟我一起进行语文大冒险吧",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese23.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "学习如何翻译简单的句子。",
            "小小翻译家",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese19.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "练习语音和语调。",
            "语音语调训练",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese18.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "巩固拼音知识，快乐学习！。",
            "拼音游戏时间",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese17.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "探索字词搭配的乐趣。",
            "表达更加准确！",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese16.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "了解汉字的构成和意义。",
            "趣味汉字拆分",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese15.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "丁丁的汉字探险",
            "一起进行汉字探险！",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese19.jpg",
            "55人已观看",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "写出你自己的小诗。",
            "成为一名小小诗人！",
            "欢迎免费观看",
            "assets/images/course/chinese/chinese20.jpg",
            "55人已观看",
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
