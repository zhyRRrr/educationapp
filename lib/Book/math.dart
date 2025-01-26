import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '写字与图片切换',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mathwork(),
    );
  }
}

class Mathwork extends StatefulWidget {
  @override
  _MathworkState createState() => _MathworkState();
}

class _MathworkState extends State<Mathwork> {
  PageController _pageController = PageController();
  bool isDrawing = false; // 控制是否在写字

  final List<String> imagePaths = [
    'https://ci.xiaohongshu.com/1000g0082mib6fbsji0605oadkv40jfl1dujscbg?imageView2/2/w/0/format/jpg',
    'https://ci.xiaohongshu.com/1000g0082mib6fbsji0505oadkv40jfl1odgr0h8?imageView2/2/w/0/format/jpg',
    'https://ci.xiaohongshu.com/1000g0082mib6fbsji04g5oadkv40jfl1kh73v7o?imageView2/2/w/0/format/jpg',
  ];

  final List<List<Offset?>> allPoints = [];

  @override
  void initState() {
    super.initState();
    allPoints.addAll(List.generate(imagePaths.length, (_) => []));
  }

  void toggleDrawing() {
    setState(() {
      isDrawing = !isDrawing; // 切换写字状态
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('语文配套练习'),
        actions: [
          IconButton(
            icon: Icon(isDrawing ? Icons.exit_to_app : Icons.edit),
            onPressed: toggleDrawing, // 点击按钮切换写字状态
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: imagePaths.length,
        physics: isDrawing
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.network(
                imagePaths[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              GestureDetector(
                onPanStart: (details) {
                  if (isDrawing) {
                    setState(() {
                      allPoints[index].add(details.localPosition); // 开始绘制
                    });
                  }
                },
                onPanUpdate: (details) {
                  if (isDrawing) {
                    setState(() {
                      allPoints[index].add(details.localPosition);
                    });
                  }
                },
                onPanEnd: (details) {
                  if (isDrawing) {
                    setState(() {
                      allPoints[index].add(null); // 添加分隔符
                    });
                  }
                },
                child: CustomPaint(
                  painter: DrawingPainter(allPoints[index]),
                  child: Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
