import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vangogh/Auth/forgetPassword_page.dart';
import 'package:vangogh/Auth/register_page.dart';
import 'package:vangogh/Home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  Color _eyeColor = Colors.grey;
  late String _phone='', _password='',remoteData='',_id='',createdAt='',_url='';
  bool isLoading = false;
  bool _isObscure = true;
bool _isLoginSuccessful = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xA6ECE8B9),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            //const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            SafeArea(
                child:GestureDetector(
                  child: const Text('随便看看',style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const HomePage()));
                  },
                )),
            //buildSkip(),//随便看看
            buildTitle(), // 欢迎登录
            const SizedBox(height: 40),
            buildPhoneTextField(), // 输入手机号
            const SizedBox(height: 30),
            buildPasswordTextField(context), // 输入密码
            //buildForgetPasswordText(context), // 忘记密码
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
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?'),
            GestureDetector(
              child: const Text('点击注册', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Future.delayed(Duration(milliseconds: 500),(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const RegisterPage()));
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
            onPressed: () {
              // 表单校验通过才会继续执行
              if ((_formKey.currentState as FormState).validate()) {
                (_formKey.currentState as FormState).save();
                //发送登录请求
                _login(_id,_phone, _password,createdAt,_url);
                if(_isLoginSuccessful == true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                }else{

                }
              }
            },
          ),
        ),
      ),
    );
  }
  //发送登录请求
  Future<void> _login(String id,String phone, String password,String createdAt,String avatarUrl) async {
    print('开始登录：$phone,$password');
    Map<String, String> loginInfo = {'id':id,'username': phone, 'password': password,'created_at':createdAt,'avatar_url':avatarUrl};
    var request = http.post(Uri.parse('https://8b9bac75-7481-4995-bc6f-9c4c90f7f142.mock.pstmn.io/01'),
      body: jsonEncode(loginInfo),
      headers: {'Content-Type': 'application/json'},
    );
    var response = await request;
    if (response.statusCode == 200) {
        _isLoginSuccessful = true;
     // print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }


  // Widget buildForgetPasswordText(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8),
  //     child: Align(
  //       alignment: Alignment.centerRight,
  //       child: TextButton(
  //         onPressed:(){
  //           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //                   return  ForgetPasswordPage();//要跳转的页面
  //                 }));
  //         },
  //         child: const Text("忘记密码？",
  //             style: TextStyle(fontSize: 14, color: Colors.blue)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildPasswordTextField(context) {
    return TextFormField(
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
