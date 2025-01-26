import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'PostRepository.dart';

class StudentPostPage extends StatefulWidget {
  final List<XFile>? selectedImages;

  StudentPostPage({this.selectedImages});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<StudentPostPage> {
  List<XFile>? _displayedImages;
  int _selectedIndex = -1;
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedImages = widget.selectedImages ?? [];
  }

  void _pickMoreImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _displayedImages!.addAll(pickedImages);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _displayedImages!.removeAt(index);
    });
  }

  void _postContent() {
    if (_displayedImages != null &&
        _displayedImages!.isNotEmpty &&
        _titleController.text.isNotEmpty) {
      StudentPostRepository.addPost(_displayedImages!, _titleController.text);
      Navigator.pop(context, 3); // 传递当前索引值 3
    } else {
      // 提示用户图片和标题不能为空
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请添加图片并填写标题')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('发布动态'),
        actions: [
          TextButton(
            onPressed: _postContent,
            child: Text(
              '发布',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: _displayedImages!.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              if (index == _displayedImages!.length) {
                return GestureDetector(
                  onTap: _pickMoreImages,
                  child: Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.add_a_photo),
                  ),
                );
              }
              return Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Image.file(
                      File(_displayedImages![index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Visibility(
                      visible: _selectedIndex == index,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          color: Colors.black54,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '添加标题（必填）',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
