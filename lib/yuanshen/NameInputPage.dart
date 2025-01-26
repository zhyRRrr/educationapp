import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './choujiangapk.dart';

void main() {
  runApp(NameInputPage1());
}

class NameInputPage1 extends StatelessWidget {
  const NameInputPage1({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 仅允许竖屏模式
    ]);
    return MaterialApp(home: NameInputPage());
  }
}

List<String> names = [];

class NameInputPage extends StatefulWidget {
  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _controller = TextEditingController();

  void _addNames() {
    final input = _controller.text.trim();
    if (input.isNotEmpty) {
      names.addAll(input.split('\n'));
      _controller.clear();
    }
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(names: names),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('输入名字')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '输入名字，以换行分隔'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addNames();
              },
              child: Text('添加名字'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToHomePage(context),
              child: Text('完成输入并跳转'),
            ),
          ],
        ),
      ),
    );
  }
}
