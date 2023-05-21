import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:vangogh/Home/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  Color _eyeColor = Colors.grey;
  late String _phone, _password,_autoCodeText="获取验证码",_id2,now,_url='';
  late int _id1;
  bool _isObscure = true;
  final TextEditingController _pass = TextEditingController();
  bool _isRegisterSuccessful = false;
  // final TextEditingController _confirmPass = TextEditingController();
  // TextEditingController? cController = TextEditingController();
  // late Timer _timer;
  // int _timeCount = 60;

  bool _isChecked = false; //单选，用户协议
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
            buildTitle(), // 欢迎注册
            const SizedBox(height: 40),
            buildPhoneTextField(), // 输入手机号
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            // const SizedBox(height: 30),
            // buildCheckPasswordTextField(context), // 确认密码
            // const SizedBox(height: 30),
            // buildVerificationCode(), //验证码
            // const SizedBox(height: 30),
            // buildAccept(context), //用户协议和隐私政策
            const SizedBox(height: 100),
            buildRegisterButton(context), // 注册
          ],
        ),
      ),
    );
  }

  Widget buildAccept(context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        Text("我已阅读并同意用户服务协议和隐私政策")
      ],
    );
  }

  // Widget buildVerificationCode() {
  //   return TextFormField(
  //     onSaved: (value) {},
  //     controller: cController,
  //     maxLength: 6,
  //
  //     inputFormatters: [
  //       FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  //       LengthLimitingTextInputFormatter(6)
  //     ],
  //     decoration: InputDecoration(
  //       icon: Icon(Icons.admin_panel_settings_outlined),
  //       hintText: ('请输入验证码'),
  //       suffix: GestureDetector(
  //         child: Text(_autoCodeText,style: TextStyle(color: Colors.blue),),
  //         onTap: (){
  //           _startTimer();
  //         },
  //       ),
  //     ),
  //   );
  // }

  // void _startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_timeCount <= 0) {
  //         _autoCodeText = '重新获取';
  //         _timer.cancel();
  //         _timeCount = 60;
  //       } else {
  //         _timeCount -= 1;
  //         _autoCodeText = "$_timeCount" + 's';
  //       }
  //     });
  //   });
  // }

  Widget buildRegisterButton(BuildContext context) {
    return Align(
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
            child:
            Text('注册', style: Theme
                .of(context)
                .primaryTextTheme
                .headline6),
            onPressed: () async {
              // 表单校验通过才会继续执行
              if ((_formKey.currentState as FormState).validate()) {
                (_formKey.currentState as FormState).save();
                //生成ID

                  _id1= await generateUniqueId();

                _id2=  _id1.toString();
                //注册时间
                now = DateTime.now().toIso8601String();
                //发送注册请求
                _register(_id2,_phone, _password,now,_url);
                if(_isRegisterSuccessful == true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                }
              }
            },
          ),
        ),
      ),
    );
  }
  //发送登录请求
  Future<void> _register(String id,String phone, String password,String createdAt,String avatarUrl) async {
    print('开始登录：$id,$phone,$password,$createdAt,$avatarUrl');
    Map<String, String> loginInfo = {'id':id,'username': phone, 'password': password,'created_at':createdAt,'avatar_url':avatarUrl};
    var request = http.post(Uri.parse('https://8b9bac75-7481-4995-bc6f-9c4c90f7f142.mock.pstmn.io/01'),
      body: jsonEncode(loginInfo),
      headers: {'Content-Type': 'application/json'},
    );
    var response = await request;
    if (response.statusCode == 200) {
      _isRegisterSuccessful = true;
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
  //生成id
  Future<int> generateUniqueId() async {
    final int min = 1;
    final int max = 9999;
    return Random().nextInt(max - min + 1) + min;
  }
  // Widget buildCheckPasswordTextField(context) {
  //   return TextFormField(
  //     obscureText: _isObscure,
  //     controller: _confirmPass,
  //     onSaved: (value) => _password = value!,
  //     validator: (value) {
  //       //bool status = ValidatorUtils.isMobileExact(value!);
  //       if (value == null || value.isEmpty) {
  //         return '确认密码不能为空';
  //       }
  //       if (value != _pass.text) {
  //         return '密码不匹配';
  //       }
  //     },
  //     decoration: InputDecoration(
  //       icon: Icon(Icons.lock_clock_outlined),
  //       hintText: "再次确认密码",
  //       suffixIcon: IconButton(
  //         icon: Icon(
  //           Icons.remove_red_eye,
  //           color: _eyeColor,
  //         ),
  //         onPressed: () {
  //           // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
  //           setState(() {
  //             _isObscure = !_isObscure;
  //             _eyeColor = (_isObscure
  //                 ? Colors.grey
  //                 : Theme
  //                 .of(context)
  //                 .iconTheme
  //                 .color)!;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

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
                  : Theme
                  .of(context)
                  .iconTheme
                  .color)!;
            });
          },
        ),
      ),
    );
  }

  Widget buildPhoneTextField() {
    return TextFormField(
      onSaved: (value) => _phone = value!,
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
        "欢迎注册",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
