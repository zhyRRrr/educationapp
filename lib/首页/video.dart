import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:async';

class VideoWithCard extends StatefulWidget {
  @override
  _VideoWithCardState createState() => _VideoWithCardState();
}

class _VideoWithCardState extends State<VideoWithCard> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/English.mp4')
      ..initialize().then((_) {
        setState(() {});
        // _controller.play();
      });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
      aspectRatio: 50 / 25,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text('英语海洋'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 460,
              color: Colors.black,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 260,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: _togglePlayPause,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                height: 250,
                                child: _controller.value.isInitialized
                                    ? Chewie(
                                        controller: _chewieController,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                              if (!_isPlaying)
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white,
                            ], // 渐变颜色
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.white.withOpacity(0.5), // 设置阴影颜色和透明度
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // 设置阴影偏移
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    right: 15,
                    child: Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '限时优惠',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.orange),
                                ),
                                Row(
                                  children: [
                                    Text('距离到期'),
                                    SizedBox(width: 8),
                                    CountdownTimer(),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              '249',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.orange),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '知识玩具-英语海洋',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '玩学一体，变身英语大神',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                TagWidget(text: '英语单词'),
                                SizedBox(width: 8),
                                TagWidget(text: '英语杂志'),
                                SizedBox(width: 8),
                                TagWidget(text: '适合6+岁'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Image.asset('assets/images/英语1.jpg'),
            ),
            Container(
              child: Image.asset('assets/images/英语2.jpg'),
            ),
            Container(
              child: Image.asset('assets/images/英语3.jpg'),
            ),
          ],
        ));
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = Duration(days: 9, hours: 3, minutes: 9, seconds: 35);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String days = _duration.inDays.toString().padLeft(1);
    String hours = (_duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      children: [
        TimerBox(text: '$days天'),
        SizedBox(width: 4),
        TimerBox(text: hours),
        Text(':'),
        TimerBox(text: minutes),
        Text(':'),
        TimerBox(text: seconds),
      ],
    );
  }
}

class TimerBox extends StatelessWidget {
  final String text;

  const TimerBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final String text;

  const TagWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
