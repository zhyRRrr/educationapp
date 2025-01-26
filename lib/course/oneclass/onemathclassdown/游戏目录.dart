import 'package:flutter/material.dart';
import '../.././oneclass/onemathclassdown/HomeWork.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('作业'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '数学理解',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                GestureDetector(
                  onTap: () async {
                    bool A = false;
                    await Future.delayed(Duration(seconds: 1));
                    A = true;
                    if (A) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MathQuizPage1()),
                      );
                    }
                  },
                  child: CategoryCard(
                      title: '数学加减法',
                      // price: '',
                      imageUrl: 'assets/images/xiyouji/xiyouji1.jpg'),
                ),
                CategoryCard(
                    title: '时钟分化',
                    // price: '',
                    imageUrl: 'assets/images/xiyouji/xiyouji1.jpg'),
                CategoryCard(
                    title: '乘除法的运用',
                    // price: '',
                    imageUrl: 'assets/images/xiyouji/xiyouji1.jpg'),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '数学提升',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                CategoryCard(
                    title: '平分正方形',
                    imageUrl: 'assets/images/xiyouji/xiyouji2.jpg'),
                CategoryCard(
                    title: '多位数乘',
                    imageUrl: 'assets/images/xiyouji/xiyouji3.jpg'),
                CategoryCard(
                    title: '小伙伴读物',
                    imageUrl: 'assets/images/xiyouji/xiyouji4.jpg'),
                CategoryCard(
                    title: '一本小漫画',
                    imageUrl: 'assets/images/xiyouji/xiyouji2.jpg'),
                CategoryCard(
                    title: '阳光数学',
                    imageUrl: 'assets/images/xiyouji/xiyouji3.jpg'),
                CategoryCard(
                    title: '数学测试',
                    imageUrl: 'assets/images/xiyouji/xiyouji4.jpg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  // final String price;
  final String imageUrl;

  CategoryCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 255, 255)),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 77, 77),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
