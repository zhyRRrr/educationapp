import 'package:education_app/Game/ClassAfter/ClassAfter.dart';
import 'package:education_app/LiveSocket.dart';
import 'package:flutter/material.dart';
import 'ClassBefore/ClassBefore.dart';
import 'ClassIng/ClassIng.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List pages = [
  ListView(
    children: [
      Container(
        height: 150,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/animals.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      ClassroomActivityPage(),
    ],
  ),
  ListView(
    children: [
      Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () async {
              await Future.delayed(Duration(seconds: 1));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveSocket()),
              );
            },
            child: Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/livesocket.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
      Container(
        height: 800,
        child: ClassIngActivityPage(),
      ),
    ],
  ),
  Classafter()
];

class SGame extends StatefulWidget {
  @override
  _SGameState createState() => _SGameState();
}

class _SGameState extends State<SGame> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    '课前热身',
    '上课啦',
    '课后pk',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double baseFontSize = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade100, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '搜索',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.message, color: Colors.black),
              onPressed: () {
                // 信息图标点击处理逻辑
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.21,
            child: ListView.builder(
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () => _onItemTapped(index),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.transparent), // 取消点击时的水波纹效果
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 0), // 缩小了垂直填充
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _titles[index],
                            style: TextStyle(
                              fontSize: _selectedIndex == index
                                  ? baseFontSize * 1.2
                                  : baseFontSize,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedIndex == index
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
