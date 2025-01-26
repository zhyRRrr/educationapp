import 'package:flutter/material.dart';
import 'pk_mode_page.dart';

class GroupInputPage extends StatefulWidget {
  @override
  _GroupInputPageState createState() => _GroupInputPageState();
}

class _GroupInputPageState extends State<GroupInputPage> {
  final TextEditingController team1Controller = TextEditingController();
  final TextEditingController team2Controller = TextEditingController();

  @override
  void dispose() {
    team1Controller.dispose();
    team2Controller.dispose();
    super.dispose();
  }

  void _startPK() {
    final team1Members = team1Controller.text
        .trim()
        .split('\n')
        .where((name) => name.isNotEmpty)
        .toList();
    final team2Members = team2Controller.text
        .trim()
        .split('\n')
        .where((name) => name.isNotEmpty)
        .toList();

    if (team1Members.isNotEmpty && team2Members.isNotEmpty) {
      final team1Leader = team1Members[0];
      final team2Leader = team2Members[0];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PKModePage(
            team1Leader: team1Leader,
            team2Leader: team2Leader,
            team1Members: team1Members,
            team2Members: team2Members,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请确保两个队伍都有成员')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组输入'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '输入第一个队伍成员名字（每个名字换行）：',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: team1Controller,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '例如：\n张三\n李四\n王五',
              ),
            ),
            SizedBox(height: 20),
            Text(
              '输入第二个队伍成员名字（每个名字换行）：',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: team2Controller,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '例如：\n赵六\n钱七\n孙八',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPK,
              child: Text('开始PK'),
            ),
          ],
        ),
      ),
    );
  }
}
