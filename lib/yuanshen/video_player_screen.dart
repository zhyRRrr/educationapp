import 'package:education_app/yuanshen/NameInputPage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import './choujiangapk.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath; // 接收视频路径
  final List<String> selectedNames; // 接收抽中的名字

  VideoPlayerScreen({required this.videoPath, required this.selectedNames});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // 自动播放视频
        });
      });

    // 监听视频播放完成事件
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // 视频播放完毕
        _showSelectedNamesDialog();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // 在页面销毁时释放资源
    super.dispose();
  }

  void _showSelectedNamesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('抽中的名字'),
          content: Text(widget.selectedNames.join(', ')), // 显示抽中的名字
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(names: names),
                  ),
                ); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(), // 视频加载时显示的进度指示器
      ),
    );
  }
}
