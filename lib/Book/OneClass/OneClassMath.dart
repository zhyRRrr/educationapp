import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Slider',
      home: Oneclassmath(),
    );
  }
}

class Oneclassmath extends StatefulWidget {
  @override
  _OneclassmathState createState() => _OneclassmathState();
}

class _OneclassmathState extends State<Oneclassmath> {
  final List<String> imgList = [
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e004a5ckkep4m64gtujch8?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e0g4a5ckkep4m64ode4c0g?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e104a5ckkep4m64b44n9ng?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e1g4a5ckkep4m64r8ps1t0?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e204a5ckkep4m64jlg39io?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e2g4a5ckkep4m645kms578?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e304a5ckkep4m647ho31ho?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e3g4a5ckkep4m64h4oqt6o?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e404a5ckkep4m6474nav10?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e4g4a5ckkep4m64a0ckjn8?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e504a5ckkep4m64vlt5s80?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830ndvt3hh6e5g4a5ckkep4m64qpjaj80?imageView2/2/w/0/format/webp',
  ];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              // 检查 _pageController.page 是否为 null
              // 用于获取当前在 PageView 中显示的页面的索引
              // 这个属性返回的是一个 double 类型的值，
              // 表示在当前页面和下一个页面之间的进度。
              // page 是一个 double 值。例如：
              // 当在页面 0 和页面 1 之间滑动时，
              //page 的值可能是 0.0（在页面 0 上）到 1.0（在页面 1 上），
              //也可能是 0.5（表示正处于页面 0 和页面 1 之间的中间位置）。
              // 这个属性在页面切换时非常有用，
              // 因为它可以帮助你计算当前页面与周围页面之间的关系，
              // 从而实现动画效果（如翻转、缩放等）。
              final page = _pageController.page;
              if (page == null) return Container(); // 或者返回一个默认的 Widget

              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(page - index),
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imgList[index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
