import 'package:flutter/material.dart';

class HorizontalScrollGrid extends StatefulWidget {
  @override
  _HorizontalScrollGridState createState() => _HorizontalScrollGridState();
}

class _HorizontalScrollGridState extends State<HorizontalScrollGrid> {
  final List items = [
    {'icon': Icons.language, 'text': '英语·留学', 'color': Colors.purple},
    {'icon': Icons.account_balance, 'text': '公考·考证', 'color': Colors.orange},
    {'icon': Icons.school, 'text': '考研', 'color': Colors.green},
    {'icon': Icons.brush, 'text': '绘画·兴趣', 'color': Colors.pink},
    {'icon': Icons.computer, 'text': '设计·IT', 'color': Colors.red},
    {'icon': Icons.access_time, 'text': '免费打卡', 'color': Colors.purple},
    {'icon': Icons.translate, 'text': '日韩小语种', 'color': Colors.orangeAccent},
    {'icon': Icons.book, 'text': '沪江网校', 'color': Colors.redAccent},
    {'icon': Icons.language, 'text': '语言畅学', 'color': Colors.deepOrangeAccent},
    {'icon': Icons.favorite, 'text': '好课优选', 'color': Colors.purple},
    {'icon': Icons.access_time, 'text': '免费好课', 'color': Colors.pinkAccent},
    {
      'icon': Icons.business_center,
      'text': '职业规划',
      'color': Color.fromARGB(255, 172, 13, 184)
    },
  ];

  double _scrollPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 水平滚动的图标网格
        Container(
          height: 137,
          //监听滚动事件
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              setState(() {
                // scrollInfo.metrics 提供了有关滚动位置和大小的度量信息。
                // pixels 属性表示当前滚动位置的像素值，即用户当前所处的滚动位置。
                _scrollPosition = scrollInfo.metrics.pixels;
              });
              return true;
            },
            //水平滚动
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      // 第一排图标
                      Row(
                        children: items.sublist(0, 6).map((item) {
                          return Container(
                            // 五个图标宽度
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item['icon'],
                                  size: 35,
                                  color: item['color'],
                                ),
                                SizedBox(height: 4),
                                Text(item['text'],
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 12),
                      // 第二排图标
                      Row(
                        children: items.sublist(6).map((item) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(item['icon'],
                                    size: 35, color: item['color']),
                                SizedBox(height: 4),
                                Text(item['text'],
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 10),
        // 指示器
        Container(
          width: MediaQuery.of(context).size.width * 0.108,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                left: (_scrollPosition /
                        (items.length * 60 -
                            MediaQuery.of(context).size.width)) *
                    80,
                child: Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
