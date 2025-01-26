import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PKResultsManager {
  static final PKResultsManager _instance = PKResultsManager._internal();

  factory PKResultsManager() {
    return _instance;
  }

  PKResultsManager._internal();

  final List<Map<String, dynamic>> _results = [];

  List<Map<String, dynamic>> get results => _results;

  Future<void> addResult(
    String team1Leader,
    String team2Leader,
    int team1Score,
    int team2Score, {
    required List<String> team1Members,
    required List<String> team2Members,
  }) async {
    final result = {
      "team1Leader": team1Leader,
      "team2Leader": team2Leader,
      "team1Score": team1Score,
      "team2Score": team2Score,
      "team1Members": team1Members,
      "team2Members": team2Members,
      "dateTime": DateTime.now().toIso8601String(),
    };
    _results.add(result);
    await _saveResults(); // 保存数据
  }

  Future<void> clearResults() async {
    _results.clear();
    await _saveResults(); // 清空数据并保存
  }

  Future<void> _saveResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = jsonEncode(_results);
    await prefs.setString('pk_results', resultsJson);
  }

  Future<void> loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = prefs.getString('pk_results');
    if (resultsJson != null) {
      final List<dynamic> decodedResults = jsonDecode(resultsJson);
      _results.addAll(decodedResults.cast<Map<String, dynamic>>());
    }
  }
}
