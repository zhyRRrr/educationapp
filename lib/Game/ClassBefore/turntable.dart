import 'dart:async';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(TurnTable1());

class TurnTable1 extends StatelessWidget {
  const TurnTable1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TurnTable(),
    );
  }
}

class TurnTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinWheelGame(),
    );
  }
}

class SpinWheelGame extends StatefulWidget {
  @override
  _SpinWheelGameState createState() => _SpinWheelGameState();
}

class _SpinWheelGameState extends State<SpinWheelGame> {
  List<bool> _coverVisible = List.filled(12, true);
  int _currentIndex = 0;
  bool _isSpinning = false;
  late VideoPlayerController _controller;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/aotuman.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      });
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _startSpin() async {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
      _coverVisible = List.filled(12, true);
    });

    // Play the audio
    await _audioPlayer.play(AssetSource('sounds/zhuanpan.mp3'));

    Timer(Duration(milliseconds: 500), () {
      int rounds = 4; // 随机圈数
      int totalSteps = rounds * 12;

      for (int i = 0; i <= totalSteps; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          setState(() {
            _coverVisible[_currentIndex] = true;
            _currentIndex = (_currentIndex + 1) % 12;
            _coverVisible[_currentIndex] = false;
          });
        });
      }

      Future.delayed(Duration(milliseconds: totalSteps * 100), () {
        setState(() {
          _isSpinning = false;
        });
        // Stop the audio
        _audioPlayer.stop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    return Stack(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGridItem(0, '背一首诗'),
                    _buildGridItem(3, '跳绳100下'),
                    _buildGridItem(6, '口技表演'),
                    _buildGridItem(9, '躲过惩罚'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGridItem(1, '唱一首歌'),
                    SizedBox(
                      height: 30,
                    ),
                    _buildStartButton(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildGridItem(7, '模仿秀'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGridItem(2, '原地转20圈'),
                    _buildGridItem(5, '深蹲20个'),
                    _buildGridItem(8, '躲过惩罚'),
                    _buildGridItem(11, '学鸭子走路'),
                  ],
                ),
                SizedBox(
                  width: 50,
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGridItem(int index, String text) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 251, 169, 169),
                Color.fromARGB(255, 55, 153, 245)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(text),
          ),
        ),
        if (_coverVisible[index])
          Container(
            margin: EdgeInsets.all(5),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 127, 127, 127),
                  Color.fromARGB(255, 55, 153, 245)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(text),
            ),
          ),
      ],
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _startSpin,
      child: Container(
        margin: EdgeInsets.all(20),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 81, 107, 255),
              Color.fromARGB(255, 55, 153, 245)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            '开始',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
