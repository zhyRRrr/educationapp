class UserVideo {
  final String url; // 将使用本地路径
  final String image; // 图片路径或名称
  final String? desc; // 视频描述

  UserVideo({
    required this.url,
    required this.image,
    this.desc,
  });

  // 修改 videoList 为本地视频路径
  static var videoList = [
    'assets/video/titok1.mp4',
    'assets/video/tiktok2.mp4',
    'assets/video/tiktok2.mp4',
    'assets/video/titok1.mp4',
    'assets/video/titok1.mp4',
    'assets/video/tiktok2.mp4',
    'assets/video/tiktok2.mp4',
    'assets/video/titok1.mp4',
    // 添加更多本地视频文件
  ];

  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = videoList
        .map((e) =>
            UserVideo(image: '', url: e, desc: e.split('/').last)) // 使用本地路径
        .toList();
    return list;
  }

// 整个字符串 '\nvideo:$url' 的作用是：
// 在打印时，首先会换行。
// 然后在新的一行中显示 "video:" 字样，后面紧跟着 url 变量的值。
// 假设 url 的值是 assets/video/titok1.mp4，那么 toString() 方法返回的结果将是：
// image:
// video: assets/video/titok1.mp4
  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }
}
