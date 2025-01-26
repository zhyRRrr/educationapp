import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D翻转效果',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageSlider(),
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<String> _images = [
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Add a listener to the PageController
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _images.length,
          itemBuilder: (context, index) {
            // Calculate the rotation angle based on the current index
            double angle = (_currentIndex - index).toDouble();
            // Apply 3D transformation
            return Transform(
              transform: Matrix4.rotationY(angle * pi / 2),
              alignment: Alignment.center,
              child: Opacity(
                opacity: (1 - angle.abs()).clamp(0.0, 1.0),
                child: Image.network(
                  _images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
