import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:vangogh/Common/RemoteAPI.dart';
import 'package:vangogh/Create/create_page.dart';
import 'package:vangogh/Home/home_page.dart';
import 'package:vangogh/My/my_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Van Gogh';

  BuildContext? get context => null;

  set isLoggedIn(bool isLoggedIn) {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )); //透明状态栏
    return WillPopScope(
      onWillPop: () async {
        // 阻止默认的返回操作
        return false;
      },
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          fontFamily: 'HanaMinA',
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.blueGrey, // 设置背景色
          ),
        ),
        home: FutureBuilder<Widget>(
          future: _handleCurrentScreen(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 显示加载状态
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                // 处理错误情况
                return Text('Error: ${snapshot.error}');
              } else {
                // 显示获取到的页面
                return snapshot.data!;
              }
            }
          },
        ),
      ),
    );
  }

  Future<Widget> _handleCurrentScreen() async {
    // 根据当前登录状态决定显示的页面
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('Username');
    if (kDebugMode) {
      print("main_username:");
      print(username);
    }
    if(username!=null){
      return const MyStatefulWidget();
    }
    if(username==null){
      return const LoginPage();
    }
    var responseBody = await RemoteAPI(context).callProtect(username);
    if (kDebugMode) {
      print("main_responseBody");
      print(responseBody);
    }
    if (responseBody == null) {
      return const LoginPage();
    } else if (responseBody.containsKey('username')) {
      final String username = responseBody['username'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Username', username);
      prefs.setString('Following', "3");
      prefs.setString('Likes', "22");
      prefs.setString('Collects', "13");
      prefs.setBool('isLoggedIn', true);
      return const MyStatefulWidget();
    } else {
      if (kDebugMode) {
        print("main_登录状态已销毁");
      }
      // 未登录，跳转到登录页
      return const LoginPage();
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const CreatePage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
            backgroundColor: Color.fromRGBO(177, 182, 75, 0.9),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: '创作',
            backgroundColor: Color.fromRGBO(111, 136, 120, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            label: '我的',
            backgroundColor: Color.fromRGBO(173, 170, 196, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
