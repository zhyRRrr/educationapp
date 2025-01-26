import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'group_chat_manager.dart';

class JoinGroupChatPage extends StatefulWidget {
  final types.User user;
  final String role;

  JoinGroupChatPage({required this.user, required this.role});

  @override
  _JoinGroupChatPageState createState() => _JoinGroupChatPageState();
}

class _JoinGroupChatPageState extends State<JoinGroupChatPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _handleJoinGroupChat() async {
    final groupId = _idController.text.trim();
    final userName = _nameController.text.trim();

    if (groupId.isNotEmpty && userName.isNotEmpty) {
      final updatedUser = widget.user.copyWith(
        firstName: userName,
        imageUrl: _imageFile != null ? _imageFile!.path : null,
        metadata: {'role': widget.role},
      );

      final groupChat = groupChatManager.getGroupChat(groupId);
      if (groupChat != null) {
        // 保存当前用户信息
        final prefs = await SharedPreferences.getInstance();
        final String userJson = jsonEncode(updatedUser.toJson());
        await prefs.setString('current_user_${widget.role}', userJson);

        // 加入班级
        List<String> joinedChats = prefs.getStringList('joined_chats_${widget.role}') ?? [];
        if (!joinedChats.contains(groupId)) {
          joinedChats.add(groupId);
          await prefs.setStringList('joined_chats_${widget.role}', joinedChats);
        }

        // 增加参与者计数
        if (!groupChatManager.isUserAlreadyInChat(groupId, updatedUser.id)) {
          await groupChatManager.incrementParticipantCount(groupId, updatedUser.id, updatedUser);
        }

        Navigator.pop(context, updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('请输入有效的班级号')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请输入有效的名字和班级号')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('加入班级')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '名字'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null ? Icon(Icons.add_a_photo) : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: '班级号'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleJoinGroupChat,
              child: Text('加入班级'),
            ),
          ],
        ),
      ),
    );
  }
}
