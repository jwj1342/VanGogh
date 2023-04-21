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

  //TODO: 1. 处理光标好下划线不匹配问题
  //TODO: 2. 删除验证码部分，到时候在注册页面再使用
  //TODO: 3. 优化在输入内容时，会出现底部溢出的问题
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[50], //添加淡紫色背景
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: /*Image.asset(
                'assets/images/logo1.jpg',
                height: 100,
              ),*/
                  Text("欢迎登录",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      )),
            ),

            // Phone number
            Row(
              children: const [
                Icon(Icons.account_circle_outlined), //添加icon
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '请输入电话号码',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Password
            Row(
              children: const [
                Icon(Icons.lock_clock_outlined), //添加icon
                SizedBox(width: 10),
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
            const SizedBox(height: 10.0),

            // Verification code
            Row(
              children: [
                const Icon(Icons.admin_panel_settings_outlined),
                const SizedBox(width: 10),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '请输入验证码',
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                //Text(_generateVerificationCode()), // 显示随机生成的验证码
                // Text(_verificationCode), // 显示验证码
                ElevatedButton(
                  onPressed: () {}, // 显示随机生成的验证码
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[100]),
                  child: Text(_generateVerificationCode()),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('忘记密码?'),
              ),
            ),

            // Login button
            const SizedBox(height: 15.0),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xbfff5773)),
                child: const Text('登录'), //按钮颜色为红色
              ),
            ),

            // Register button
            const SizedBox(height: 10.0),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xbfff5773),
                ),
                child: const Text('新用户注册'), //按钮颜色为红色
              ),
            ),

            //Agreement
            const SizedBox(
              height: 90.0,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: const CircleBorder(),
                ),
                const Text('我已阅读并同意用户服务协议和隐私政策'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
