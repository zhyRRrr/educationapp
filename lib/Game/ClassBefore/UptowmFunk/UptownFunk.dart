import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'review.dart';

class UptownFunk extends StatefulWidget {
  @override
  _UptownFunkState createState() => _UptownFunkState();
}

class _UptownFunkState extends State<UptownFunk> {
  late VideoPlayerController _controller;
  double progress = 0.0;
  bool _isOverlayVisible = false;
  Timer? _overlayTimer;
  bool _isVideoCompleted = false;
  bool _isPlayingLesson = false;
  List<Map<String, dynamic>> reviews = [
    {
      'avatarPath': 'assets/images/avatar1.jpg',
      'name': '守护*耕耘',
      'date': '2022-01-22',
      'rating': 5,
      'comment': '非常实用!',
      'likes': 6,
    },
    {
      'avatarPath': 'assets/images/avatar2.jpg',
      'name': 'gleaner',
      'date': '2022-06-28',
      'rating': 5,
      'comment': '感谢分享',
      'likes': 3,
    },
    {
      'avatarPath': 'assets/images/avatar3.jpg',
      'name': '匿名',
      'date': '2023-03-15',
      'rating': 4,
      'comment': '',
      'likes': 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/uptownfunk.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(false)
      ..addListener(() {
        if (_controller.value.isInitialized) {
          setState(() {
            if (_isVideoCompleted) {
              progress = 1.0;
            } else {
              progress = _controller.value.position.inSeconds /
                  (_controller.value.duration.inSeconds > 0
                      ? _controller.value.duration.inSeconds
                      : 1);
            }
          });
        }

        if (_controller.value.position >= _controller.value.duration) {
          _controller.pause();
          setState(() {
            progress = 1.0;
            _isVideoCompleted = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayTimer?.cancel();
    super.dispose();
  }

  void _showShareSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text('分享到微信好友'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('分享到朋友圈'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('分享到QQ好友'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('分享到钉钉'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('复制链接'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  void _toggleOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
      if (_isOverlayVisible) {
        _startOverlayTimer();
      } else {
        _overlayTimer?.cancel();
      }
    });
  }

  void _startOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        _isOverlayVisible = false;
      });
    });
  }

  void _playLesson() {
    setState(() {
      _isPlayingLesson = true;
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
        _isVideoCompleted = false;
      }
    });
  }

  void _addReview(Map<String, dynamic> review) {
    setState(() {
      reviews.add(review);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Uptown Funk'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showShareSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_controller.value.isInitialized)
            Stack(
              children: [
                GestureDetector(
                  onTap: _toggleOverlay,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                if (_isOverlayVisible)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                                _isVideoCompleted = false;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenVideo(controller: _controller),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          else
            Center(child: CircularProgressIndicator()),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('学习进度'),
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                Text('${(progress * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: '简介'),
                      Tab(text: '目录'),
                      Tab(text: '评价'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '9.5',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 20,
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 4),
                                      Text('219人评分'),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('看过了，去评分'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Divider(),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/logo.jpg'),
                                    radius: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '智趣课堂讲师团',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '智趣课堂讲师团队，拥有专业的培训技巧和丰富的信息化教学培训经验，深刻理解一线教师最真实的信息化教学需求。',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Divider(),
                              SizedBox(height: 16),
                              Text(
                                '为你推荐',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                height: 120,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    _buildRecommendationCard(
                                        'assets/images/3.0x/课前5.jpg', '5243'),
                                    _buildRecommendationCard(
                                        'assets/images/3.0x/课前5.jpg', '7.7万'),
                                    _buildRecommendationCard(
                                        'assets/images/3.0x/课前5.jpg', '3.5万'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '超级分类创新应用',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              InkWell(
                                onTap: _playLesson,
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: _isPlayingLesson ? 24 : 0,
                                      height: 24,
                                      child: _isPlayingLesson
                                          ? Icon(
                                              Icons.play_arrow,
                                              color: Colors.blue,
                                            )
                                          : null,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '01.表格活用终极指南',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          '学习中',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            SingleChildScrollView(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '9.5',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text('219人评分'),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    children: reviews
                                        .map((review) => Column(
                                              children: [
                                                _buildReview(
                                                  avatarPath:
                                                      review['avatarPath'],
                                                  name: review['name'],
                                                  date: review['date'],
                                                  rating: (review['rating']
                                                          as num)
                                                      .toInt(), // Ensure this is an int
                                                  comment: review['comment'],
                                                  likes: review['likes'],
                                                ),
                                                Divider(),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewPage()),
                                    );
                                    if (result != null) {
                                      _addReview({
                                        'avatarPath':
                                            'assets/images/avatar1.jpg',
                                        'name': '匿名',
                                        'date': DateTime.now()
                                            .toString()
                                            .split(' ')[0],
                                        'rating': result['rating'],
                                        'comment': result['review'],
                                        'likes': 0,
                                      });
                                    }
                                  },
                                  child: Text('去评分'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String imagePath, String views) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 180,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 4),
          Text(views),
        ],
      ),
    );
  }

  Widget _buildReview({
    required String avatarPath,
    required String name,
    required String date,
    required int rating,
    required String comment,
    required int likes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(avatarPath),
              radius: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(rating, (index) {
                      return Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 16,
                      );
                    }),
                  ),
                  if (comment.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(comment),
                    ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Text(date),
              Spacer(),
              Icon(Icons.thumb_up, size: 16),
              SizedBox(width: 4),
              Text('$likes'),
            ],
          ),
        ),
      ],
    );
  }
}

class FullScreenVideo extends StatefulWidget {
  final VideoPlayerController controller;

  const FullScreenVideo({required this.controller});

  @override
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  bool _isOverlayVisible = false;
  Timer? _overlayTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    widget.controller.play();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _overlayTimer?.cancel();
    super.dispose();
  }

  void _toggleOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
      if (_isOverlayVisible) {
        _startOverlayTimer();
      } else {
        _overlayTimer?.cancel();
      }
    });
  }

  void _startOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        _isOverlayVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: GestureDetector(
                onTap: _toggleOverlay,
                child: VideoPlayer(widget.controller),
              ),
            ),
          ),
          if (_isOverlayVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 64.0,
                    ),
                    onPressed: () {
                      setState(() {
                        if (widget.controller.value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          if (_isOverlayVisible)
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  Icons.fullscreen_exit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
        ],
      ),
    );
  }
}
