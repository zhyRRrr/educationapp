import 'package:flutter/material.dart';
import 'dart:io';
import 'TeacherPostRepository.dart';

class ImageDetailPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final DateTime dateTime;
  final List<Map<String, String>> comments;
  final int postIndex;

  ImageDetailPage({
    required this.imagePath,
    required this.title,
    required this.dateTime,
    required this.comments,
    required this.postIndex,
  });

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  TextEditingController _commentController = TextEditingController();

  void _addComment(String comment) {
    setState(() {
      // 调用 PostRepository 的 addComment 方法，保存评论
      TeacherPostRepository.addComment(widget.postIndex, {
        'name': 'zhy',
        'avatar': 'assets/images/3.0x/1.jpg',
        'comment': comment,
      });
      // 将评论添加到当前页面的评论列表中
      widget.comments.add({
        'name': 'zhy',
        'avatar': 'assets/images/3.0x/1.jpg',
        'comment': comment,
      });
    });
    // 清空输入框
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片详情'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
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
                TeacherPostRepository.deletePost(widget.postIndex);
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('帖子已删除')),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          widget.imagePath.startsWith('assets/')
              ? Image.asset(widget.imagePath)
              : Image.file(File(widget.imagePath)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '发布于 ${widget.dateTime.year}-${widget.dateTime.month}-${widget.dateTime.day} ${widget.dateTime.hour}:${widget.dateTime.minute}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('评论'),
          ),
          ...widget.comments.map<Widget>((comment) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(comment['avatar'] ?? ''),
              ),
              title: Text(comment['name'] ?? ''),
              subtitle: Text(comment['comment'] ?? ''),
            );
          }).toList(),
          ListTile(
            leading: Icon(Icons.comment),
            title: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '对Ta说点什么吧~',
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _addComment(_commentController.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
