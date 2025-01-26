import 'package:education_app/yuanshen/NameInputPage.dart';
import 'package:education_app/yuanshen/choujiangwindows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(VideoBackgroundPage1());
}

class VideoBackgroundPage1 extends StatelessWidget {
  const VideoBackgroundPage1({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    return MaterialApp(home: VideoBackgroundPage());
  }
}

class VideoBackgroundPage extends StatefulWidget {
  @override
  _VideoBackgroundPageState createState() => _VideoBackgroundPageState();
}

class _VideoBackgroundPageState extends State<VideoBackgroundPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/yuanshenbac.mp4')
      ..initialize().then((_) {
        setState(() {}); // 更新状态以显示视频
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebFileOperationsPage1(),
                      ),
                    );
                  },
                  child: Container(
                    height: 180,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/yuanshen/keqing.webp',
                            width: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text('电脑上面抽奖'),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NameInputPage1(),
                      ),
                    );
                  },
                  child: Container(
                    height: 180,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/yuanshen/nahida.webp',
                            width: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text('手机上面抽奖'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
