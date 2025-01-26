import 'package:flutter/material.dart';
import 'dart:io';
import 'PostRepository.dart';

class StudentDisplay extends StatefulWidget {
  @override
  DisplayState createState() => DisplayState();
}

class DisplayState extends State<StudentDisplay> {
  bool isLiked = false;
  int likeCount = 0;
  TextEditingController _commentController = TextEditingController();

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void _addComment(String comment, int postIndex) {
    setState(() {
      StudentPostRepository.addComment(postIndex, {
        'name': 'zhy',
        'avatar': 'assets/images/3.0x/1.jpg',
        'comment': comment
      });
    });
  }

  void _showCommentDialog(int postIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            List<Map<String, dynamic>> comments =
                List<Map<String, dynamic>>.from(
                    StudentPostRepository.getPosts()[postIndex]['comments']);
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('共${comments.length}条评论'),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage(comments[index]['avatar'] as String),
                          ),
                          title: Text(comments[index]['name'] as String),
                          subtitle: Text(comments[index]['comment'] as String),
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: '对Ta说点什么吧~',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addComment(_commentController.text, postIndex);
                      setState(() {});
                      _commentController.clear();
                    },
                    child: Text('发布'),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(imagePath)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('关闭'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> posts = StudentPostRepository.getPosts();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: posts.asMap().entries.map((entry) {
            int postIndex = entry.key;
            Map<String, dynamic> post = entry.value;
            List<String> imagePaths = post['images'];
            String title = post['title'];
            final dateTime = DateTime.parse(post['dateTime']);

            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/3.0x/1.jpg'), // 用户头像
                  ),
                  title: Text('zhy'), // 用户名
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: imagePaths.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showImageDialog(imagePaths[index]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: dateTime != null
                      ? Text(
                          '发布于 ${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          '发布时间未知',
                          style: TextStyle(color: Colors.grey),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: _toggleLike,
                        ),
                        Text('$likeCount'),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {},
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () => _showCommentDialog(postIndex),
                        ),
                        Text('${post['comments'].length}'),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
