import 'package:flutter/material.dart';
import './widgets/my_flexible_space_bar.dart';
import '../teacher.dart';

void main() {
  runApp(Statistics());
}

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatisticsPage(),
      // 注册路由
      routes: {
        '/learn': (context) => Tabs(initialIndex: 1),
        '/video': (context) => Tabs(initialIndex: 0),
        '/pk': (context) => Tabs(initialIndex: 1),
      },
    );
  }
}

/// design/5统计/index.html
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key('statistic_list'),
        physics: const ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  bool isDark = false;

  List<Widget> _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: isDark
              ? Container(
                  height: 115.0,
                  color: Colors.white,
                )
              : LoadAssetImage(
                  'statistic/statistic_bg',
                  height: 115.0,
                  fit: BoxFit.fill,
                ),
          centerTitle: true,
          titlePadding:
              const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: Text(
            '统计',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? Colors.white : null,
              image: isDark
                  ? null
                  : DecorationImage(
                      image:
                          ImageUtils.getAssetImage('statistic/statistic_bg1'),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              height: 120.0,
              child: const MyCard(
                child: Row(
                  children: <Widget>[
                    _StatisticsTab('去学习', 'xdd', '/learn'), // 添加路由名称
                    _StatisticsTab('去看视频', 'dps', '/video'), // 添加路由名称
                    _StatisticsTab('去pk', 'jrjye', '/pk'), // 添加路由名称
                  ],
                ),
              ),
            ),
          ),
          120.0,
        ),
      ),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 32),
              Text('数据走势',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 16),
              _StatisticsItem('软件使用统计', 'sjzs', 1),
              SizedBox(height: 8),
              _StatisticsItem('日常学习情况', 'jyetj', 2),
              SizedBox(height: 8),
              _StatisticsItem('圆形统计', 'sptj', 3),
            ],
          ),
        ),
      ),
    ];
  }
}

class _StatisticsItem extends StatelessWidget {
  const _StatisticsItem(this.title, this.img, this.index);

  final String title;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.14,
      child: GestureDetector(
        child: MyCard(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(fontWeight: FontWeight.w400)),
                      const LoadAssetImage('statistic/icon_selected',
                          height: 16.0, width: 16.0),
                    ],
                  ),
                ),
                Expanded(
                    child: LoadAssetImage('statistic/$img', fit: BoxFit.fill)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsTab extends StatelessWidget {
  const _StatisticsTab(this.title, this.img, this.routeName);

  final String title;
  final String img;
  final String routeName; // 新增属性，用于指定页面路由

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, routeName);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage('statistic/$img', width: 40.0, height: 40.0),
              SizedBox(height: 5),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.child, this.color, this.shadowColor});

  final Widget child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = color ?? Colors.white;
    final Color sColor = shadowColor ?? const Color(0x80DCE7FA);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: sColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0),
        ],
      ),
      child: child,
    );
  }
}

class ImageUtils {
  static ImageProvider getAssetImage(String name,
      {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name,
      {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
}

enum ImageFormat { png, jpg, gif, webp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}

class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image,
      {super.key,
      this.width,
      this.height,
      this.fit,
      this.format = ImageFormat.png});

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageFormat format;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      excludeFromSemantics: true,
    );
  }
}
