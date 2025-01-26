import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeC extends StatefulWidget {
  final String title;
  final List<String> chapters;
  final int initialIndex;

  KeC(
      {required this.title,
      required this.chapters,
      required this.initialIndex});

  @override
  _KeCState createState() => _KeCState();
}

class _KeCState extends State<KeC> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int _selectedChapterIndex = -1;
  bool _showPopup1 = false;
  bool _showPopup2 = false;
  String _popupMessage = '';

  final Map<String, String> _videoPaths = {
    '语文动画课堂1': 'assets/video/twochinese/chinese1.mp4',
    '语文动画课堂2': 'assets/video/twochinese/chinese2.mp4',
    '语文动画课堂3': 'assets/video/twochinese/chinese3.mp4',
    '语文动画课堂4': 'assets/xiyouji/xiyouji1.mp4',
    '语文动画课堂5': 'assets/xiyouji/xiyouji2.mp4',
    '语文动画课堂6': 'assets/xiyouji/xiyouji3.mp4',
    '语文动画课堂7': 'assets/xiyouji/xiyouji4.mp4',
    '语文动画课堂8': 'assets/xiyouji/xiyouji2.mp4',
    '语文动画课堂9': 'assets/xiyouji/xiyouji4.mp4',
    '语文动画课堂10': 'assets/xiyouji/xiyouji2.mp4',
    '语文动画课堂11': 'assets/xiyouji/xiyouji1.mp4',
    '语文动画课堂12': 'assets/xiyouji/xiyouji2.mp4',
  };

  @override
  void initState() {
    super.initState();
    _selectedChapterIndex = widget.initialIndex;
    _initializeVideoPlayer(
        _videoPaths[widget.chapters[widget.initialIndex]] ?? '');
  }

  Future<void> _initializeVideoPlayer(String videoPath) async {
    _videoPlayerController = VideoPlayerController.asset(videoPath);
    final prefs = await SharedPreferences.getInstance();
    final lastPosition =
        prefs.getInt('video_position_$_selectedChapterIndex') ?? 0;
    await _videoPlayerController.initialize();
    _videoPlayerController.seekTo(Duration(milliseconds: lastPosition));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      fullScreenByDefault: false,
      autoInitialize: true,
    );
    _chewieController!.addListener(_fullscreenListener);
    setState(() {});
    if (videoPath == _videoPaths['西游记狂欢会']) {
      _videoPlayerController.addListener(_videoListener);
    }
  }

  void _fullscreenListener() {
    if (_chewieController!.isFullScreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  void _videoListener() {
    if (_videoPlayerController.value.position >= Duration(seconds: 50)) {
      _videoPlayerController.removeListener(_videoListener);
      _showPopup1 = true;
      _videoPlayerController.pause();
      setState(() {});
    }
  }

  Future<void> _playChapterVideo(String videoPath, int index) async {
    await _videoPlayerController.pause();
    _videoPlayerController = VideoPlayerController.asset(videoPath);
    final prefs = await SharedPreferences.getInstance();
    final lastPosition = prefs.getInt('video_position_$index') ?? 0;
    await _videoPlayerController.initialize();
    _videoPlayerController.seekTo(Duration(milliseconds: lastPosition));
    if (videoPath == _videoPaths['英语口语1']) {
      _videoPlayerController.addListener(_videoListener);
    }
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
      );
      _selectedChapterIndex = index;
    });
  }

  @override
  void dispose() {
    _saveVideoPosition();
    _disposeVideoControllers();
    super.dispose();
  }

  Future<void> _saveVideoPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final currentPosition =
        _videoPlayerController.value.position.inMilliseconds;
    await prefs.setInt(
        'video_position_$_selectedChapterIndex', currentPosition);
  }

  Future<void> _disposeVideoControllers() async {
    await _videoPlayerController.pause();
    await _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  void _handlePopupSelection(int index) {
    setState(() {
      _showPopup1 = false;
      _popupMessage = index == 2 ? '小朋友你回答正确' : '小朋友你选错啦';
      _showPopup2 = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showPopup2 = false;
      });
      _videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _saveVideoPosition();
        Navigator.pop(context, {
          'title': widget.chapters[_selectedChapterIndex],
          'index': _selectedChapterIndex,
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              _saveVideoPosition();
              Navigator.pop(context, {
                'title': widget.chapters[_selectedChapterIndex],
                'index': _selectedChapterIndex,
              });
            },
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
                if (_showPopup1) _buildPopup1(),
                if (_showPopup2) _buildPopup2(),
              ],
            ),
            Row(
              children: [
                _buildTabButton('简介', 0),
                _buildTabButton('目录', 1),
              ],
            ),
            Expanded(
              child: _selectedIndex == 0 ? _buildJianjie() : _buildMulu(),
            ),
          ],
        ),
      ),
    );
  }

  int _selectedIndex = 0;

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.grey : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildJianjie() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ListView(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(Icons.thumb_up, '点赞'),
              _buildActionButton(Icons.star, '收藏'),
              _buildActionButton(Icons.feedback, '反馈'),
              _buildActionButton(Icons.cloud_download, '缓存'),
              SizedBox(width: 180),
              _buildActionButton(Icons.share, '分享'),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '暂无简介',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMulu() {
    return ListView.builder(
      itemCount: widget.chapters.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _playChapterVideo(
              _videoPaths[widget.chapters[index]] ?? '', index),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: _selectedChapterIndex == index
                ? Colors.blue
                : Colors.transparent,
            child: Text(
              widget.chapters[index],
              style: TextStyle(
                color:
                    _selectedChapterIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildPopup1() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '选择3/4的长方形',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () => _handlePopupSelection(index),
                  child: Container(
                    color: Colors.white,
                    width: 50,
                    height: 50,
                    child: Image.asset(
                        'assets/images/retangle/${index + 1}4retangle.png'),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopup2() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Text(
            _popupMessage,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
