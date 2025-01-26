import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TwoClassRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<TwoClassRank> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List imgList = [
      Column(
        children: [
          _buildCard(
            "二年级英语配套课程...",
            "欢迎观看",
            "课程优选",
            "assets/images/course/english/english3.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "二年级英语动画课堂】",
            "动画英语",
            "课程优选",
            "assets/images/course/english/english19.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "12国语言畅学卡【周卡】",
            "沪江网校官方店铺",
            "¥0.01 领券立减",
            "assets/images/直播7.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "高中英语3500词康哥逐词精讲",
            "考得上在线",
            "¥1 拼团特惠",
            "assets/images/直播7.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "简单高效拼读课【永久有效】",
            "沪江英语",
            "¥9.9 领券立减",
            "assets/images/直播7.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "12国语言畅学卡【周卡】",
            "沪江网校官方店铺",
            "¥0.01 领券立减",
            "assets/images/直播7.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
      Column(
        children: [
          _buildCard(
            "高中英语3500词康哥逐词精讲",
            "考得上在线",
            "¥1 拼团特惠",
            "assets/images/直播7.jpg",
            "685人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "简单高效拼读课【永久有效】",
            "沪江英语",
            "¥9.9 领券立减",
            "assets/images/直播7.jpg",
            "69人报名",
            screenHeight,
            screenWidth,
          ),
          SizedBox(height: 10),
          _buildCard(
            "12国语言畅学卡【周卡】",
            "沪江网校官方店铺",
            "¥0.01 领券立减",
            "assets/images/直播7.jpg",
            "1.1万人次学习",
            screenHeight,
            screenWidth,
          ),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.54,
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
          SizedBox(
            height: 15,
          )
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
