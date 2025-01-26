import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Studentpublish/PostRepository.dart';
import 'TeacherPostRepository.dart';

class CombinedPostRepository {
  static final List<Map<String, dynamic>> combinedPosts = [];

  static Future<void> initialize() async {
    await loadCombinedPosts();
    _combinePosts();
  }

  static void _combinePosts() {
    combinedPosts.clear();
    combinedPosts.addAll(TeacherPostRepository.getPosts());
    combinedPosts.addAll(StudentPostRepository.getPosts());
  }

  static Future<void> loadCombinedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final combinedPostsString = prefs.getString('combinedPosts');
    if (combinedPostsString != null) {
      final List<dynamic> combinedPostsJson = jsonDecode(combinedPostsString);
      combinedPosts.clear();
      combinedPosts.addAll(combinedPostsJson
          .map((post) => {
                'images': (post['images'] as List<dynamic>).cast<String>(),
                'title': post['title'],
                'dateTime': post['dateTime'],
                'comments': post['comments'],
              })
          .toList());
    }
  }

  static Future<void> saveCombinedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final combinedPostsString = jsonEncode(combinedPosts
        .map((post) => {
              'images': (post['images'] as List<dynamic>).cast<String>(),
              'title': post['title'],
              'dateTime': post['dateTime'],
              'comments': post['comments'],
            })
        .toList());
    await prefs.setString('combinedPosts', combinedPostsString);
  }

  static List<Map<String, dynamic>> getCombinedPosts() {
    return combinedPosts;
  }
}
