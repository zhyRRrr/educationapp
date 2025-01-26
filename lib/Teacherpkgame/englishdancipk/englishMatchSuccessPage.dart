import 'package:education_app/student.dart';
import 'englishpkgame.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MatchSuccessPage1());
}

class MatchSuccessPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MatchSuccessPage(),
    );
  }
}

class MatchSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在页面构建时启动一个定时器
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EnglishDanci()), // 替换为你的目标页面
      );
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Tabs(initialIndex: 1),
                  settings: RouteSettings(arguments: {'disableBack': true}),
                )); // 点击返回
          },
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset(
              'assets/images/2.0x/success.png', // 替换为你的图片链接
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildProfileCard('张小花', '8岁', Colors.blue[100]!),
                    _buildProfileCard('李俊宁', '8岁', Colors.orange[100]!),
                  ],
                ),
                Positioned(
                  top: 30, // 调整位置以适应覆盖
                  child: Image.asset('assets/images/2.0x/vs.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String name, String age, Color color) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/3.0x/1.jpg'), // 替换为头像链接
          ),
          SizedBox(height: 10),
          Text(name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(age, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
