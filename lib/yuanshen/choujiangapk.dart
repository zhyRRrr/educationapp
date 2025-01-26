import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'video_player_screen.dart'; // 导入新的 VideoPlayerScreen

class MyApp extends StatelessWidget {
  final List<String> names; // 接收名字列表

  MyApp({Key? key, required this.names}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    return MaterialApp(
      home: HomePage(names: names),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<String> names;

  HomePage({Key? key, required this.names}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _videoController;
  late CarouselController _carouselController; // 使用命名空间
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/yuanshen/yuanshen1.png',
    'assets/images/yuanshen/yuanshen2.png',
    'assets/images/yuanshen/yuanshen3.png',
    'assets/images/yuanshen/yuanshen4.png',
  ];

  final List<String> _containersImages = [
    'assets/images/yuanshen/yuanshen1.png',
    'assets/images/yuanshen/yuanshen2.png',
    'assets/images/yuanshen/yuanshen3.png',
    'assets/images/yuanshen/yuanshen4.png',
  ];

  final List<bool> _isSelected = [true, false, false, false];

  List<String> _selectedNames = [];
  String _videoPath = 'assets/video/yuanshenbac.mp4';
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(_videoPath)
      ..initialize().then((_) {
        setState(() {});
      });

    _carouselController = CarouselController();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _onContainerTap(int index) {
    _goToIndex(index);
  }

  void _onCarouselChange(int index) {
    setState(() {
      _currentIndex = index;
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
    });
  }

  void _navigateToVideo(String videoType) {
    if (videoType == 'one') {
      _videoPath =
          'https://upos-sz-mirrorcos.bilivideo.com/upgcxcode/26/23/484282326/484282326-1-16.mp4?e=ig8euxZM2rNcNbRVhwdVhwdlhWdVhwdVhoNvNC8BqJIzNbfq9rVEuxTEnE8L5F6VnEsSTx0vkX8fqJeYTj_lta53NCM=&uipk=5&nbs=1&deadline=1723279743&gen=playurlv2&os=cosbv&oi=2015027109&trid=8b7df4108695425e856c5915d2f612d8h&mid=0&platform=html5&og=cos&upsig=a7bcf25012da037d829130db80b96d35&uparams=e,uipk,nbs,deadline,gen,os,oi,trid,mid,platform,og&bvc=vod&nettype=0&f=h_0_0&bw=54377&logo=80000000';
    } else if (videoType == 'five') {
      _videoPath =
          'https://upos-sz-mirrorcos.bilivideo.com/upgcxcode/87/43/1025814387/1025814387-1-16.mp4?e=ig8euxZM2rNcNbRVhwdVhwdlhWdVhwdVhoNvNC8BqJIzNbfq9rVEuxTEnE8L5F6VnEsSTx0vkX8fqJeYTj_lta53NCM=&uipk=5&nbs=1&deadline=1723279897&gen=playurlv2&os=cosbv&oi=2015027109&trid=05ef9de6fdf34dc49ca8664f4ebb5a56h&mid=0&platform=html5&og=cos&upsig=e0cc72cca88eaa893104af9b9e1d40a4&uparams=e,uipk,nbs,deadline,gen,os,oi,trid,mid,platform,og&bvc=vod&nettype=0&f=h_0_0&bw=51616&logo=80000000';
    }

    // 重新初始化视频控制器
    _videoController = VideoPlayerController.networkUrl(Uri.parse(_videoPath))
      ..initialize().then((_) {
        setState(() {});
      });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
            videoPath: _videoPath, selectedNames: _selectedNames),
      ),
    );
  }

  void _goToIndex(int index) {
    setState(() {
      _currentIndex = index;
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
    });
    _carouselController.jumpToPage(index);
  }

  void _drawOneName() {
    if (widget.names.isNotEmpty) {
      final randomIndex = Random().nextInt(widget.names.length);
      String selectedName = widget.names[randomIndex];
      _selectedNames = [selectedName];
      _navigateToVideo('one');
    }
  }

  void _drawFiveNames() {
    if (widget.names.length >= 5) {
      Set<int> randomIndices = {};
      while (randomIndices.length < 5) {
        int randomIndex = Random().nextInt(widget.names.length);
        randomIndices.add(randomIndex);
      }
      _selectedNames =
          randomIndices.map((index) => widget.names[index]).toList();
      _navigateToVideo('five');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_videoController.value.isInitialized)
            Positioned.fill(child: VideoPlayer(_videoController)),
          Column(
            children: [
              // Top Containers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () => _onContainerTap(index),
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_containersImages[index]),
                          fit: BoxFit.cover,
                        ),
                        color: _isSelected[index]
                            ? Colors.transparent
                            : Colors.black.withOpacity(0.5),
                      ),
                      child: Center(child: Text('C${index + 1}')),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              // Carousel Slider with Image Indicators
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      items: _images.map((image) {
                        return Container(
                          child: Image.asset(image, fit: BoxFit.cover),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) =>
                            _onCarouselChange(index),
                        enableInfiniteScroll: false,
                        initialPage: _currentIndex,
                      ),
                      carouselController: _carouselController,
                    ),
                    // Image indicators on both sides
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentIndex > 0)
                            GestureDetector(
                              onTap: () {
                                _goToIndex(_currentIndex - 1); // Move to left
                              },
                              child: Image.asset(
                                'assets/images/yuanshen/yuanshenzhishizuo.png',
                                width: 100,
                              ),
                            ),
                          if (_currentIndex == 0)
                            SizedBox(
                              width: 100,
                            ),
                          if (_currentIndex < _images.length - 1)
                            GestureDetector(
                              onTap: () {
                                _goToIndex(_currentIndex + 1); // Move to right
                              },
                              child: Image.asset(
                                'assets/images/yuanshen/yuanshenzhishi.png',
                                width: 100,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Buttons
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _drawOneName,
                    child: Text('抽一次'),
                  ),
                  ElevatedButton(
                    onPressed: _drawFiveNames,
                    child: Text('抽五次'),
                  ),
                ],
              ),
              // 显示抽中的名字
              SizedBox(height: 20),
              if (_selectedNames.isNotEmpty)
                Text(
                  '抽中的名字: ${_selectedNames.join(', ')}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
