import 'package:flutter/material.dart';
import 'PKResultDetailPage.dart';
import 'pk_results_manager.dart';

class FenzuPKResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final results = PKResultsManager().results.reversed.toList(); // 最新的显示在顶部

    return Scaffold(
      appBar: AppBar(
        title: Text('学生PK成绩查看'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showClearConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: results.isEmpty
          ? Center(
              child: Text(
                '暂无PK成绩记录',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      result["team1Score"] > result["team2Score"]
                          ? Icons.emoji_events
                          : result["team1Score"] < result["team2Score"]
                              ? Icons.cancel
                              : Icons.remove_circle_outline,
                      color: result["team1Score"] > result["team2Score"]
                          ? Colors.green
                          : result["team1Score"] < result["team2Score"]
                              ? Colors.red
                              : Colors.grey,
                      size: 40,
                    ),
                    title: Text(
                      '${result["team1Leader"]}小队 VS ${result["team2Leader"]}小队',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('学生得分：${result["team1Score"]}'),
                          Text('对手得分：${result["team2Score"]}'),
                          Text(
                              '比赛结果：${result["team1Score"] > result["team2Score"] ? "胜利" : result["team1Score"] < result["team2Score"] ? "失败" : "平局"}'),
                          Text(
                            '比赛时间：${result["dateTime"].toString()}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PKResultDetailPage(result: result),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('清除所有记录'),
        content: Text('您确定要清除所有PK成绩记录吗？此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              PKResultsManager().clearResults(); // 清除所有成绩
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FenzuPKResultsPage()),
              );
            },
            child: Text('确定', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
