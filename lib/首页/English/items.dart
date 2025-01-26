import 'package:education_app/videopage/pages/video_page.dart';
import 'package:flutter/material.dart';
import '../../teacher.dart'; // 导入main.dart文件
import '../TrainCamp.dart';

class Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    builder: (context) => TainCamp(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildIconColumn('训练营', 'assets/icons/福利.png'),
          ),
          GestureDetector(
            onTap: () async {
              bool A = false;
              await Future.delayed(Duration(seconds: 0));
              A = true;
              if (A) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => videopage123(),
                    settings: RouteSettings(arguments: {'disableBack': true}),
                  ),
                );
              }
            },
            child: _buildIconColumn('视频学习', 'assets/icons/一对一.png', free: true),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Tabs(initialIndex: 1),
                  settings: RouteSettings(arguments: {'disableBack': true}),
                ),
              );
            },
            child: _buildIconColumn('游戏角逐', 'assets/icons/moreclass.png'),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Tabs(initialIndex: 3),
                  settings: RouteSettings(arguments: {'disableBack': true}),
                ),
              );
            },
            child: _buildIconColumn('查看动态', 'assets/icons/video.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildIconColumn(String label, String iconPath, {bool free = false}) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
            if (free)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '免费',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
