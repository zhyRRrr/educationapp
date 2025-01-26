// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class HotClass extends StatefulWidget {
  @override
  _HotClassState createState() => _HotClassState();
}

class _HotClassState extends State<HotClass> {
  String _selectedCourse = '零基础';

  void _updateCourse(String courseType) {
    setState(() {
      _selectedCourse = courseType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Text(
              "热门课程",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      Container(
        height: 50,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            _buildCourseButton('零基础'),
            _buildCourseButton('英语考试'),
            _buildCourseButton('英语进阶'),
            _buildCourseButton('出国留学'),
            _buildCourseButton('嗨购狂欢'),
          ],
        ),
      ),
      CourseContent(courseType: _selectedCourse),
    ]);
  }

  Widget _buildCourseButton(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => _updateCourse(text),
        child: Text(text),
      ),
    );
  }
}

class CourseContent extends StatelessWidget {
  final String courseType;

  CourseContent({required this.courseType});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> courses = _getCoursesForType(courseType);

    return GridView.builder(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        // mainAxisSpacing: 0,
        childAspectRatio: 1.15,
      ),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(
          courses[index]['title']!,
          courses[index]['price']!,
          courses[index]['store']!,
          courses[index]['studies']!,
          courses[index]['imageUrl']!,
        );
      },
    );
  }

  List<Map<String, String>> _getCoursesForType(String type) {
    if (type == '零基础') {
      return [
        {
          'title': '英文小说联播4级',
          'price': '￥0',
          'store': '英语老教师',
          'studies': '470次学习',
          'imageUrl': 'assets/images/直播6.jpg'
        },
        {
          'title': '12节课搞定48个国际音标',
          'price': '￥0 领券立减',
          'store': '沪江英语',
          'studies': '7116次学习',
          'imageUrl': 'assets/images/直播7.jpg'
        },
      ];
    } else if (type == '英语考试') {
      return [
        {
          'title': '12国语言畅学卡【周卡】',
          'price': '￥0.01 领券立减',
          'store': '沪江网校官方店铺',
          'studies': '1.11万次学习',
          'imageUrl': 'assets/images/直播1.jpg'
        },
        {
          'title': '「暴走单词」',
          'price': '￥49',
          'store': '暴走单词',
          'studies': '3572次学习',
          'imageUrl': 'assets/images/直播2.jpg'
        },
      ];
    }
    return [];
  }

  Widget _buildCard(String title, String price, String store, String studies,
      String imageUrl) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        height: 190,
        child: Container(
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
                  height: 100,
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
        ),
      ),
    );
  }
}
