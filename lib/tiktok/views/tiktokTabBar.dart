import '../style/style.dart';
import '../views/selectText.dart';
import 'package:flutter/material.dart';

// 参数是 TikTokPageTag 枚举类型，表示当前选中的标签页。
enum TikTokPageTag {
  home,

  me,
}

class TikTokTabBar extends StatelessWidget {
  // onTabSwitch：一个函数，当切换标签页时被调用，参数是 TikTokPageTag 枚举类型，表示当前选中的标签页。
  final Function(TikTokPageTag)? onTabSwitch;
  // onAddButton：一个函数，当点击添加按钮时被调用。
  final Function()? onAddButton;

// hasBackground：一个布尔值，表示导航栏是否有背景色。
  final bool hasBackground;
  // current：当前选中的标签页，类型是 TikTokPageTag 枚举。
  final TikTokPageTag? current;

  const TikTokTabBar({
    Key? key,
    this.onTabSwitch,
    this.current,
    this.onAddButton,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).padding 获取设备的边距，确保导航栏在不同设备上都有适当的布局。
    final EdgeInsets padding = MediaQuery.of(context).padding;
    Widget row = Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.home,
              title: '首页',
            ),
            onTap: () => onTabSwitch?.call(TikTokPageTag.home),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.me,
              title: '我',
            ),
            onTap: () => onTabSwitch?.call(TikTokPageTag.me),
          ),
        ),
      ],
    );
    return Container(
      color: hasBackground ? ColorPlate.back2 : ColorPlate.back2.withOpacity(0),
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 50 + padding.bottom,
        child: row,
      ),
    );
  }
}
