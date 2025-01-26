import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ClassRank extends StatefulWidget {
  @override
  _ClassRankState createState() => _ClassRankState();
}

class _ClassRankState extends State<ClassRank> {
  final List imgList = [
    Column(
      children: [
        _buildCard("高中英语3500词康哥逐词精讲", "考得上在线", "¥1 拼团特惠",
            "assets/images/直播7.jpg", "685人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("简单高效的拼读课【永久有效班】", "沪江英语", "¥9.9 领券立减",
            "assets/images/直播7.jpg", "69人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("12国语言畅学卡【周卡】", "沪江网校官方店铺", "¥0.01 领券立减",
            "assets/images/直播7.jpg", "1.1万人次学习"),
      ],
    ),
    Column(
      children: [
        _buildCard("高中英语3500词康哥逐词精讲", "考得上在线", "¥1 拼团特惠",
            "assets/images/直播7.jpg", "685人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("简单高效的拼读课【永久有效班】", "沪江英语", "¥9.9 领券立减",
            "assets/images/直播7.jpg", "69人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("12国语言畅学卡【周卡】", "沪江网校官方店铺", "¥0.01 领券立减",
            "assets/images/直播7.jpg", "1.1万人次学习"),
      ],
    ),
    Column(
      children: [
        _buildCard("高中英语3500词康哥逐词精讲", "考得上在线", "¥1 拼团特惠",
            "assets/images/直播7.jpg", "685人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("简单高效的拼读课【永久有效班】", "沪江英语", "¥9.9 领券立减",
            "assets/images/直播7.jpg", "69人报名"),
        SizedBox(
          height: 10,
        ),
        _buildCard("12国语言畅学卡【周卡】", "沪江网校官方店铺", "¥0.01 领券立减",
            "assets/images/直播7.jpg", "1.1万人次学习"),
      ],
    ),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: [
          // 顶部标题和轮播图在一个圆角背景中
          Container(
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 顶部标题和右侧按钮
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
                              color: Colors.red),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // 查看全部按钮点击事件
                      },
                      child: Text(
                        '查看更多 >',
                        style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // 轮播图
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.17,
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
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.5),
                              //     spreadRadius: 2,
                              //     blurRadius: 5,
                              //     offset: Offset(0, 3),
                              //   ),
                              // ],
                            ),
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            // margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: item),
                      )
                      .toList(),
                ),
                // 底部的圆形指示器
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildCard(String title, String subtitle, String price,
      String imagePath, String students) {
    return Container(
      // padding: EdgeInsets.all(8.0),
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
              width: 100,
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}
