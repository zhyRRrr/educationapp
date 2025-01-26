import 'package:flutter/material.dart';
import './注册.dart';
import 'teachermine/我的主页面.dart';
import 'teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<SharedPreferences> _prefs;
  bool _flag = false;
  String _name = '';
  String _psw = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginFailed = false;
  bool _islogin = false;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _getValue();
  }

  Future<void> _getValue() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _flag = prefs.getBool('flag_key') ?? false;
      _name = prefs.getString('name_key') ?? '';
      _psw = prefs.getString('psw_key') ?? '';
      _nameController.text = _name;
      _pwdController.text = _psw;
    });
  }

  Future<void> _saveValue(bool flag, String name, String psw) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('flag_key', flag);
    prefs.setString('name_key', name);
    prefs.setString('psw_key', psw);
  }

  Future<void> _delValue() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('flag_key');
    prefs.remove('name_key');
    prefs.remove('psw_key');
  }

  void _login() {
    if (_usernameController.text == registeredUsername &&
        _passwordController.text == registeredPassword) {
      // 登录成功
      setState(() {
        _isLoginFailed = false;
        _islogin = true;
        isLoggedIn = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录成功')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Teacher(),
        ),
      );
    } else {
      // 登录失败
      setState(() {
        _isLoginFailed = _usernameController.text != registeredUsername;
        _islogin = _passwordController.text != registeredPassword;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isLoginFailed ? '用户名错误' : '密码错误')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('登录页'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: '用户名',
                border: OutlineInputBorder(),
                errorText: _isLoginFailed ? '用户名错误' : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: '密码',
                border: OutlineInputBorder(),
                errorText: _islogin ? '密码错误' : null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _flag,
                  onChanged: (bool? value) {
                    setState(() {
                      _flag = value ?? false;
                    });
                  },
                ),
                Text('保存用户名密码'),
              ],
            ),
            // SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login();
                if (_flag) {
                  _saveValue(_flag, _nameController.text, _pwdController.text);
                } else {
                  _delValue();
                }
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
