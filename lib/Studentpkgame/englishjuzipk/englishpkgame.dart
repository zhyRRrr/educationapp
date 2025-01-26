import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../Teacherpkgame/fenzupk/pk_results_manager.dart';

class Englishpkgame extends StatefulWidget {
  final String team1Leader;
  final String team2Leader;
  final List<String> team1Members;
  final List<String> team2Members;

  Englishpkgame({
    required this.team1Leader,
    required this.team2Leader,
    required this.team1Members,
    required this.team2Members,
  });

  @override
  _EnglishpkgameState createState() => _EnglishpkgameState();
}

class _EnglishpkgameState extends State<Englishpkgame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;

  int score = 60; // 用户分数
  int opponentScore = 60; // 对手分数
  int questionIndex = 0;
  int timerValue = 19; // 计时器初始值
  String userAnswer = '';
  String opponentAnswer = ''; // 对手答案
  bool showResult = false; // 控制结果显示
  String resultText = " "; // 默认值

  List<Map<String, String>> questions = [
    {
      "question": "我爱你",
      "A": "I love you",
      "B": "I like you",
      "C": "I hate you",
      "D": "I miss you",
      "correct": "A"
    },
    {
      "question": "今天天气很好",
      "A": "The weather is bad today",
      "B": "The weather is nice today",
      "C": "Today is a hot day",
      "D": "Today is a rainy day",
      "correct": "B"
    },
    {
      "question": "你好吗？",
      "A": "How are you?",
      "B": "How old are you?",
      "C": "Where are you?",
      "D": "What are you doing?",
      "correct": "A"
    },
    {
      "question": "我们去海边吧",
      "A": "Let’s go to the beach",
      "B": "Let’s stay home",
      "C": "Let’s go shopping",
      "D": "Let’s go to the park",
      "correct": "A"
    },
    {
      "question": "这个多少钱？",
      "A": "How much is this?",
      "B": "Where is this?",
      "C": "What is this?",
      "D": "Who is this?",
      "correct": "A"
    },
    // 可以添加更多题目
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerValue > 0) {
        if (mounted) {
          setState(() {
            timerValue--;
          });
        }
      } else {
        timer.cancel();
        if (mounted) {
          checkAnswer(userAnswer, timeout: true);
        }
      }
    });
  }

  void checkAnswer(String answer, {bool timeout = false}) {
    if (!timeout && answer.isEmpty) return;

    if (timeout) {
      score -= 5;
    } else {
      bool isCorrect = (answer == questions[questionIndex]['correct']);
      if (isCorrect) {
        score += 10;
      } else {
        score -= 5;
      }
    }

    setOpponentAnswer(answer);

    if (opponentAnswer == questions[questionIndex]['correct']) {
      opponentScore += 10;
    } else {
      opponentScore -= 5;
    }

    if (questionIndex + 1 >= questions.length) {
      showResult = true;

      PKResultsManager().addResult(
        widget.team1Leader,
        widget.team2Leader,
        score,
        opponentScore,
        team1Members: widget.team1Members,
        team2Members: widget.team2Members,
      );

      if (score > opponentScore) {
        resultText = "恭喜${widget.team1Leader}小队获得本次比赛胜利";
      } else if (score < opponentScore) {
        resultText = "恭喜${widget.team2Leader}小队获得本次比赛胜利";
      } else {
        resultText = "本次比赛平局";
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      updateQuestion();
    }
  }

  void setOpponentAnswer(String playerAnswer) {
    List<String> options = ['A', 'B', 'C', 'D'];
    options.remove(playerAnswer);
    opponentAnswer = options[Random().nextInt(options.length)];
  }

  void updateQuestion() {
    setState(() {
      questionIndex = (questionIndex + 1) % questions.length;
      userAnswer = '';
      opponentAnswer = '';
      timerValue = 19;
    });
    startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];

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
                      height: 100,
                      color: Color.fromARGB(255, 0, 255, 179),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('${widget.team1Leader}小队',
                                      style: TextStyle(fontSize: 20)),
                                  Container(
                                    width: 200,
                                    child: LinearProgressIndicator(
                                        value: score / 100),
                                  ),
                                  Text('$score 分'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('${widget.team2Leader}小队',
                                      style: TextStyle(fontSize: 20)),
                                  Container(
                                    width: 200,
                                    child: LinearProgressIndicator(
                                        value: opponentScore / 100),
                                  ),
                                  Text('$opponentScore 分'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('${questionIndex + 1} / ${questions.length}',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 20),
                          Text(question['question']!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 20),
                          Expanded(
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text(question['A']!),
                                  leading: Radio(
                                    value: 'A',
                                    groupValue: userAnswer,
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(question['B']!),
                                  leading: Radio(
                                    value: 'B',
                                    groupValue: userAnswer,
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(question['C']!),
                                  leading: Radio(
                                    value: 'C',
                                    groupValue: userAnswer,
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(question['D']!),
                                  leading: Radio(
                                    value: 'D',
                                    groupValue: userAnswer,
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              checkAnswer(userAnswer);
                            },
                            child: Text('确认答案'),
                          ),
                          SizedBox(height: 20),
                          Text('剩余时间: $timerValue 秒',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showResult)
            Container(
                color: Colors.black54,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 450,
                          height: 400,
                          child: Card(
                            color: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    resultText,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '${widget.team1Leader}: $score',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '${widget.team2Leader}: $opponentScore',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        score = 60;
                                        opponentScore = 60;
                                        questionIndex = 0;
                                        timerValue = 19;
                                        userAnswer = '';
                                        opponentAnswer = '';
                                        showResult = false;
                                        resultText = " ";
                                      });
                                      startTimer();
                                    },
                                    child: Text('再来一局'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('返回首页'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child:
                            Image.asset('assets/images/2.0x/successzhihou.png'))
                  ],
                )),
        ],
      ),
    );
  }
}
