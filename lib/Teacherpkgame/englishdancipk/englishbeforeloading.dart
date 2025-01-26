import 'package:education_app/student.dart';
import 'englishMatchSuccessPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(EnglishWord());
}

class EnglishWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PKModePage(),
    );
  }
}

class PKModePage extends StatefulWidget {
  @override
  _PKModePageState createState() => _PKModePageState();
}

class _PKModePageState extends State<PKModePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer; // 声明 Timer 变量

  @override
  void initState() {
    super.initState();

    // 初始化 AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true); // 反向重复动画

    // 定义 Tween 动画
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // 创建 Timer 以在 5 秒后跳转到另一个页面
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MatchSuccessPage1()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放控制器
    _timer.cancel(); // 取消定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 0, 255, 179),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100, // 顶部绿色区域的高度
                      color: Color.fromARGB(255, 0, 255, 179),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tabs(initialIndex: 1),
                                    settings: RouteSettings(
                                        arguments: {'disableBack': true}),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100, // 顶部绿色区域的高度
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center, // 确保文本在行中居中
                              child: Text(
                                'PK模式',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30)), // 加入顶部左右圆角
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // 动态绿色圆环
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Container(
                                    width: 200 +
                                        (_animation.value * 100), // 动态改变大小
                                    height: 200 + (_animation.value * 100),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color.fromARGB(255, 0, 255, 179)
                                            .withOpacity(
                                                1 - _animation.value), // 随距离减淡
                                        width: 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // 中间白色圆形
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(Icons.search, size: 40),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('正在为您匹配对局...'), // 文字位于白色圆形下边
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 放置取消按钮
          Positioned(
            left: 16,
            right: 16,
            bottom: 30, // 距离底部的距离
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 255, 179),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Tabs(initialIndex: 1),
                      settings: RouteSettings(arguments: {'disableBack': true}),
                    ));
              },
              child: Text(
                '取消',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
