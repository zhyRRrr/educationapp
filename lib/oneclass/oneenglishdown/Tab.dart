import 'HomeWork.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'KeC.dart'; // 导入KeC.dart文件

void main() {
  runApp(OneEnglishdown());
}

class OneEnglishdown extends StatefulWidget {
  @override
  _OneEnglishdownState createState() => _OneEnglishdownState();
}

class _OneEnglishdownState extends State<OneEnglishdown> {
  int _selectedIndex = 0;
  String _lastLearn = '';
  int _lastLearnedIndex = -1; // 保存上次学习的章节索引
  Color _iconColor = Colors.black54;

  void initState() {
    super.initState();
    _loadLastLearned(); // 加载上次学习的数据
  }

  Future<void> _loadLastLearned() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastLearn = prefs.getString('video4_last_learned_title') ?? '';
      _lastLearnedIndex = prefs.getInt('video4_last_learned_index') ?? -1;
      _iconColor = _lastLearn.isNotEmpty
          ? Colors.blue
          : Colors.black54; // 根据是否有上次学习标题设置颜色
    });
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateLastLearned(String title, int index) async {
    setState(() {
      _lastLearn = title;
      _lastLearnedIndex = index;
      _iconColor = Colors.blue;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('video4_last_learned_title', title);
    await prefs.setInt('video4_last_learned_index', index);
  }

  Future<void> _navigateToKeC(
      BuildContext context, List<String> chapters, int initialIndex) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            KeC(title: '课程内容', chapters: chapters, initialIndex: initialIndex),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      _updateLastLearned(result['title'], result['index']);
    }
  }

  final List<String> _chapters = [
    '英语口语1',
    '英语口语2',
    '英语口语3',
    '英语口语4',
    '英语口语5',
    '英语口语6',
    '英语口语7',
    '英语口语8',
    '英语口语9',
    '英语口语10',
    '英语口语11',
    '英语口语12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 返回到上一个页面
          },
        ),
        title: Column(
          children: [
            Text(
              '一年级上册英语动画教学',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '57263人正在学习',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ShareBottomSheet();
                },
              );
            },
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text('关于一年级的英语动画课程，\n欢迎来试看。'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('点击观看课程内容'),
              onTap: () {
                _navigateToKeC(context, _chapters, 0);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 245, 245, 245),
            child: ListView(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 207, 207, 207).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '课程',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24.0),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                if (_lastLearnedIndex != -1) {
                                  _navigateToKeC(
                                      context, _chapters, _lastLearnedIndex);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, color: _iconColor),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '上次学到：$_lastLearn',
                                        style: TextStyle(color: _iconColor),
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: _iconColor, size: 15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            RoundedCard(
                              title: '英语口语1',
                              username: '英语课堂',
                              imageUrl: 'assets/images/3.0x/1.jpg',
                              onTap: (data) =>
                                  _navigateToKeC(context, _chapters, 0),
                            ),
                            RoundedCard(
                              title: '英语口语1',
                              username: '语言课堂',
                              imageUrl: 'assets/images/3.0x/1.jpg',
                              onTap: (data) =>
                                  _navigateToKeC(context, _chapters, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandableSection(
                  onVideoItemTap: (data) =>
                      _navigateToKeC(context, _chapters, data['index']),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem('作业', 0, ''),
                  _buildBottomNavItem('课外游戏', 1, '2'),
                  _buildBottomNavItem('讨论帖', 2, '0'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List page = [
    MathQuizPage1(),
    MathQuizPage1(),
    MathQuizPage1(),
  ];

  Widget _buildBottomNavItem(String label, int index, String s) {
    return InkWell(
      onTap: () async {
        _onItemTapped(index);
        bool A = false;
        await Future.delayed(Duration(seconds: 0));
        A = true;
        if (A) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page[index],
              settings: RouteSettings(arguments: {'disableBack': true}),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                  color:
                      _selectedIndex == index ? Colors.amber[800] : Colors.grey,
                  fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              s,
              style: TextStyle(
                  color:
                      _selectedIndex == index ? Colors.amber[800] : Colors.grey,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedCard extends StatelessWidget {
  final String title;
  final String username;
  final String imageUrl;
  final ValueChanged<Map<String, dynamic>> onTap;

  RoundedCard(
      {required this.title,
      required this.username,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap({'title': title, 'index': 0}),
      child: Container(
        width: 390,
        margin: EdgeInsets.fromLTRB(0, 15, 15, 0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 171, 171),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: TextStyle(fontSize: 16.0)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage(imageUrl), radius: 12.0),
                      SizedBox(width: 8.0),
                      Text(username, style: TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              // 分享到QQ
            },
            tooltip: '分享到QQ',
          ),
          IconButton(
            icon: Icon(Icons.wechat),
            onPressed: () {
              // 分享到微信
            },
            tooltip: '分享到微信',
          ),
        ],
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onVideoItemTap;

  ExpandableSection({required this.onVideoItemTap});

  @override
  _ExpandableSectionState createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;
  bool _isExpande = false;
  bool _isExpand = false;
  bool _isExpan = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleExpan() {
    setState(() {
      _isExpande = !_isExpande;
    });
  }

  void _toggleExpa() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  void _toggleExp() {
    setState(() {
      _isExpan = !_isExpan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildExpandableItem(
          title: '视频内容介绍',
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          videoItems: [
            VideoItem(
                title: '英语口语1',
                duration: '04:11',
                index: 0,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '17:15',
                index: 1,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '17:26',
                index: 2,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '12:34',
                index: 3,
                onTap: (data) => widget.onVideoItemTap(data)),
          ],
        ),
        _buildExpandableItem(
          title: '视频内容介绍2',
          isExpanded: _isExpande,
          toggleExpand: _toggleExpan,
          videoItems: [
            VideoItem(
                title: '英语口语1',
                duration: '04:11',
                index: 4,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '17:15',
                index: 5,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '17:26',
                index: 6,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '英语口语1',
                duration: '12:34',
                index: 7,
                onTap: (data) => widget.onVideoItemTap(data)),
          ],
        ),
        _buildExpandableItem(
          title: '视频内容介绍3',
          isExpanded: _isExpand,
          toggleExpand: _toggleExpa,
          videoItems: [
            VideoItem(
                title: '认识整时',
                duration: '04:11',
                index: 8,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '平面正方形',
                duration: '17:15',
                index: 9,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '6~10的认识',
                duration: '17:26',
                index: 10,
                onTap: (data) => widget.onVideoItemTap(data)),
            VideoItem(
                title: '十位数减896',
                duration: '12:34',
                index: 11,
                onTap: (data) => widget.onVideoItemTap(data)),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableItem({
    required String title,
    required bool isExpanded,
    required VoidCallback toggleExpand,
    required List<VideoItem> videoItems,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 220, 220, 220),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: toggleExpand,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
          isExpanded
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  color: Color.fromARGB(255, 245, 245, 245),
                  child: Column(
                    children: videoItems,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String title;
  final String duration;
  final int index;
  final ValueChanged<Map<String, dynamic>> onTap;

  VideoItem(
      {required this.title,
      required this.duration,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap({'title': title, 'index': index}),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(Icons.play_circle_outline, color: Colors.black54),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Text(
              duration,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
