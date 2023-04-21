import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor:Colors.white70,
      body: Column(
          children: [
      Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar.jpg'), // 设置头像图片
          ),
          SizedBox(height: 8.0),
          Text(
            '用户昵称',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            '个人简介',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '关注',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '0',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '获赞',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '0',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '收藏',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '0',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    Expanded(
    child: ListView(
    children: [

    ListTile(
    leading: Icon(Icons.favorite),
    title: Text('我的收藏'),
    onTap: () {
    // 处理点击事件
    },
    ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('搜索'),
        onTap: () {
          // 处理点击事件
        },
      ),
    ListTile(
    leading: Icon(Icons.history),
    title: Text('浏览记录'),
    onTap: () {
    // 处理点击事件
    },
    ),

    // 添加其他项目
      ListTile(
        leading: Icon(Icons.perm_identity),
        title: Text('个人信息'),
        onTap: () {
          // 处理点击事件
        },
      ),
      ListTile(
        leading: Icon(Icons.lock_outline),
        title: Text('账号安全'),
        onTap: () {
          // 处理点击事件
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('设置'),
        onTap: () {
          // 处理点击事件
        },
      ),
      ListTile(
        leading: Icon(Icons.sentiment_satisfied_alt_outlined),
        title: Text('帮助与反馈'),
        onTap: () {
          // 处理点击事件
        },
      ),
      ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('关于'),
        onTap: () {
          // 处理点击事件
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('退出登录'),
        onTap: () {
          // 处理点击事件
        },
      ),
        ],
      ),

    ),
    ],
      ),
    );
  }
}

