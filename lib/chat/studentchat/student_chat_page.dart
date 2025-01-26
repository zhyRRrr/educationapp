import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../FileViewerPage.dart';
import '../FullScreenImagePage.dart';
import '../VideoPlayerPage.dart';
import '../group_chat_manager.dart';

class StudentChatPage extends StatefulWidget {
  final String groupId;
  final types.User user;

  StudentChatPage({required this.groupId, required this.user});

  @override
  _StudentChatPageState createState() => _StudentChatPageState();
}

class _StudentChatPageState extends State<StudentChatPage> {
  List<types.Message> _messages = [];
  bool _isSendingMessage = false;
  String _groupName = '';
  int _participantCount = 1;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _loadGroupInfo();
  }

  Future<void> _loadGroupInfo() async {
    final groupChat = groupChatManager.getGroupChat(widget.groupId);
    if (groupChat != null) {
      setState(() {
        _groupName = groupChat.name;
        _participantCount = groupChat.participantCount; // 正确加载参与人数
      });

      // 检查用户是否已经在参与者列表中，如果没有，则增加人数
      if (!groupChatManager.isUserAlreadyInChat(
          widget.groupId, widget.user.id)) {
        await groupChatManager.incrementParticipantCount(
            widget.groupId, widget.user.id, widget.user);
        setState(() {
          _participantCount = groupChat.participantCount;
        });
      }
    }
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson =
        prefs.getString('chat_${widget.groupId}_messages');
    if (messagesJson != null) {
      final List<dynamic> decodedMessages = jsonDecode(messagesJson);
      setState(() {
        _messages = decodedMessages
            .map((message) => types.Message.fromJson(message))
            .toList();
      });
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesJson = jsonEncode(_messages);
    await prefs.setString('chat_${widget.groupId}_messages', messagesJson);
  }

  void _handleSendPressed(types.PartialText message) async {
    if (_isSendingMessage) return;
    setState(() {
      _isSendingMessage = true;
    });

    final textMessage = types.TextMessage(
      author: widget.user.copyWith(imageUrl: widget.user.imageUrl),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
    await _saveMessages();
    groupChatManager.addMessage(widget.groupId, textMessage);
    setState(() {
      _participantCount =
          groupChatManager.getGroupChat(widget.groupId)?.participantCount ?? 1;
      _isSendingMessage = false;
    });
  }

  void _handleAttachmentPressed() async {
    if (_isSendingMessage) return;
    setState(() {
      _isSendingMessage = true;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileExtension = pickedFile.name.split('.').last.toLowerCase();

      types.Message message;

      if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
        // 图片文件
        message = types.ImageMessage(
          author: widget.user.copyWith(
            imageUrl: widget.user.imageUrl,
            metadata: widget.user.metadata,
          ),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          name: pickedFile.name,
          size: file.lengthSync(),
          uri: pickedFile.path,
        );
      } else if (['mp4', 'mov', 'avi', 'wmv'].contains(fileExtension)) {
        // 视频文件
        message = types.VideoMessage(
          author: widget.user.copyWith(
            imageUrl: widget.user.imageUrl,
            metadata: widget.user.metadata,
          ),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          name: pickedFile.name,
          size: file.lengthSync(),
          uri: pickedFile.path,
        );
      } else {
        // 其他文件类型
        message = types.FileMessage(
          author: widget.user.copyWith(
            imageUrl: widget.user.imageUrl,
            metadata: widget.user.metadata,
          ),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          mimeType: pickedFile.mimeType,
          name: pickedFile.name,
          size: file.lengthSync(),
          uri: pickedFile.path,
        );
      }

      setState(() {
        _messages.insert(0, message);
      });

      await _saveMessages();
      groupChatManager.addMessage(widget.groupId, message);

      setState(() {
        _participantCount =
            groupChatManager.getGroupChat(widget.groupId)?.participantCount ??
                1;
        _isSendingMessage = false;
      });
    } else {
      setState(() {
        _isSendingMessage = false;
      });
    }
  }

  Widget _buildMessageContent(types.Message message) {
    if (message is types.TextMessage) {
      return Text(
        message.text,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    } else if (message is types.ImageMessage) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(imageUri: message.uri),
            ),
          );
        },
        child: Image.file(
          File(message.uri),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    } else if (message is types.VideoMessage) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerPage(videoUri: message.uri),
            ),
          );
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.black,
          child: Center(
            child:
                Icon(Icons.play_circle_filled, color: Colors.white, size: 50),
          ),
        ),
      );
    } else if (message is types.FileMessage) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileViewerPage(fileUri: message.uri),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.grey[200],
          child: Row(
            children: [
              Icon(Icons.insert_drive_file, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  message.name,
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_groupName (2 人)'),
      ),
      body: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isCurrentUser = message.author.id == widget.user.id;
          final isTeacher = message.author.metadata?['role'] == 'teacher';

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0), // 添加间隔
            child: Row(
              mainAxisAlignment: isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  CircleAvatar(
                    backgroundImage: message.author.imageUrl != null
                        ? FileImage(File(message.author.imageUrl!))
                        : null,
                    child: message.author.imageUrl == null
                        ? Icon(Icons.person)
                        : null,
                  ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: 250),
                  decoration: BoxDecoration(
                    color: isTeacher ? Colors.blue : Colors.green, // 根据身份改变颜色
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCurrentUser)
                        Text(
                          message.author.firstName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      SizedBox(height: 5),
                      _buildMessageContent(message), // 动态构建消息内容
                    ],
                  ),
                ),
                if (isCurrentUser)
                  CircleAvatar(
                    backgroundImage: widget.user.imageUrl != null
                        ? FileImage(File(widget.user.imageUrl!))
                        : null,
                    child: widget.user.imageUrl == null
                        ? Icon(Icons.person)
                        : null,
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: ChatInput(
        onSendPressed: _handleSendPressed,
        onAttachmentPressed: _handleAttachmentPressed,
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  final void Function(types.PartialText) onSendPressed;
  final VoidCallback onAttachmentPressed;

  ChatInput({
    required this.onSendPressed,
    required this.onAttachmentPressed,
  });

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: onAttachmentPressed,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '输入消息...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final text = _textController.text.trim();
              if (text.isNotEmpty) {
                onSendPressed(types.PartialText(text: text));
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
