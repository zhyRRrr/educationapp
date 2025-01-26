import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:education_app/student.dart';
import 'pk_results_manager.dart';

void main() {
  runApp(PKModePage1());
}

class PKModePage1 extends StatelessWidget {
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
      "question": "“窗前明月光，疑是地上霜。”这句诗出自于（）",
      "A": "《夜书所见》",
      "B": "《怨夜书所见》",
      "C": "《枫桥夜泊》",
      "D": "《秋夕》",
      "correct": "A"
    },
    {
      "question": "“床前明月光，疑是地上霜。”出自哪首诗？",
      "A": "《静夜思》",
      "B": "《登鹳雀楼》",
      "C": "《春晓》",
      "D": "《望庐山瀑布》",
      "correct": "A"
    },
    // 可以添加更多题目
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
    // 初始化 AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true); // 反向重复动画
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
    // 如果答案为空且不是因为时间到达0触发的，就直接返回
    if (!timeout && answer.isEmpty) return;

    // 如果是超时，自动扣分
    if (timeout) {
      score -= 5; // 超时扣分
    } else {
      bool isCorrect = (answer == questions[questionIndex]['correct']);
      if (isCorrect) {
        score += 10;
      } else {
        score -= 5;
      }
    }

    // 处理对手的答案
    setOpponentAnswer(answer);

    // 更新对手分数
    if (opponentAnswer == questions[questionIndex]['correct']) {
      opponentScore += 10; // 对手答对
    } else {
      opponentScore -= 5; // 对手答错
    }

    // 如果所有问题都回答完成，显示结果
    if (questionIndex + 1 >= questions.length) {
      showResult = true;

      // 保存结果
      PKResultsManager().addResult(
        '张小花',
        '李俊宁',
        score,
        opponentScore,
      );

      // 显示结果文本
      if (score > opponentScore) {
        resultText = "恭喜张小花同学获得本次比赛胜利";
      } else if (score < opponentScore) {
        resultText = "恭喜李俊宁同学获得本次比赛胜利";
      } else {
        resultText = "本次比赛平局";
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      // 更新问题
      updateQuestion();
    }
  }

  void setOpponentAnswer(String playerAnswer) {
    // 对手随机选择一个答案，确保不与玩家选择的答案相同
    List<String> options = ['A', 'B', 'C', 'D'];
    options.remove(playerAnswer); // 移除玩家的答案
    opponentAnswer = options[Random().nextInt(options.length)]; // 随机选择一个不同的答案
  }

  void updateQuestion() {
    setState(() {
      questionIndex = (questionIndex + 1) % questions.length;
      userAnswer = '';
      opponentAnswer = ''; // 重置对手答案
      timerValue = 19; // 重置计时器
    });
    startTimer(); // 重新启动计时器
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放控制器
    _timer?.cancel(); // 取消定时器
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
                      height: 100, // 顶部区域的高度
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
                      height: 100, // 顶部区域的高度
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('张小花', style: TextStyle(fontSize: 20)),
                                  Container(
                                    width: 200, // 设置宽度
                                    child: LinearProgressIndicator(
                                        value: score / 100),
                                  ),
                                  Text('$score 分'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('李俊宁', style: TextStyle(fontSize: 20)),
                                  Container(
                                    width: 200, // 设置宽度
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
          if (showResult) // 显示结果覆盖层
            Container(
                color: Colors.black54,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topCenter, // 使Stack内容的顶部对齐
                  children: [
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 使Column内容居中
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
                                    '张小花: $score',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '李俊宁: $opponentScore',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // 重新加载游戏
                                      setState(() {
                                        score = 60;
                                        opponentScore = 60;
                                        questionIndex = 0;
                                        timerValue = 19;
                                        userAnswer = '';
                                        opponentAnswer = '';
                                        showResult = false;
                                        resultText = " "; // 重置结果文本
                                      });
                                      startTimer(); // 重新开始计时
                                    },
                                    child: Text('再来一局'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Tabs(initialIndex: 1),
                                            settings: RouteSettings(arguments: {
                                              'disableBack': true
                                            }),
                                          ));
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
