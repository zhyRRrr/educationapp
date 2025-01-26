import 'package:flutter/material.dart';

import 'chinese.dart';
import 'english.dart';
import 'math.dart';

void main() {
  runApp(ClassAfter());
}

class ClassAfter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: classwork(),
    );
  }
}

class classwork extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': '语文配套练习',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.b65dfcdad8e356a234c552bcf20a9efc?rik=GoDkZuHTTJuhAw&riu=http%3a%2f%2fwww.guoxuemeng.com%2ffiles%2fimg%2f2002%2f1-200206141025C6.jpeg&ehk=TNQI%2bbJa59XgGzNuNPjuIf19LudqB%2b9qghHNu2cIRe8%3d&risl=&pid=ImgRaw&r=0',
      'page': Chinesework(),
      'header': '语文配套练习',
    },
    {
      'title': '语文古诗词',
      'number': 0,
      'image':
          'https://bpic.588ku.com/Templet_origin_pic/04/96/37/4bb241b5bbe5cba97659a4dddca80d61.jpg',
      'page': Chinesework(),
      'header': '古诗词主题',
    },
    {
      'title': '数学配套练习',
      'number': 0,
      'image':
          'https://is2-ssl.mzstatic.com/image/thumb/Purple19/v4/42/8b/b6/428bb6d5-f252-bf61-cd95-ea727fd964a6/source/512x512bb.jpg',
      'page': Mathwork(),
      'header': '数学加减法',
    },
    {
      'title': '数学乘除法',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.a453a567ceea4d2b5dd10ae9cb2bbcc5?rik=vBK94z656xMzpw&riu=http%3a%2f%2fpic.ntimg.cn%2f20131215%2f4499633_151124056318_2.jpg&ehk=n73a2orEbJl69dArbN87Owu0utXtyqs26%2fTucgHHYdE%3d&risl=&pid=ImgRaw&r=0',
      'page': Mathwork(),
      'header': '数学主题 - 乘除法',
    },
    {
      'title': '英语单词',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.66f1ea4449c7506c335fea54e223732d?rik=TY9uMAHbgBhg2Q&riu=http%3a%2f%2f5b0988e595225.cdn.sohucs.com%2fimages%2f20171128%2fddba07ee2c78408eb184e837e2f40b1e.jpeg&ehk=JiXEtC0JR0WuzcGD2oYTOgZFMP0BxVGN5Pm6WDugeIk%3d&risl=&pid=ImgRaw&r=0',
      'page': Englishwork(),
      'header': '英语单词',
    },
    {
      'title': '英语句子',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.66f1ea4449c7506c335fea54e223732d?rik=TY9uMAHbgBhg2Q&riu=http%3a%2f%2f5b0988e595225.cdn.sohucs.com%2fimages%2f20171128%2fddba07ee2c78408eb184e837e2f40b1e.jpeg&ehk=JiXEtC0JR0WuzcGD2oYTOgZFMP0BxVGN5Pm6WDugeIk%3d&risl=&pid=ImgRaw&r=0',
      'page': Englishwork(),
      'header': '英语主题 - 阅读',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildRows(context),
        ),
      ),
    );
  }

  List<Widget> _buildRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < (items.length / 2).ceil(); i++) {
      final firstItem = items[i * 2];
      final secondItem = i * 2 + 1 < items.length ? items[i * 2 + 1] : null;

      // 添加标题
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          firstItem['header'], // 使用每个项目的 header
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ));

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildRoundedRectangle(context, firstItem),
          SizedBox(width: 10), // 添加间距
          if (secondItem != null) _buildRoundedRectangle(context, secondItem),
        ],
      ));
      rows.add(SizedBox(height: 10)); // 每行间隔
    }
    return rows;
  }

  Widget _buildRoundedRectangle(
      BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item['page']),
        );
      },
      child: Container(
        width: 160, // 设置卡片宽度
        height: 250,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                item['image'],
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(item['title'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              if (item['number'] > 0)
                Text('${item['number']}', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

// 定义不同的详情页面
class DetailPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('人体')),
      body: Center(child: Text('欢迎来到人体页面！')),
    );
  }
}

class DetailPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('多科学习')),
      body: Center(child: Text('欢迎来到多科学习页面！')),
    );
  }
}

class DetailPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('鱼类')),
      body: Center(child: Text('欢迎来到鱼类页面！')),
    );
  }
}

class DetailPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('冬梦飞扬')),
      body: Center(child: Text('欢迎来到冬梦飞扬页面！')),
    );
  }
}

class DetailPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('神奇校车')),
      body: Center(child: Text('欢迎来到神奇校车页面！')),
    );
  }
}

class DetailPage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('小伙伴阅读')),
      body: Center(child: Text('欢迎来到小伙伴阅读页面！')),
    );
  }
}
