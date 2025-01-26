import 'package:education_app/student.dart';
import 'package:education_app/teacher.dart';
import 'package:education_app/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Studentpublish/PostRepository.dart';
import 'Teacherpkgame/fenzupk/pk_results_manager.dart';
import 'Teacherpublish/PostRepository.dart';
import 'Teacherpublish/TeacherPostRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 确保插件初始化
  final manager = PKResultsManager(); // 确保在应用启动时实例化，加载数据
  await manager.loadResults(); // 显式调用加载数据
  await StudentPostRepository.initialize();
  await TeacherPostRepository.initialize();
  await CombinedPostRepository.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoleSelectionPage(),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 50, 198, 153),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 22),
                    Image.asset(
                      'assets/images/xuanze/1.png',
                      height: 140,
                    ),
                    SizedBox(width: 60),
                    Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          '欢迎来到智趣课堂!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Text(
                      '请选择你的身份',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Student()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/xuanze/student.png',
                            height: 120,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '学生',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 150),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Teacher()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/xuanze/teacher.png',
                            height: 120,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '老师',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
