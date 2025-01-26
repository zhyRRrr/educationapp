import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class Tree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    return MaterialApp(
      home: Scaffold(
        body: AnimalSoundBoard(),
      ),
    );
  }
}

class AnimalSoundBoard extends StatefulWidget {
  @override
  _AnimalSoundBoardState createState() => _AnimalSoundBoardState();
}

class _AnimalSoundBoardState extends State<AnimalSoundBoard> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _showOptionsDialog(
      BuildContext context, String audioPath, String videoPath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('选择操作'),
          content: Text('请选择要进行的操作：'),
          actions: [
            TextButton(
              child: Text('播放音频'),
              onPressed: () {
                Navigator.of(context).pop();
                _playSound(audioPath);
              },
            ),
            TextButton(
              child: Text('观看视频'),
              onPressed: () {
                Navigator.of(context).pop();
                _playVideo(context, videoPath);
              },
            ),
          ],
        );
      },
    );
  }

  void _playSound(String soundPath) {
    _audioPlayer.play(AssetSource(soundPath));
  }

  void _playVideo(BuildContext context, String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(videoPath: videoPath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 背景图片
        Image.asset(
          'assets/images/zoo1.jpg', // 背景图片路径
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),

        Center(
          child: Image.asset(
            'assets/images/zoo.png',
            width: screenWidth * 0.9, // 动物图片路径
            height: screenHeight * 0.9,
            fit: BoxFit.contain,
          ),
        ),

        // 狮子按钮
        Positioned(
          left: screenWidth * 0.275,
          top: screenHeight * 0.10,
          child: GestureDetector(
            onTap: () => _showOptionsDialog(context, 'sounds/lion.mp3',
                'assets/video/lion.mp4'), // 狮子音频和视频路径
            child: Container(
              width: screenWidth * 0.08,
              height: screenHeight * 0.1,
              color: Colors.transparent,
            ),
          ),
        ),
        // 大象按钮
        Positioned(
          left: screenWidth * 0.16,
          top: screenHeight * 0.09,
          child: GestureDetector(
            onTap: () => _showOptionsDialog(context, 'sounds/elephant.mp3',
                'assets/video/elephant.mp4'), // 大象音频和视频路径
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              width: screenWidth * 0.09,
              height: screenHeight * 0.14,
              // color: Colors.black,
            ),
          ),
        ),
        // 大公鸡按钮
        Positioned(
          right: screenWidth * 0.32,
          top: screenHeight * 0.1,
          child: GestureDetector(
            onTap: () => _showOptionsDialog(context, 'sounds/chicken.mp3',
                'assets/video/chicken.mp4'), // 狮子音频和视频路径
            child: Container(
              width: screenWidth * 0.08,
              height: screenHeight * 0.1,
              color: Colors.transparent,
            ),
          ),
        ),
        // 你可以根据需要添加更多位置
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen({required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // 确保在初始化完成后更新UI
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Video Player')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
