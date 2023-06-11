import 'package:flutter/material.dart';
import 'package:vangogh/Auth/forgetPassword_page.dart';
import 'package:vangogh/Auth/register_page.dart';
import 'package:vangogh/main.dart';

import '../Common/RemoteAPI.dart';
import '../Model/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  Color _eyeColor = Colors.grey;
  late String _phone, _password;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('casual_look'),
      backgroundColor: const Color(0xfff1eecf),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            SafeArea(
                child: GestureDetector(
              child: const Text(
                '随便看看',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyStatefulWidget()));
              },
            )),
            //buildSkip(),//随便看看
            buildTitle(), // 欢迎登录
            const SizedBox(height: 40),
            buildPhoneTextField(), // 输入手机号
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            buildForgetPasswordText(context), // 忘记密码
            const SizedBox(height: 150),
            buildLoginButton(context), // 登录按钮
            const SizedBox(height: 30),
            buildRegisterText(context), // 注册
          ],
        ),
      ),
    );
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        key: const ValueKey('no_account'),
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?'),
            GestureDetector(
              key: const ValueKey('click_register'),
              child: const Text('点击注册', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Align(
      key: const ValueKey('login_button'),
      child: SizedBox(
        height: 45,
        width: 270,
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0x99252323)),
                // 设置圆角
                shape: MaterialStateProperty.all(const StadiumBorder(
                    side: BorderSide(style: BorderStyle.none)))),
            child: Text('登录',
                style: Theme.of(context).primaryTextTheme.titleLarge),
            onPressed: ()  async {
              // 表单校验通过才会继续执行
              if ((_formKey.currentState as FormState).validate()) {
                (_formKey.currentState as FormState).save();

                User? user = await RemoteAPI(context).login(_phone, _password);
                if (user != null) {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyStatefulWidget()),
                    );
                  }
                } else {
                  print("登录失败");
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ForgetPasswordPage(); //要跳转的页面
            }));

          },
          key: const ValueKey('forget_password_text'),
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.blue)),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(context) {
    return TextFormField(
      key: const ValueKey('password_input'),
      obscureText: _isObscure,
      onSaved: (value) => _password = value!,
      validator: (value) {
        //bool status = ValidatorUtils.isMobileExact(value!);
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        if (value.length < 6) {
          return '密码长度不能小于6位';
        }
      },
      decoration: InputDecoration(
        icon: Icon(Icons.lock_clock_outlined),
        hintText: "请输入密码",
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor = (_isObscure
                  ? Colors.grey
                  : Theme.of(context).iconTheme.color)!;
            });
          },
        ),
      ),
    );
  }

  Widget buildPhoneTextField() {
    return TextFormField(
      key: const ValueKey('phone_input'),
      onSaved: (value) => _phone = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '手机号不能为空';
        }
      },
      decoration: const InputDecoration(
        icon: Icon(Icons.account_circle_outlined),
        hintText: "请输入手机号",
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      key: const ValueKey('welcome_login'),
      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: Image.asset('assets/Logo/LoginPageLogoPNG.png'),
      // child: Text(
      //   "欢迎登录",
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     fontSize: 30,
      //     color: Colors.black,
      //   ),
    );
  }
}
