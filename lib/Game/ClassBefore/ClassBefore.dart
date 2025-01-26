import 'package:education_app/Game/ClassIng/video.dart';
import 'package:flutter/material.dart';
import 'babyshark/babyshark.dart';
import 'IdentifyColor/IdentifyColor.dart';
import 'UptowmFunk/UptownFunk.dart';
import 'PingFong/PingFong.dart';
import 'babyshark/dance/Dance.dart';
import './BilndBox.dart';
import './turntable.dart';

class ClassroomActivityPage extends StatefulWidget {
  @override
  _ClassroomActivityPageState createState() => _ClassroomActivityPageState();
}

class _ClassroomActivityPageState extends State<ClassroomActivityPage> {
  int selectedIndex = 0;
  final List<String> buttons = ['课前舞蹈', '抽奖抽签', '计分计时'];
  final List<Map<String, dynamic>> content = [
    {
      'mainVideo': {
        'title': 'Baby shark节奏舞',
        'description': '来课前体验一下Baby shark的舞蹈吧',
        'thumbnail': 'assets/images/3.0x/课前2.jpg'
      },
      'videos': [
        {
          'title': '辨别颜色',
          'views': '1.8万',
          'thumbnail': 'assets/images/3.0x/课前1.jpg'
        },
        {
          'title': 'Uptown Funk舞蹈',
          'views': '1.6万',
          'thumbnail': 'assets/images/3.0x/课前3.jpg'
        },
        {
          'title': '魔性舞蹈',
          'views': '1.2万',
          'thumbnail': 'assets/images/3.0x/课前4.jpg'
        },
        {
          'title': 'Pink Fong 舞蹈',
          'views': '9270',
          'thumbnail': 'assets/images/3.0x/课前5.jpg'
        },
      ]
    },
    {
      'mainVideo': {
        'title': '惩罚盲盒',
        'description': '接受来自懒洋洋的惩罚吧',
        'thumbnail': 'assets/images/3.0x/blindbox.png'
      },
      'videos': [
        {
          'title': '幸运转盘',
          'views': '3.5万',
          'thumbnail': 'assets/images/3.0x/课前1.jpg'
        },
        {
          'title': '大奖抽签',
          'views': '2.1万',
          'thumbnail': 'assets/images/3.0x/课前1.jpg'
        },
      ]
    },
    {
      'mainVideo': {
        'title': '计时',
        'description': 'Description of the main video 4',
        'thumbnail': 'assets/images/2.0x/ketang3.jpg'
      },
      'videos': [
        {
          'title': '极速计时',
          'views': '5.0万',
          'thumbnail': 'assets/images/2.0x/ketang2.jpg'
        },
      ]
    },
  ];

  final List<Widget> mainVideoPages = [
    BabyShark(),
    BlindBox(),
    Video(videoPath: 'assets/video/jishi/jishi2.mp4')
  ];

  final List<List<Widget>> videoPages = [
    [
      IdentifyColor(),
      UptownFunk(),
      dance(),
      pingfong(),
    ],
    [
      TurnTable(),
      VideoDetailPage(),
    ],
    [
      Video(videoPath: 'assets/video/jishi/jishi2.mp4'),
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
        Flexible(
          child: SingleChildScrollView(
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
                  child: MainVideoSection(content[selectedIndex]['mainVideo']),
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

class MainVideoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Video Detail')),
      body: Center(child: Text('Main Video Detail Page')),
    );
  }
}

class VideoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Detail')),
      body: Center(child: Text('Video Detail Page')),
    );
  }
}
