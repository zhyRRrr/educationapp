import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'PostRepository.dart';
import './ImageDetailPage.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final List<Map<String, String>> additionalCards = [
    {'image': 'assets/images/2.0x/t.jpg', 'title': '认真努力学习'},
    {'image': 'assets/images/2.0x/t1.jpg', 'title': '吃个脆脆鲨'},
    {'image': 'assets/images/2.0x/t2.jpg', 'title': '吃个火龙果'},
    {'image': 'assets/images/2.0x/t3.jpg', 'title': '学习日常'},
    {'image': 'assets/images/2.0x/t4.jpg', 'title': '小学课程日常'},
    {'image': 'assets/images/2.0x/t4.jpg', 'title': '日常结束放学'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CombinedPostRepository.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<Map<String, dynamic>> posts =
                CombinedPostRepository.getCombinedPosts();
            List<Widget> allCards = [];

            for (var card in additionalCards) {
              allCards.add(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailPage(
                          imagePath: card['image']!,
                          title: card['title']!,
                          dateTime: DateTime.now(),
                          comments: [],
                          postIndex: additionalCards.indexOf(card),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            card['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            card['title']!,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/学习.png'), // 用户头像
                          ),
                          title: Text('用户名'), // 用户名
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            for (var post in posts) {
              List<String> imagePaths = post['images'];
              List<XFile> images =
                  imagePaths.map((path) => XFile(path)).toList();
              String title = post['title'];
              DateTime dateTime = DateTime.parse(post['dateTime']);

              List<Map<String, String>> comments =
                  (post['comments'] as List<dynamic>).map((comment) {
                return (comment as Map<String, dynamic>)
                    .map((key, value) => MapEntry(key, value.toString()));
              }).toList();

              allCards.add(
                GestureDetector(
                  onLongPress: () async {
                    bool? confirmDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('确认删除'),
                          content: Text('你确定要删除这个帖子吗？'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('取消'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('删除'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete == true) {
                      setState(() {
                        posts.remove(post);
                        CombinedPostRepository.saveCombinedPosts();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('帖子已删除')),
                      );
                    }
                  },
                  onTap: () async {
                    bool? postDeleted = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailPage(
                          imagePath: images[0].path,
                          title: title,
                          dateTime: dateTime,
                          comments: comments,
                          postIndex: posts.indexOf(post),
                        ),
                      ),
                    );

                    if (postDeleted == true) {
                      setState(() {});
                    }
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.file(
                            File(images[0].path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/3.0x/1.jpg'), // 用户头像
                          ),
                          title: Text('用户名'), // 用户名
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: allCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) {
                return allCards[index];
              },
            );
          }
        },
      ),
    );
  }
}
