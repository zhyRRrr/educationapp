import 'package:education_app/student_logingra/lottie/lottie_demo.dart';
import 'package:education_app/student.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// 全局变量用于存储注册数据
String? registeredUsername;
String? registeredEmail;
String? registeredPassword;

class register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册页面'),
        centerTitle: true,
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  bool _isTermsChecked = false;
  late String _captcha;

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    final random = Random();
    _captcha = (1000 + random.nextInt(9000)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入用户名';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '邮箱',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return '请输入有效的电子邮件';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入密码';
                } else if (value.length < 6) {
                  return '密码至少6位数';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '确认密码',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请确认你的密码';
                } else if (value != _passwordController.text) {
                  return '密码不匹配';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _captchaController,
              decoration: InputDecoration(
                labelText: '验证码 ($_captcha)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入验证码';
                } else if (value != _captcha) {
                  return '验证码不匹配';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('同意并已阅读注册须知条款'),
              value: _isTermsChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isTermsChecked = value ?? false;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_isTermsChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('请同意注册须知条款')),
                    );
                    return;
                  }

                  // 将数据存储到全局变量中
                  registeredUsername = _usernameController.text;
                  registeredEmail = _emailController.text;
                  registeredPassword = _passwordController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('注册成功')),
                  );

                  setState(() {
                    qiehuan = false;
                  });

                  // 跳转到登录页面
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              },
              child: Text('注册'),
            ),
            if (_isTermsChecked)
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "注册须知:在进行注册前，请务必仔细阅读并理解相关条款和条件。"
                  "注册过程涉及提供个人信息，请确保所填写内容真实、准确。注册成功后，"
                  "您将享有本平台提供的相关服务，但同时也需承担相应责任和义务。请妥善"
                  "保管您的账号和密码，避免泄露。",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
