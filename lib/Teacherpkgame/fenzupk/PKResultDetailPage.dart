import 'package:flutter/material.dart';

class PKResultDetailPage extends StatelessWidget {
  final Map<String, dynamic> result;

  PKResultDetailPage({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PK结果详情'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${result["team1Leader"]}小队 VS ${result["team2Leader"]}小队',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('比赛时间：${result["dateTime"].toString()}',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            Text('队伍1：${result["team1Leader"]}小队',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (var member in result["team1Members"])
              Text(' - $member', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('得分：${result["team1Score"]}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('队伍2：${result["team2Leader"]}小队',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (var member in result["team2Members"])
              Text(' - $member', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('得分：${result["team2Score"]}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              '比赛结果：${result["team1Score"] > result["team2Score"] ? "${result["team1Leader"]}小队获胜" : result["team1Score"] < result["team2Score"] ? "${result["team2Leader"]}小队获胜" : "平局"}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
