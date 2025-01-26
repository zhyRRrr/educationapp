class PKResultsManager {
  static final PKResultsManager _instance = PKResultsManager._internal();

  factory PKResultsManager() {
    return _instance;
  }

  PKResultsManager._internal();

  final List<Map<String, dynamic>> _results = [];

  List<Map<String, dynamic>> get results => _results;

  void addResult(String studentName, String opponentName, int studentScore,
      int opponentScore) {
    _results.add({
      "studentName": studentName,
      "opponentName": opponentName,
      "studentScore": studentScore,
      "opponentScore": opponentScore,
      "dateTime": DateTime.now(),
    });
  }

  // 新增清除所有结果的方法
  void clearResults() {
    _results.clear();
  }
}
