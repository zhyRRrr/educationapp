import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class flex extends StatefulWidget {
  @override
  _flexState createState() => _flexState();
}

class _flexState extends State<flex> {
  final List<String> imgList = [
    "assets/images/c1.jpg",
    "assets/images/c2.jpg",
    "assets/images/c3.jpg",
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧轮播图
          Stack(
            children: [
              Container(
                width: 180,
                height: 240,
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
                          width: 180,
                          height: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              height: 240,
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
                _buildCard("BEC精选", "猫刀老师团队", "assets/images/举手.png"),
                SizedBox(height: 16),
                _buildCard("青山学堂GRE", "留学精选推荐", "assets/images/举手.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String imagePath) {
    return Container(
      height: 110,
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
              width: 80,
              height: 800,
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
