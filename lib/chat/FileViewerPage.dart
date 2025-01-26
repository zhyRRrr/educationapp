import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FileViewerPage extends StatelessWidget {
  final String fileUri;

  FileViewerPage({required this.fileUri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件查看'),
      ),
      body: PDFView(
        filePath: fileUri,
      ),
    );
  }
}
