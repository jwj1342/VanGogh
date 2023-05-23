// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:vangogh/Auth/login_page.dart';
import 'package:vangogh/Create/create_page.dart';
import 'package:vangogh/Home/home_page.dart';
import 'package:vangogh/My/my_page.dart';
import 'package:vangogh/main.dart';
import 'package:vangogh/main.dart';

void main() {
  testWidgets('App initializes with login page when not logged in', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // 检查登录页面是否存在
    expect(find.byType(LoginPage), findsOneWidget);
    // 检查MyStatefulWidget是否不存在
    expect(find.byType(MyStatefulWidget), findsNothing);
  });

  testWidgets('App initializes with home page when logged in', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // 将MyApp视为Widget，并将isLoggedIn设置为true
    final myAppWidget = find.byType(MyApp).evaluate().first.widget as MyApp;
    myAppWidget.isLoggedIn = true;
    await tester.pump();

    // 检查登录页面是否不存在
    expect(find.byType(LoginPage), findsNothing);
    // 检查MyStatefulWidget和HomePage是否存在
    expect(find.byType(MyStatefulWidget), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Bottom navigation bar changes selected index', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // 将MyApp视为Widget，并将isLoggedIn设置为true
    final myAppWidget = find.byType(MyApp).evaluate().first.widget as MyApp;
    myAppWidget.isLoggedIn = true;
    await tester.pump();

    // 检查HomePage是否存在，而CreatePage和MyPage是否不存在
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(CreatePage), findsNothing);
    expect(find.byType(MyPage), findsNothing);

    // 模拟点击切换到CreatePage
    await tester.tap(find.byIcon(Icons.touch_app));
    await tester.pump();

    // 检查HomePage是否不存在，而CreatePage和MyPage是否存在
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(CreatePage), findsOneWidget);
    expect(find.byType(MyPage), findsNothing);

    // 模拟点击切换到MyPage
    await tester.tap(find.byIcon(Icons.supervisor_account));
    await tester.pump();

    // 检查HomePage、CreatePage是否不存在，而MyPage是否存在
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(CreatePage), findsNothing);
    expect(find.byType(MyPage), findsOneWidget);
  });

}

