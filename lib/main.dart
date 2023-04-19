import 'package:flutter/material.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:vangogh/Create/create_page.dart';
import 'package:vangogh/Home/home_page.dart';
import 'package:vangogh/My/my_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        fontFamily: 'HanaMinA',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.blueGrey, // 设置背景色
        ),
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CreatePage(),
    MyPage(),
    LoginPage(),
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
          BottomNavigationBarItem(
            //这个登录的几面接口仅供开发使用，最后会移除。
            icon: Icon(Icons.login),
            label: '登录',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
