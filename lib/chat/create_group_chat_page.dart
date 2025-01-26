import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 添加此行用于访问剪贴板
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'group_chat_manager.dart';

class CreateGroupChatPage extends StatefulWidget {
  final types.User teacher;

  CreateGroupChatPage({required this.teacher});

  @override
  _CreateGroupChatPageState createState() => _CreateGroupChatPageState();
}

class _CreateGroupChatPageState extends State<CreateGroupChatPage> {
  final TextEditingController _nameController = TextEditingController();
  String? _createdGroupId;

  void _handleCreateGroupChat() {
    final groupName = _nameController.text;
    if (groupName.isNotEmpty) {
      final groupId = Uuid().v4();
      groupChatManager.createGroupChat(groupId, groupName, widget.teacher);
      setState(() {
        _createdGroupId = groupId;
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('班级号已复制到剪贴板')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('创建班级')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '班级名称'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleCreateGroupChat,
              child: Text('创建班级'),
            ),
            if (_createdGroupId != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text('班级已创建，班级号: $_createdGroupId'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _copyToClipboard(_createdGroupId!),
                      child: Text('复制班级号到剪贴板'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
