import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:vangogh/Create/create_page.dart';
import 'package:vangogh/Home/home_page.dart';
import 'package:vangogh/My/my_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp({super.key});

  static const String _title = 'Van Gogh';

  set isLoggedIn(bool isLoggedIn) {}


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));//透明状态栏
    return MaterialApp(
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
    );
  }

  Future<Widget> _handleCurrentScreen() async {
    // 根据当前登录状态决定显示的页面
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn!=null && isLoggedIn) {
      return const MyStatefulWidget();
    } else {
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
    HomePage(),
    CreatePage(),
    MyPage(),
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
