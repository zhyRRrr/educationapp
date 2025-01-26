import 'dart:convert';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class GroupChat {
  final String id;
  final String name;
  final types.User teacher;
  final List<types.Message> messages;
  final Set<String> participantIds;

  GroupChat({
    required this.id,
    required this.name,
    required this.teacher,
    List<types.Message>? messages,
  })  : messages = messages ?? [],
        participantIds = {teacher.id};

  void addMessage(types.Message message) {
    messages.insert(0, message);
    participantIds.add(message.author.id);
  }

  int get participantCount => participantIds.length;
}

class GroupChatManager {
  final Map<String, GroupChat> _chats = {};
  final Map<String, bool> _isChatLoaded = {}; // 新增：记录聊天信息是否加载过

  Future<void> deleteGroupChat(String chatId) async {
    _chats.remove(chatId);
    await _removeChatInfo(chatId, 'teacher');
    await _removeChatInfo(chatId, 'student'); // 如果学生端也有该班级信息，一并删除
  }

Future<void> createGroupChat(String id, String name, types.User teacher) async {
  final groupChat = GroupChat(id: id, name: name, teacher: teacher);
  _chats[id] = groupChat;

  await _saveChatInfo(id, name, teacher, 'teacher');

  // 保存班级号到学生端
  final prefs = await SharedPreferences.getInstance();
  List<String> studentChatIds = prefs.getStringList('chat_ids_student') ?? [];
  if (!studentChatIds.contains(id)) {
    studentChatIds.add(id);
    await prefs.setStringList('chat_ids_student', studentChatIds);
    print('班级号 $id 已保存到学生端'); // 调试信息
  }
}


  GroupChat? getGroupChat(String id) {
    return _chats[id];
  }

  Future<void> addMessage(String chatId, types.Message message) async {
    final chat = _chats[chatId];
    chat?.addMessage(message);
    await _saveMessages(chatId);
  }

  List<GroupChat> getAllChats() {
    return _chats.values.toList();
  }

  bool isUserAlreadyInChat(String chatId, String userId) {
    final chat = _chats[chatId];
    if (chat != null) {
      return chat.participantIds.contains(userId);
    }
    return false;
  }

  Future<void> incrementParticipantCount(
      String chatId, String userId, types.User user) async {
    final chat = _chats[chatId];
    if (chat != null) {
      // 检查用户名是否为空，防止空白用户加入
      if (user.firstName != null && user.firstName!.isNotEmpty) {
        // 检查用户是否已经在参与者列表中
        if (!chat.participantIds.contains(userId)) {
          chat.participantIds
              .add(userId); // 只有当 userId 不在 participantIds 中时，才增加人数
          await _saveChatInfo(
              chat.id, chat.name, chat.teacher, 'teacher'); // 持久化参与者信息
        }
      }
    }
  }

  Future<void> _saveChatInfo(
      String id, String name, types.User teacher, String role) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chatIds = prefs.getStringList('chat_ids_$role') ?? [];
    if (!chatIds.contains(id)) {
      chatIds.add(id);
    }
    await prefs.setStringList('chat_ids_$role', chatIds);
    await prefs.setString('chat_name_${role}_$id', name);
    await prefs.setString(
        'chat_teacher_${role}_$id', jsonEncode(teacher.toJson()));
    await prefs.setInt(
        'participant_count_$id', _chats[id]?.participantCount ?? 0);
  }

  Future<void> _removeChatInfo(String id, String role) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chatIds = prefs.getStringList('chat_ids_$role') ?? [];
    chatIds.remove(id);
    await prefs.setStringList('chat_ids_$role', chatIds);
    await prefs.remove('chat_name_${role}_$id');
    await prefs.remove('chat_teacher_${role}_$id');
    await prefs.remove('chat_${id}_messages');
    await prefs.remove('participant_count_$id');
  }

  Future<void> _saveMessages(String chatId) async {
    final prefs = await SharedPreferences.getInstance();

    // 先加载已有的消息
    List<types.Message> existingMessages = [];
    final String? existingMessagesJson =
        prefs.getString('chat_${chatId}_messages');
    if (existingMessagesJson != null) {
      final List<dynamic> decodedMessages = jsonDecode(existingMessagesJson);
      existingMessages = decodedMessages
          .map((message) => types.Message.fromJson(message))
          .toList();
    }

    // 合并新旧消息
    existingMessages.addAll(_chats[chatId]?.messages ?? []);

    // 去重
    final uniqueMessages = existingMessages.toSet().toList();

    final String messagesJson =
        jsonEncode(uniqueMessages.map((msg) => msg.toJson()).toList());
    await prefs.setString('chat_${chatId}_messages', messagesJson);
  }

  Future<void> loadChatInfo(String role) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chatIds = prefs.getStringList('chat_ids_$role') ?? [];
    for (var id in chatIds) {
      final name = prefs.getString('chat_name_${role}_$id');
      final teacherJson = prefs.getString('chat_teacher_${role}_$id');
      final participantCount = prefs.getInt('participant_count_$id') ?? 0;
      if (name != null && teacherJson != null) {
        final teacher = types.User.fromJson(jsonDecode(teacherJson));
        _chats[id] = GroupChat(id: id, name: name, teacher: teacher);
        _chats[id]
            ?.participantIds
            .addAll(List.generate(participantCount, (_) => Uuid().v4()));
        await loadMessages(id);
      }
    }
  }

  Future<void> loadMessages(String chatId) async {
    final prefs = await SharedPreferences.getInstance();

    // 检查是否已经加载过聊天记录
    if (_isChatLoaded[chatId] == true) {
      return;
    }

    final String? messagesJson = prefs.getString('chat_${chatId}_messages');
    if (messagesJson != null) {
      final List<dynamic> decodedMessages = jsonDecode(messagesJson);
      final List<types.Message> newMessages = decodedMessages
          .map((message) => types.Message.fromJson(message))
          .toList();

      _chats[chatId]?.messages.addAll(newMessages);

      // 标记为已加载
      _isChatLoaded[chatId] = true;
    }
  }
}

final groupChatManager = GroupChatManager();
