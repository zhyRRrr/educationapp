import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShortVideoPage(),
    );
  }
}

class ShortVideoPage extends StatefulWidget {
  @override
  _ShortVideoPageState createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  int selectedCategoryIndex = 0;
  List<List<VideoPlayerController>> _controllers = [];
  List<bool> _showVideoOverlays = [];
  List<bool> _isPlaying = []; // List to track video playing state

  final List<String> categories = ['全部', '英语', '绘画兴趣', '考试技能', '日韩小语种'];
  final List<List<String>> videos = [
    [
      'assets/video/English1.mp4',
      'assets/video/English2.mp4',
      'assets/video/English3.mp4',
      'assets/video/English4.mp4'
    ],
    [
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4'
    ],
    [
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4'
    ],
    [
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4'
    ],
    [
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4',
      'assets/video/English1.mp4'
    ],
  ];

  @override
  void initState() {
    super.initState();

    // Initialize VideoPlayerControllers for each category
    _controllers = List.generate(videos.length, (categoryIndex) {
      return List.generate(videos[categoryIndex].length, (videoIndex) {
        return VideoPlayerController.asset(videos[categoryIndex][videoIndex])
          ..initialize().then((_) {
            _controllers[categoryIndex][videoIndex].setLooping(true);
          });
      });
    });

    // Initialize show overlays for each video
    _showVideoOverlays = List.generate(videos.length, (_) => true);

    // Initialize video playing state
    _isPlaying = List.generate(videos.length, (_) => false);

    // Start playing the first video in the selected category
    _controllers[selectedCategoryIndex][0].play();
    _isPlaying[selectedCategoryIndex] = true;

    // Listen to video player state changes
    _controllers[selectedCategoryIndex][0].addListener(() {
      if (_controllers[selectedCategoryIndex][0].value.isPlaying) {
        setState(() {
          _showVideoOverlays[selectedCategoryIndex] = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose all VideoPlayerControllers
    _controllers.forEach((categoryControllers) {
      categoryControllers.forEach((controller) {
        controller.dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('短视频听课'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.pink,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? Colors.red
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategoryIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: videos[selectedCategoryIndex].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_isPlaying[selectedCategoryIndex]) {
                        // Pause current video
                        _controllers[selectedCategoryIndex]
                            .forEach((controller) {
                          controller.pause();
                        });
                        _isPlaying[selectedCategoryIndex] = false;
                        _showVideoOverlays[selectedCategoryIndex] = true;
                      } else {
                        // Play the selected video
                        _controllers[selectedCategoryIndex][index].play();
                        _isPlaying[selectedCategoryIndex] = true;
                        _showVideoOverlays[selectedCategoryIndex] = false;
                      }
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: AspectRatio(
                          aspectRatio: 17 / 25,
                          child: VideoPlayer(
                              _controllers[selectedCategoryIndex][index]),
                        ),
                      ),
                      // if (!_isPlaying[selectedCategoryIndex]) // Show pause icon only if video is paused
                      //   Icon(
                      //     Icons.pause,
                      //     size: 50,
                      //     color: Colors.white,
                      //   ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
