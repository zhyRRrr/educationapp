import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'studentchat/StudentHomePage.dart';
import 'teacherchat/teacher_chat.dart';

void main() {
  runApp(const MaterialApp(
    home: Chat(),
  ));
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async { 
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('user_role', 'teacher');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherChatApp()),
                );
              },
              child: Text('老师'),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('user_role', 'student');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentChatApp()),
                );
              },
              child: Text('学生'),
            ),
          ],
        ),
      ),
    );
  }
}
