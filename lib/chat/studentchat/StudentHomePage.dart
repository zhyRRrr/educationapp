import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../group_chat_manager.dart';
import '../studentchat/student_chat_page.dart';
import '../join_group_chat_page.dart';

class StudentChatApp extends StatelessWidget {
  StudentChatApp() {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 调用 loadChatInfo 之前先重置加载状态
    // groupChatManager.resetChatLoadStatus();
    await groupChatManager.loadChatInfo('student'); // 加载学生端班级信息
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Chat UI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StudentHomePage(),
    );
  }
}

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  types.User? currentUser;
  List<String> joinedChats = [];
  List<String> availableChats = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
    // _loadJoinedChats();
    _loadAvailableChats(); // 新增：加载可加入的班级
  }

  // 加载可加入的班级
  Future<void> _loadAvailableChats() async {
    final prefs = await SharedPreferences.getInstance();
    final savedChats = prefs.getStringList('chat_ids_student') ?? [];

     print('可加入的班级: $savedChats'); // 打印出加载的班级号

    setState(() {
      availableChats = savedChats;
    });
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('current_user_student');
    if (userJson != null) {
      setState(() {
        currentUser = types.User.fromJson(jsonDecode(userJson));
      });
    } else {
      setState(() {
        currentUser = types.User(id: Uuid().v4());
      });
    }
  }

  Future<void> _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String userJson = jsonEncode(currentUser!.toJson());
    await prefs.setString('current_user_student', userJson);
  }

  Future<void> _loadJoinedChats() async {
    final prefs = await SharedPreferences.getInstance();
    final savedChats = prefs.getStringList('joined_chats_student') ?? [];

    for (var chatId in savedChats) {
      await groupChatManager.loadMessages(chatId);
    }

    setState(() {
      joinedChats = savedChats;
    });
  }

  void _refreshChats() {
    setState(() {
      joinedChats =
          groupChatManager.getAllChats().map((chat) => chat.id).toList();
    });
    _saveJoinedChats();
  }

  Future<void> _saveJoinedChats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('joined_chats_student', joinedChats);
  }

  void _onJoinChatPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinGroupChatPage(
          user: currentUser!,
          role: 'student',
        ),
      ),
    ).then((updatedUser) {
      if (updatedUser != null) {
        setState(() {
          currentUser = updatedUser;
        });
        _saveUser();
        _loadJoinedChats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('学生班级'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _onJoinChatPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: availableChats.length,
              itemBuilder: (context, index) {
                final groupId = availableChats[index];
                final groupChat = groupChatManager.getGroupChat(groupId);
                if (groupChat == null) return Container();

                return ListTile(
                  title: Text(groupChat.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentChatPage(
                          groupId: groupId,
                          user: currentUser!,
                        ),
                      ),
                    ).then((_) {
                      _loadJoinedChats();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
