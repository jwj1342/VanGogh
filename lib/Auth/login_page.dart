import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final String _verificationCode; // 声明一个私有变量用于存储验证码

  @override
  void initState() {
    super.initState();
    _verificationCode = _generateVerificationCode();
  }

// 静态方法用于生成随机四位数的验证码
  static String _generateVerificationCode() {
    final random = Random();
    return '${random.nextInt(9000) + 1000}'; // 生成四位数的随机数字
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[50], //添加淡紫色背景
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Padding(
              padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
              child: Image.asset(
                'assets/images_g/logo1.jpg',
                height: 100,
              ),
            ),

            // Phone number
            Row(
              children: [
                Icon(Icons.account_circle_outlined), //添加icon
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '请输入电话号码',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            // Password
            Row(
              children: [
                Icon(Icons.lock_clock_outlined), //添加icon
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '请输入密码',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            // Verification code
            Row(
              children: [
                Icon(Icons.admin_panel_settings_outlined),
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '请输入验证码',
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                //Text(_generateVerificationCode()), // 显示随机生成的验证码
               // Text(_verificationCode), // 显示验证码
                ElevatedButton(
                  onPressed: () {},
                  child: Text(_generateVerificationCode()), // 显示随机生成的验证码
                  style: ElevatedButton.styleFrom(primary: Colors.purple[100]),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text('忘记密码?'),
              ),
            ),

            // Login button
            SizedBox(height: 15.0),
            Container(
              height: 40,
              margin: EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('登录'),
                style: ElevatedButton.styleFrom(primary:Color(0xbfff5773)), //按钮颜色为红色
              ),
            ),

            // Register button
            SizedBox(height: 10.0),
            Container(
              height: 40,
              margin: EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('新用户注册'),
                style: ElevatedButton.styleFrom(primary: Color(0xbfff5773),), //按钮颜色为红色
              ),
            ),


            //Agreement
            SizedBox(
              height: 90.0,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: CircleBorder(),
                ),
                Text('我已阅读并同意用户服务协议和隐私政策'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
