import 'package:education_app/Studentpkgame/chineseshicipk/chinesebeforeloading.dart';
import 'package:education_app/Studentpkgame/englishdancipk/englishbeforeloading.dart';
import 'package:education_app/Studentpkgame/mathaddpk/mathbeforeloading.dart';
import 'package:education_app/Studentpkgame/mathchengchupk/mathbeforeloading.dart';
import 'package:education_app/Teacherpkgame/chineseshigepk/Inputpage.dart';
import 'package:flutter/material.dart';
import '../../Teacherpkgame/englishjuzipk/Inputpage.dart';

void main() {
  runApp(ClassAfter());
}

class ClassAfter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Classafter(),
    );
  }
}

class Classafter extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': '语文诗歌pk',
      'number': 0,
      'image':
          'https://img.zcool.cn/community/01121d5ddd149ba80120686b38a76d.jpg@1280w_1l_2o_100sh.jpg',
      'page': Chineseshici(),
      'header': '语文诗词pk',
    },
    {
      'title': '语文古诗词pk',
      'number': 0,
      'image':
          'https://bpic.588ku.com/Templet_origin_pic/04/96/37/4bb241b5bbe5cba97659a4dddca80d61.jpg',
      'page': GroupInputPage(),
      'header': '古诗词主题',
    },
    {
      'title': '数学加减法',
      'number': 0,
      'image':
          'https://is2-ssl.mzstatic.com/image/thumb/Purple19/v4/42/8b/b6/428bb6d5-f252-bf61-cd95-ea727fd964a6/source/512x512bb.jpg',
      'page': MathAdd(),
      'header': '数学pk',
    },
    {
      'title': '数学乘除法',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.a453a567ceea4d2b5dd10ae9cb2bbcc5?rik=vBK94z656xMzpw&riu=http%3a%2f%2fpic.ntimg.cn%2f20131215%2f4499633_151124056318_2.jpg&ehk=n73a2orEbJl69dArbN87Owu0utXtyqs26%2fTucgHHYdE%3d&risl=&pid=ImgRaw&r=0',
      'page': Mathchengchu(),
      'header': '数学主题 - 乘除法',
    },
    {
      'title': '英语单词pk',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.66f1ea4449c7506c335fea54e223732d?rik=TY9uMAHbgBhg2Q&riu=http%3a%2f%2f5b0988e595225.cdn.sohucs.com%2fimages%2f20171128%2fddba07ee2c78408eb184e837e2f40b1e.jpeg&ehk=JiXEtC0JR0WuzcGD2oYTOgZFMP0BxVGN5Pm6WDugeIk%3d&risl=&pid=ImgRaw&r=0',
      'page': EnglishWord(),
      'header': '英语单词',
    },
    {
      'title': '英语句子',
      'number': 0,
      'image':
          'https://th.bing.com/th/id/R.66f1ea4449c7506c335fea54e223732d?rik=TY9uMAHbgBhg2Q&riu=http%3a%2f%2f5b0988e595225.cdn.sohucs.com%2fimages%2f20171128%2fddba07ee2c78408eb184e837e2f40b1e.jpeg&ehk=JiXEtC0JR0WuzcGD2oYTOgZFMP0BxVGN5Pm6WDugeIk%3d&risl=&pid=ImgRaw&r=0',
      'page': EnglishGroupInputPage(),
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
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: _buildRoundedRectangle(context, firstItem),
            ),
          ),
          if (secondItem != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: _buildRoundedRectangle(context, secondItem),
              ),
            ),
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
                fit: BoxFit.cover,
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
