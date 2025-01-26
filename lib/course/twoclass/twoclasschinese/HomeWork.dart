import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class MathQuizPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 强制横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      home: MathQuizPage(),
    );
  }
}

class MathQuizPage extends StatefulWidget {
  @override
  _MathQuizPageState createState() => _MathQuizPageState();
}

class _MathQuizPageState extends State<MathQuizPage> {
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _questions = [
    {
      'image': 'assets/images/xiyouji/xiyouji1.jpg',
      'question': '5 + 3 = ?',
      'answer': 8,
      'sound': 'assets/xiyouji/sound/mistang.wav',
      'explanation': '5加3等于8，因为5加3就是8。',
    },
    {
      'image': 'assets/images/xiyouji/xiyouji2.jpg',
      'question': '10 - 4 = ?',
      'answer': 6,
      'sound': 'assets/xiyouji/sound/missun.wav',
      'explanation': '10减4等于6，因为10减4就是6。',
    },
    {
      'image': 'assets/images/xiyouji/xiyouji3.jpg',
      'question': '10 - 4 = ?',
      'answer': 6,
      'sound': 'assets/xiyouji/sound/miszhu.wav',
      'explanation': '10减4等于6，因为10减4就是6。',
    },
    {
      'image': 'assets/images/xiyouji/xiyouji4.jpg',
      'question': '10 - 4 = ?',
      'answer': 6,
      'sound': 'assets/xiyouji/sound/missah.wav',
      'explanation': '10减4等于6，因为10减4就是6。',
    }
    // 更多问题...
  ];
  final TextEditingController _answerController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _checkAnswer(int index) {
    int userAnswer = int.tryParse(_answerController.text) ?? -1;
    if (userAnswer == _questions[index]['answer']) {
      _audioPlayer.play(AssetSource(_questions[index]['sound']));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('回答正确!')),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('回答错误'),
            content: Text(
                '正确答案: ${_questions[index]['answer']}\n解题思路: ${_questions[index]['explanation']}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('确定'),
              ),
            ],
          );
        },
      );
    }
    _answerController.clear();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _answerController.dispose();
    _audioPlayer.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('数学问答'),
        backgroundColor: Colors.white,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: Image.asset(_questions[index]['image']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_questions[index]['question'],
                          style: TextStyle(fontSize: 24)),
                      TextField(
                        controller: _answerController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: '请输入答案'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _checkAnswer(index),
                        child: Text('提交'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
