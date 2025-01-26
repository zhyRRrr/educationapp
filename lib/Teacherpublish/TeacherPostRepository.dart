import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherPostRepository {
  static final List<Map<String, dynamic>> posts = [];

  static Future<void> initialize() async {
    await loadPosts();
  }

  static Future<void> addPost(List<XFile> images, String title,
      {DateTime? dateTime}) async {
    posts.add({
      'images': images.map((image) => image.path).toList(),
      'title': title,
      'dateTime':
          dateTime?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'comments': [],
    });
    await _savePosts();
  }

  static Future<void> addComment(
      int postIndex, Map<String, String> comment) async {
    // 将评论添加到指定帖子的评论列表中
    posts[postIndex]['comments'].add(comment);
    // 将更新后的帖子数据保存到持久化存储中
    await _savePosts();
  }

  static Future<void> deletePost(int index) async {
    posts.removeAt(index);
    await _savePosts();
  }

  static Future<void> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsString = prefs.getString('posts');
    if (postsString != null) {
      final List<dynamic> postsJson = jsonDecode(postsString);
      posts.clear();
      posts.addAll(postsJson
          .map((post) => {
                'images': (post['images'] as List<dynamic>).cast<String>(),
                'title': post['title'],
                'dateTime': post['dateTime'],
                'comments': post['comments'],
              })
          .toList());
    }
  }

  static Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsString = jsonEncode(posts
        .map((post) => {
              'images': (post['images'] as List<dynamic>).cast<String>(),
              'title': post['title'],
              'dateTime': post['dateTime'],
              'comments': post['comments'],
            })
        .toList());
    await prefs.setString('posts', postsString);
  }

  static List<Map<String, dynamic>> getPosts() {
    return posts;
  }
}
