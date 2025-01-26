import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../create_group_chat_page.dart';
import '../group_chat_manager.dart';
import '../join_group_chat_page.dart';
import '../teacherchat/teacher_chat_page.dart';

class TeacherChatApp extends StatelessWidget {
  TeacherChatApp() {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 调用 loadChatInfo 之前先重置加载状态
    // groupChatManager.resetChatLoadStatus();
    await groupChatManager.loadChatInfo('teacher'); // 加载老师端班级信息
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Chat UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeacherHomePage(),
    );
  }
}

class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  types.User? currentUser;
  List<String> joinedChats = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadJoinedChats();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('current_user_teacher');
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
    await prefs.setString('current_user_teacher', userJson);
  }

  Future<void> _loadJoinedChats() async {
    final prefs = await SharedPreferences.getInstance();
    final savedChats = prefs.getStringList('joined_chats_teacher') ?? [];

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
    await prefs.setStringList('joined_chats_teacher', joinedChats);
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'create':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateGroupChatPage(teacher: currentUser!),
          ),
        ).then((_) {
          _saveUser();
          _loadJoinedChats();
        });
        break;
      case 'join':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JoinGroupChatPage(
              user: currentUser!,
              role: 'teacher',
            ),
          ),
        ).then((updatedUser) {
          if (updatedUser != null) {
            setState(() {
              currentUser = updatedUser;
            });
            _saveUser();
          }
          _loadJoinedChats();
        });
        break;
    }
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
        title: Text('老师班级'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'create',
                  child: Text('创建班级'),
                ),
                PopupMenuItem(
                  value: 'join',
                  child: Text('加入班级'),
                ),
              ];
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: joinedChats.length,
              itemBuilder: (context, index) {
                final groupId = joinedChats[index];
                final groupChat = groupChatManager.getGroupChat(groupId);
                if (groupChat == null) return Container();
                final isSingleItem = joinedChats.length == 1;
                final isLastItem = index == joinedChats.length - 1;

                return Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 1,
                    ),
                    ListTile(
                      title: Text(groupChat.name),
                      onTap: () async {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupChatPage(
                              groupId: groupId,
                              user: currentUser!,
                            ),
                          ),
                        );

                        if (updatedUser != null) {
                          setState(() {
                            currentUser = updatedUser;
                          });
                          _saveUser();
                        }

                        _refreshChats();
                      },
                    ),
                    if (isSingleItem || isLastItem)
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
