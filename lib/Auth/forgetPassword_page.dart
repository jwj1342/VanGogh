
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';



class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  Color _eyeColor = Colors.grey;
  late String _phone, _password;
  bool _isObscure = true;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  //final _formKey = GlobalKey<FormState>();
  TextEditingController? mController = TextEditingController();
  bool _isCountingDown = false;
  int _countDown = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1eecf),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            buildTitle(), // 重置密码
            const SizedBox(height: 40),
            buildPhoneTextField(), // 输入手机号
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            const SizedBox(height: 30),
            buildCheckPasswordTextField(context), // 确认密码
            const SizedBox(height: 30),
            buildVerificationCode(), //验证码

            const SizedBox(height: 100),
            buildLoginButton(context), // 登录
          ],
        ),
      ),
    );
  }

  Widget buildVerificationCode() {
    return TextFormField(
      onSaved: (value) {},
      controller: mController,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(6)
      ],
      decoration: InputDecoration(
        icon: Icon(Icons.admin_panel_settings_outlined),
        hintText: ('请输入验证码'),
        suffix: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                ignoring: _isCountingDown,
                child: InkWell(
                  onTap: _buttonClickListen,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '获取验证码',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: _isCountingDown,
                child: Center(
                  child: Text(
                    '$_countDown s',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _buttonClickListen() {
    setState(() {
      _isCountingDown = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _isCountingDown = false;
          _countDown = 60;
          timer.cancel();
        }
      });
    });
  }

  Widget buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all(Color(0x99252323)),
                // 设置圆角
                shape: MaterialStateProperty.all(const StadiumBorder(
                    side: BorderSide(style: BorderStyle.none)))),
            child:
            Text('登录', style: Theme
                .of(context)
                .primaryTextTheme
                .headline6),
            onPressed: () {
              // 表单校验通过才会继续执行
              if ((_formKey.currentState as FormState).validate()) {
                (_formKey.currentState as FormState).save();
                //TODO 执行登录方法
                print('phone: $_phone, password: $_password');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCheckPasswordTextField(context) {
    return TextFormField(
      obscureText: _isObscure,
      controller: _confirmPass,
      onSaved: (value) => _password = value!,
      validator: (value) {
        //bool status = ValidatorUtils.isMobileExact(value!);
        if (value == null || value.isEmpty) {
          return '确认密码不能为空';
        }
        if (value != _pass.text) {
          return '密码不匹配';
        }
      },
      decoration: InputDecoration(
        icon: Icon(Icons.lock_clock_outlined),
        hintText: "再次确认密码",
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

  Widget buildPasswordTextField(context) {
    return TextFormField(
      obscureText: _isObscure,
      controller: _pass,
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
        hintText: "请输入新密码",
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '手机号不能为空';
        }
      },
      decoration: InputDecoration(
        icon: Icon(Icons.account_circle_outlined),
        hintText: "请输入手机号",
      ),
    );
  }

  Widget buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: Text(
        "重置密码",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
