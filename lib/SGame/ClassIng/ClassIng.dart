import 'package:education_app/Book/Book.dart';
import 'package:flutter/material.dart';
import 'video.dart';

class ClassIngActivityPage extends StatefulWidget {
  @override
  _ClassIngActivityPageState createState() => _ClassIngActivityPageState();
}

class _ClassIngActivityPageState extends State<ClassIngActivityPage> {
  int selectedIndex = 0;
  final List<String> buttons = [
    '课堂互动知识',
    '课本',
  ];
  final List<Map<String, dynamic>> content = [
    {
      'mainVideo': {
        'title': '功夫熊猫说背乘法表',
        'description': '来看看你的乘法表是不是很熟练了',
        'thumbnail': 'assets/images/2.0x/ketang1.jpg'
      },
      'videos': [
        {
          'title': '辨别颜色',
          'views': '1.8万',
          'thumbnail': 'assets/images/3.0x/课前1.jpg'
        },
        {
          'title': '小学英语词汇汇总',
          'views': '1.6万',
          'thumbnail': 'assets/images/2.0x/1.jpg'
        },
      ]
    },
  ];

  final List<Widget> mainVideoPages = [
    Video(
      videoPath: 'assets/video/class/class2.mp4',
    ),
  ];

  final List<List<Widget>> videoPages = [
    [
      Video(
        videoPath: 'assets/video/class/class.mp4',
      ),
      Video(
        videoPath: 'assets/video/english1.mp4',
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == index ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      buttons[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: selectedIndex == 1 // 如果选中的是"课本"按钮
              ? Book() // 显示Book类的内容
              : SingleChildScrollView(
                  child: Column(
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
                                  builder: (context) =>
                                      mainVideoPages[selectedIndex]),
                            );
                          }
                        },
                        child: MainVideoSection(
                            content[selectedIndex]['mainVideo']),
                      ),
                      SizedBox(height: 10),
                      VideoGrid(content[selectedIndex]['videos'],
                          videoPages[selectedIndex]),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class MainVideoSection extends StatelessWidget {
  final Map<String, String> mainVideo;

  MainVideoSection(this.mainVideo);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(mainVideo['thumbnail']!,
                height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(mainVideo['title']!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(mainVideo['description']!),
        ),
      ],
    );
  }
}

class VideoGrid extends StatelessWidget {
  final List<Map<String, String>> videos;
  final List<Widget> videoPages;

  VideoGrid(this.videos, this.videoPages);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth < 600 ? 2 : 3, // 根据屏幕宽度调整列数
            childAspectRatio: 1,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                bool A = false;
                await Future.delayed(Duration(seconds: 0));
                A = true;
                if (A) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => videoPages[index]),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(videos[index]['thumbnail']!,
                          height: screenWidth < 600 ? 100 : 120, // 根据屏幕宽度调整图片高度
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: 5),
                    Text(
                      videos[index]['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 600 ? 14 : 16, // 根据屏幕宽度调整文字大小
                      ),
                      textScaleFactor: textScaleFactor,
                    ),
                    SizedBox(height: 2),
                    Text(
                      videos[index]['views']!,
                      style: TextStyle(
                        fontSize: screenWidth < 600 ? 12 : 14, // 根据屏幕宽度调整文字大小
                      ),
                      textScaleFactor: textScaleFactor,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
