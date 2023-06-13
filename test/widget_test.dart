// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vangogh/Auth/forgetPassword_page.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:vangogh/Create/create_page.dart';
import 'package:vangogh/Home/home_page.dart';
import 'package:vangogh/My/my_page.dart';
import 'package:vangogh/main.dart';

// void main() {
//   testWidgets('App initializes with login page when not logged in', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     // 检查登录页面是否存在
//     expect(find.byType(LoginPage), findsOneWidget);
//     // 检查MyStatefulWidget是否不存在
//     expect(find.byType(MyStatefulWidget), findsNothing);
//   });
//
//   testWidgets('App initializes with home page when logged in', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     // 将MyApp视为Widget，并将isLoggedIn设置为true
//     final myAppWidget = find.byType(MyApp).evaluate().first.widget as MyApp;
//     myAppWidget.isLoggedIn = true;
//     await tester.pump();
//
//     // 检查登录页面是否不存在
//     expect(find.byType(LoginPage), findsNothing);
//     // 检查MyStatefulWidget和HomePage是否存在
//     expect(find.byType(MyStatefulWidget), findsOneWidget);
//     expect(find.byType(HomePage), findsOneWidget);
//   });
//
//   testWidgets('Bottom navigation bar changes selected index', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());
//
//     // 将MyApp视为Widget，并将isLoggedIn设置为true
//     final myAppWidget = find.byType(MyApp).evaluate().first.widget as MyApp;
//     myAppWidget.isLoggedIn = true;
//     await tester.pump();
//
//     // 检查HomePage是否存在，而CreatePage和MyPage是否不存在
//     expect(find.byType(HomePage), findsOneWidget);
//     expect(find.byType(CreatePage), findsNothing);
//     expect(find.byType(MyPage), findsNothing);
//
//     // 模拟点击切换到CreatePage
//     await tester.tap(find.byIcon(Icons.touch_app));
//     await tester.pump();
//
//     // 检查HomePage是否不存在，而CreatePage和MyPage是否存在
//     expect(find.byType(HomePage), findsNothing);
//     expect(find.byType(CreatePage), findsOneWidget);
//     expect(find.byType(MyPage), findsNothing);
//
//     // 模拟点击切换到MyPage
//     await tester.tap(find.byIcon(Icons.supervisor_account));
//     await tester.pump();
//
//     // 检查HomePage、CreatePage是否不存在，而MyPage是否存在
//     expect(find.byType(HomePage), findsNothing);
//     expect(find.byType(CreatePage), findsNothing);
//     expect(find.byType(MyPage), findsOneWidget);
//   });
//
// }

void main() {
  testWidgets('Phone and password functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              TextFormField(
                key: const Key('phone_input'), // 账号输入框的Key
              ),
              TextFormField(
                key: const Key('password_input'), // 密码输入框的Key
              ),
            ],
          ),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('phone_input')), '12345'); // 模拟输入账号
    await tester.enterText(find.byKey(const Key('password_input')), '6789'); // 模拟输入密码

    expect(find.text('12345'), findsOneWidget); // 验证账号输入框中是否显示了输入的账号
    expect(find.text('6789'), findsOneWidget); // 验证密码输入框中是否显示了输入的密码
  });

  testWidgets('Test forgot password button', (WidgetTester tester) async {
    // 创建一个测试用的MaterialApp
    await tester.pumpWidget(MaterialApp(
      home: const LoginPage(),
      routes: {
        '/forget_password': (context) => const ForgetPasswordPage(),
        '/main_page': (context) => const MyStatefulWidget(),
      },
    ));

    // 等待界面加载完成
    await tester.pumpAndSettle();

    // 查找忘记密码按钮
    final forgetPasswordButton = find.text('忘记密码？');

    // 点击忘记密码按钮
    await tester.tap(forgetPasswordButton);
    await tester.pumpAndSettle();

    // 验证是否成功跳转到重置密码页面
    expect(find.byType(ForgetPasswordPage), findsOneWidget);
  });

  // testWidgets('Test register button', (WidgetTester tester) async {
  //   // 创建一个测试用的MaterialApp
  //   await tester.pumpWidget(MaterialApp(
  //     home: LoginPage(),
  //     routes: {
  //       '/register_page': (context) => RegisterPage(),
  //       '/main_page': (context) => MyStatefulWidget(),
  //     },
  //   ));
  //
  //   // 等待界面加载完成
  //   await tester.pumpAndSettle();
  //
  //   // 查找"点击注册"按钮
  //   final registerButton = find.byKey(const Key('click_register'));
  //
  //   // 点击"点击注册"按钮
  //   await tester.tap(registerButton);
  //   await tester.pumpAndSettle();
  //
  //   // 验证是否成功跳转到注册页面
  //   expect(find.byType(RegisterPage), findsOneWidget);
  // });


  group('LoginPage', () {
    testWidgets('Widget has title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const ValueKey('welcome_login')), findsOneWidget);
    });

    testWidgets('Widget has 随便看看', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const ValueKey('casual_look')), findsOneWidget);
    });

    testWidgets('Widget has phone input field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const ValueKey('phone_input')), findsOneWidget);
    });

    testWidgets('Widget has password input field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const ValueKey('password_input')), findsOneWidget);
    });

    testWidgets('Widget has login button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });

    testWidgets('Widget has register text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const Key('no_account')), findsOneWidget);
      expect(find.byKey(const Key('click_register')), findsOneWidget);
    });

    testWidgets('Widget has forget password text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byKey(const Key('forget_password_text')), findsOneWidget);
    });

    // testWidgets('Clicking register text navigates to register page', (WidgetTester tester) async {
    //   await tester.pumpWidget(const MaterialApp(
    //     home: LoginPage(),
    //   ));
    //
    //   await tester.tap(find.text('点击注册'));
    //   await tester.pumpAndSettle();
    //
    //   expect(find.byType(RegisterPage), findsOneWidget);
    // });

    // Add more test cases as needed for other functionality in LoginPage
  });


  testWidgets('Test page navigation', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial page is the home page.
    expect(find.byType(HomePage), findsOneWidget);

    // Tap on the create button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that the page has changed to the create page.
    expect(find.byType(CreatePage), findsOneWidget);

    // Tap on the back button.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that the page has changed back to the home page.
    expect(find.byType(HomePage), findsOneWidget);

    // Tap on the my page button.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that the page has changed to the my page.
    expect(find.byType(MyPage), findsOneWidget);
  });



}









