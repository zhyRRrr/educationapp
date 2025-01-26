import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WebFileOperationsPage1());
}

class WebFileOperationsPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '原神抽奖',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebFileOperationsPage(),
    );
  }
}

class WebFileOperationsPage extends StatefulWidget {
  @override
  _WebFileOperationsPageState createState() => _WebFileOperationsPageState();
}

class _WebFileOperationsPageState extends State<WebFileOperationsPage> {
  static const String apiUrl = 'http://localhost:8082/file';
  String fileContent = '';
  TextEditingController _textController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  Future<void> _loadFileContent() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('$apiUrl/txt-path'));
      if (response.statusCode == 200) {
        setState(() {
          fileContent = response.body;
          _textController.text = fileContent;
        });
      } else {
        throw Exception('Failed to load file content');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading file: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveFileContent() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/txt-path'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'content': _textController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(jsonEncode(<String, String>{'content': _textController.text}));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('文件保存成功')),
        );
      } else {
        throw Exception('保存文件失败');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存文件时出错: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _runExeFile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('$apiUrl/exe-path'));
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('EXE file executed successfully')),
        );
      } else {
        throw Exception('Failed to run EXE file');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error running EXE file: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请在电脑上面输入名字，手机上使用不了'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('请输入名字:'),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '名字内容',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('保存'),
                    onPressed: _saveFileContent,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('点击运行游戏'),
                    onPressed: _runExeFile,
                  ),
                ],
              ),
            ),
    );
  }
}
