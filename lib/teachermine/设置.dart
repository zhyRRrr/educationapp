import 'package:flutter/material.dart';
import '1.dart';
import '../teacher.dart';
import '../注册.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  isLoggedIn ? AssetImage('assets/images/3.0x/1.jpg') : null,
              radius: 30,
              child: isLoggedIn ? null : Icon(Icons.person),
            ),
            title: isLoggedIn
                ? Text('2471***790')
                : GestureDetector(
                    onTap: () async {
                      //跳转到登录页面
                      final result = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return register();
                      }));
                      if (result == true) {
                        setState(() {
                          isLoggedIn = true;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Text('登录/注册  >',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
            subtitle: isLoggedIn ? Text('小米ID: 2471528790') : null,
          ),
          Divider(),
          ListTile(
            title: Text('消息推送'),
            subtitle: Text('免打扰时间: 23:00-次日8:00'),
            trailing: Text('已开启'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            title: Text('隐私设置'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            title: Text('意见反馈'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            title: Text('协议规则'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            title: Text('个人信息收集与使用清单'),
            onTap: () {
              // Handle tap
            },
          ),
          isLoggedIn
              ? ListTile(
                  title: Text('退出登录'),
                  onTap: () {
                    setState(() {
                      isLoggedIn = false;
                    });

                    //跳转路由
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Teacher();
                    }));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
