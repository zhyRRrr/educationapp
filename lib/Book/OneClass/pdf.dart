import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final String pdfUrl =
      "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/c4857bdb-4166-4552-b65e-41b545d8f7b8.pkg/pdf.pdf"; // 替换为你的PDF URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 加载本地PDF
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalPDFPage()),
              );
            },
            child: Text("Load Local PDF"),
          ),
          // 加载网络PDF。
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NetworkPDFPage(url: pdfUrl)),
              );
            },
            child: Text("Load Network PDF"),
          ),
        ],
      ),
    );
  }
}

class LocalPDFPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FutureBuilder: 用于异步操作的构建，展示不同的UI状态（如加载中、完成）。
    return FutureBuilder(
      // _loadPdfFromAssets: 这是一个异步函数，
      // 获取应用文档目录并返回一个本地PDF文件的路径。这里需要添加从资产文件夹复制PDF的逻辑。
      future: _loadPdfFromAssets(),
      // snapshot: AsyncSnapshot 对象，包含有关 future 的信息，如其状态和结果。
      builder: (context, snapshot) {
        // ConnectionState.done: 操作已完成，可以访问结果。
        if (snapshot.connectionState == ConnectionState.done) {
          // snapshot.data，其中存储了 _loadPdfFromAssets() 返回的 PDF 文件路径。
          return PDFViewerPage(path: snapshot.data as String);
        } else {
          // CircularProgressIndicator，这是一个旋转的加载指示器，告诉用户正在加载中。
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String> _loadPdfFromAssets() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/oneclassenglish.pdf');

    // 这里需要实现从 assets 拷贝文件到 file 的逻辑
    // 例如，使用 flutter/services.dart 中的 rootBundle.load 方法
    // 假设你已经将PDF文件放在assets中并通过代码复制到文件中
    // 这里可以用以下代码从assets加载PDF文件
    final byteData = await rootBundle.load('assets/pdf/oneclassenglish.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file.path;
  }
}

class NetworkPDFPage extends StatelessWidget {
  final String url;

  NetworkPDFPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _downloadFile(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return PDFViewerPage(path: snapshot.data as String);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloaded.pdf');

    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }
}

class PDFViewerPage extends StatelessWidget {
  final String path;

  PDFViewerPage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
