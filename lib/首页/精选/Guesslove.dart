import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'label.dart';
import 'item.dart';
import 'gif.dart';
import 'live.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../video.dart';
import '../TrainCamp.dart';

double screenHeight = 0;
double screenWidth = 0;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Guesslove Demo'),
        ),
        body: Guesslove(), // 将 Guesslove 组件添加到 body 中
      ),
    );
  }
}

class Guesslove extends StatefulWidget {
  const Guesslove({super.key});

  @override
  State<Guesslove> createState() => _GuessloveState();
}

class _GuessloveState extends State<Guesslove> {
  ScrollController _scrollController = ScrollController();
  EasyRefreshController _refreshController = EasyRefreshController();
  bool _isLoading = false;
  EdgeInsets myPadding = EdgeInsets.zero;

  final List<String> imgList = [
    "assets/images/banner1.png",
    "assets/images/TainCamp.jpg",
    "assets/images/Rectangle 4.png",
  ];

  final List video = [VideoWithCard(), TainCamp()];

  int _currentPage = 0;

  List<Widget> items = [
    _buildCard('英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播6.jpg'),
    _buildCard(
        '12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习', 'assets/images/直播7.jpg'),
    _buildCard('12语言畅学【周卡】', '￥0.01 领券立减', '沪江网校官方店铺', '1.11万次学习',
        'assets/images/直播1.jpg'),
    _buildCard('「暴走单词」', '￥49', '暴走单词', '3572次学习', 'assets/images/直播2.jpg'),
    _buildCard('英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播3.jpg'),
    _buildCard(
        '12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习', 'assets/images/直播4.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // 到达底部
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      // 模拟异步加载数据
      await Future.delayed(Duration(seconds: 2));
      // 添加新数据
      setState(() {
        items.addAll([
          _buildCard(
              '英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播6.jpg'),
          _buildCard('12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习',
              'assets/images/直播7.jpg'),
          _buildCard('12语言畅学【周卡】', '￥0.01 领券立减', '沪江网校官方店铺', '1.11万次学习',
              'assets/images/直播1.jpg'),
          _buildCard(
              '「暴走单词」', '￥49', '暴走单词', '3572次学习', 'assets/images/直播2.jpg'),
          _buildCard(
              '英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播3.jpg'),
          _buildCard('12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习',
              'assets/images/直播4.jpg'),
        ]);
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    // 模拟异步刷新数据
    // 模拟一个延迟 2 秒的异步操作
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = [
        _buildCard(
            '英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播6.jpg'),
        _buildCard('12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习',
            'assets/images/直播7.jpg'),
        _buildCard('12国语言学【周卡】', '￥0.01 领券立减', '沪江网校官方店铺', '1.11万次学习',
            'assets/images/直播1.jpg'),
        _buildCard('「暴走单词」', '￥49', '暴走单词', '3572次学习', 'assets/images/直播2.jpg'),
        _buildCard(
            '英文小说联播4级', '￥0', '英语老教师', '470次学习', 'assets/images/直播3.jpg'),
        _buildCard('12节搞定48个国际音标', '￥0 领券立减', '沪江英语', '7116次学习',
            'assets/images/直播4.jpg'),
      ];
      _refreshController.finishRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 在第一次绘制完成后获取屏幕高度并设置 EdgeInsets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          screenHeight = MediaQuery.of(context).size.height;
          screenWidth = MediaQuery.of(context).size.width;

          myPadding = EdgeInsets.fromLTRB(
            screenWidth * 0.15,
            0,
            screenWidth * 0.15,
            0,
          );

          print("Screen width: $screenWidth");
          print("Screen height: $screenHeight");
        });
      }
    });

    return EasyRefresh(
        controller: _refreshController,
        onRefresh: _refresh,
        onLoad: _loadMore,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                        ),
                        items: imgList
                            .map(
                              (item) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            video[_currentPage]),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  // height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(10.0), // 添加圆角
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10.0), // 添加圆角
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover, // 使用cover保持图片比例并填充整个容器
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              _currentPage = entry.key;
                            }),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == entry.key
                                    ? Colors.blue
                                    : Color.fromARGB(255, 200, 200, 200),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                HorizontalScrollGrid(),
                SizedBox(
                  height: 10,
                ),
                ItemsRow(items: [
                  {
                    "title": "好课速选",
                    "subtitle": "点击上好课",
                    "image": "assets/images/学习.png"
                  },
                  {
                    "title": "看短视频",
                    "subtitle": "边看边学",
                    "image": "assets/images/短视频.png"
                  },
                  {
                    "title": "招募令",
                    "subtitle": "10万奖金",
                    "image": "assets/images/举手.png"
                  },
                  {
                    "title": "我要入驻",
                    "subtitle": "成为创作者",
                    "image": "assets/images/奖牌.png"
                  },
                ]),
                gif(),
                Live(),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // 设置圆角半径
                    child: Image.asset(
                      'assets/images/好好学习.jpg', // 替换成你的本地图片路径

                      fit: BoxFit.cover, // 图片填充方式，根据需要调整
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: Column(
                    children: [
                      Container(
                        padding: myPadding,
                        child: ListTile(
                          leading: Icon(Icons.tag_faces, color: Colors.pink),
                          title: Center(
                            child: Text(
                              '猜你喜欢',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          trailing: Icon(Icons.tag_faces, color: Colors.pink),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return items[index];
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  static Widget _buildCard(String title, String price, String store,
      String studies, String imageUrl) {
    return Container(
      height: screenHeight * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Image.asset(
              imageUrl,
              height: screenHeight * 0.1,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              price,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              store,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              studies,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
