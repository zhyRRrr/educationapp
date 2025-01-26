import 'package:flutter/material.dart';
import '../Teacherpublish/DisplayPage.dart';
import '../Teacherpublish/ImageDetailPage.dart';
import 'Display.dart';

class Totaller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Total(),
    );
  }
}

class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  int _selectedIndex = 0;
  late ImageDetailPage sharedImageDetailPage;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      '我的',
                      style: TextStyle(
                        fontSize: _selectedIndex == 0 ? 24 : 18,
                        fontWeight: _selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: 2,
                      width: 40,
                      color: _selectedIndex == 0
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      '广场',
                      style: TextStyle(
                        fontSize: _selectedIndex == 1 ? 24 : 18,
                        fontWeight: _selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: 2,
                      width: 40,
                      color: _selectedIndex == 1
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: _selectedIndex == 0 ? StudentDisplay() : DisplayPage(),
          ),
        ],
      ),
    );
  }
}
