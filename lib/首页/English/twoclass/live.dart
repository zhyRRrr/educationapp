import 'package:education_app/course/oneclass/mathxiyoujiclass/Tab.dart';
import 'package:flutter/material.dart';

class TwoEnglishLive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.live_tv,
                    size: 35,
                    color: const Color.fromARGB(255, 246, 134, 171),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '热门课程',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 246, 134, 171)),
                  )
                ],
              ),
              Text(
                '更多课程 >',
                style: TextStyle(color: Color.fromARGB(255, 246, 134, 171)),
              )
            ],
          ),
        ),
        Container(
          height: 160,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
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
                              builder: (context) => Video1(),
                              settings: RouteSettings(
                                  arguments: {'disableBack': true}),
                            ),
                          );
                        }
                      },
                      child: LiveCard(
                        image: 'assets/images/直播1.jpg',
                        title: '【帕鱼鱼】追光探影—光影头像绘制...',
                        category: '绘画',
                        time: '下周六 19:30',
                      ),
                    ),
                    LiveCard(
                      image: 'assets/images/直播2.jpg',
                      title: '知识点串讲和游戏互动',
                      category: '数字课程',
                      time: '今天 14:00',
                    ),
                    LiveCard(
                      image: 'assets/images/直播3.jpg',
                      title: '【罗老师】公开课直播',
                      category: '公务员考试',
                      time: '07-22 06:30',
                    ),
                    LiveCard(
                      image: 'assets/images/直播4.jpg',
                      title: '【帕鱼鱼】追光探影—光影头像绘制...',
                      category: '绘画',
                      time: '下周六 19:30',
                    ),
                    LiveCard(
                      image: 'assets/images/直播5.jpg',
                      title: '【帕鱼鱼】追光探影—光影头像绘制...',
                      category: '绘画',
                      time: '下周六 19:30',
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class LiveCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String time;

  LiveCard({
    required this.image,
    required this.title,
    required this.category,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: 80,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '【$category】 $title',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
