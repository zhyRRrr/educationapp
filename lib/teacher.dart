import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'Studentpublish/PostRepository.dart';
import 'Teacherpublish/TeacherPostRepository.dart';
import 'teacher_logingra/lottie/lottie_demo.dart';
import 'teachermine/1.dart';
import '首页/首页.dart';
import './Game/GamePage.dart';
import 'Teacherpublish/Total.dart';
import 'Teacherpublish/PostPage.dart';
import 'Teacherpublish/PostRepository.dart';
import './timer_provider.dart'; // 引入计时器提供者

class Teacher extends StatelessWidget {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await StudentPostRepository.initialize();
    await TeacherPostRepository.initialize();
    await CombinedPostRepository.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(), // 初始化计时器提供者
      child: Teacher1(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<Widget> ipages = [
  HomePage(),
  Game(),
  HomePage(),
  Totaller(),
  UserProfilePage1()
];
bool qiehuan = true;

class Teacher1 extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: qiehuan ? Tabs() : LottieDemo(),
    );
  }
}

class Tabs extends StatefulWidget {
  final int initialIndex;
  const Tabs({super.key, this.initialIndex = 0});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final ImagePicker _picker = ImagePicker();
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _pickImages(BuildContext context) async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null && pickedImages.isNotEmpty) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostPage(selectedImages: pickedImages),
        ),
      );

      // 监听从 PostPage 返回的数据
      if (result != null && result is int) {
        setState(() {
          _currentIndex = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    // 检查是否需要显示对话框
    // WidgetsBinding.instance.addPostFrameCallback 是 Flutter 框架提供的一种方法，
    //允许你在当前帧绘制完成后执行某个函数。
    //在这里，它确保对话框是在 Flutter 完成当前框架的构建后显示的。
    //这对于避免构建期间的状态变化（例如，状态更新导致的重建）非常重要，因为在构建过程中不应该直接修改 UI
    if (timerProvider.shouldShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWarningDialog(context);
        timerProvider.resetDialogFlag(); // 重置对话框标志
      });
    }

    return Scaffold(
      body: ipages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "课堂"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "广场"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的"),
        ],
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
              size: 34,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _currentIndex = 2;
                _pickImages(context);
              });
            }),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("使用时间提醒"),
          content: Text("你已经使用本软件超过一个小时了，请休息一下！"),
          actions: <Widget>[
            TextButton(
              child: Text("休息一下"),
              onPressed: () {
                // 退出应用
                Navigator.of(context).pop(); // 关闭弹出框
                Future.delayed(Duration(milliseconds: 100), () {
                  // 关闭应用
                  SystemNavigator.pop();
                  // 或者使用 exit(0); 关闭应用
                });
              },
            ),
            TextButton(
              child: Text("继续使用"),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭弹出框
              },
            ),
          ],
        );
      },
    );
  }
}
