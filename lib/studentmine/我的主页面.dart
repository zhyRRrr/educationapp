import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../statistics/statistics_page.dart';
import '设置.dart';
import '../学生注册.dart';
// import '../登录.dart';

final PageController _controller = PageController();
int _currentPage = 0;
// 用于模拟登录状态
bool isLoggedIn = false;

class StudentUserProfilePage extends StatefulWidget {
  const StudentUserProfilePage({super.key});

  @override
  State<StudentUserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<StudentUserProfilePage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code,
                size: 30,
              )),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                //跳转路由
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SettingsPage();
                }));
              },
              icon: Icon(
                Icons.settings,
                size: 30,
              )),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              size: 30,
            ),
          ),
        ],
      )),
      body: ListView(
        children: [
          // 用户信息部分
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: _isLoggedIn
                          ? AssetImage('assets/images/3.0x/1.jpg') // 替换为你的头像路径
                          : null,
                      radius: 30,
                      child: _isLoggedIn ? null : Icon(Icons.person),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _isLoggedIn
                          ? [
                              Text('2471***790',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('Lv.2 山川',
                                  style: TextStyle(color: Colors.grey)),
                            ]
                          : [
                              GestureDetector(
                                onTap: () async {
                                  //跳转到登录页面
                                  final result = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return register();
                                  }));
                                  if (result == true) {
                                    setState(() {
                                      _isLoggedIn = true;
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text('登录/注册  >',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                    ),
                    Spacer(),
                    Icon(Icons.qr_code, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Section(
            title: '我的学习',
            items: [
              GridItem(
                icon: Icons.book,
                label: '课程',
                color: Colors.orange,
                onTap: () {
                  // Navigate to Course Page
                },
              ),
              GridItem(
                  icon: Icons.calendar_today,
                  label: '课表',
                  color: Colors.deepOrange,
                  onTap: () {
                    // Navigate to Schedule Page
                  }),
              GridItem(
                  icon: Icons.star,
                  label: '收藏',
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to Favorites Page
                  }),
              GridItem(
                  icon: Icons.receipt,
                  label: '学习记录',
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to Study Records Page
                  }),
              GridItem(
                  icon: Icons.assignment,
                  label: '作业',
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to Assignments Page
                  }),
              GridItem(
                  icon: Icons.forum,
                  label: '讨论帖',
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to Discussion Page
                  }),
              GridItem(
                  icon: Icons.rate_review,
                  label: '我的评价',
                  color: Colors.yellow,
                  onTap: () {
                    // Navigate to My Reviews Page
                  }),
              GridItem(
                  icon: Icons.question_answer,
                  label: '题库',
                  color: Colors.blue,
                  onTap: () {
                    // Navigate to Question Bank Page
                  }),
            ],
          ),

          //数据统计

          // Section 3: 其他
          Section(
            title: '其他',
            items: [
              GridItem(
                  icon: Icons.favorite,
                  label: '兴趣偏好',
                  color: Colors.orange,
                  onTap: () {
                    // Navigate to Preferences Page
                  }),
              GridItem(
                  icon: Icons.support_agent,
                  label: '在线客服',
                  color: Colors.blue,
                  onTap: () {
                    // Navigate to Customer Service Page
                  }),
              GridItem(
                  icon: Icons.feedback,
                  label: '问题反馈',
                  color: Colors.green,
                  onTap: () {
                    // Navigate to Feedback Page
                  }),
              GridItem(
                  icon: Icons.show_chart,
                  label: '数据统计',
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Statistics()));
                  }),
            ],
          ),
          _buildCarouselchart(context),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCarouselchart(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  _currentPage = index;
                },
              ),
              items: pages
                  .map(
                    (item) => Image.asset(item,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width),
                  )
                  .toList(),
            ),
          ),
        )
      ],
    );
  }

  final List pages = [
    'assets/images/直播3.jpg',
    'assets/images/直播4.jpg',
    'assets/images/直播5.jpg'
  ];
}

class Section extends StatelessWidget {
  final String title;
  final List<GridItem> items;

  Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: items,
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final MaterialColor color;
  final VoidCallback onTap; // 点击事件

  GridItem(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 添加点击事件
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 35,
            color: color,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
