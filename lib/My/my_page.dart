import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.jpg'), // 设置头像图片
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '用户昵称',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '个人简介',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Text(
                          '关注',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          '获赞',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          '收藏',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
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
                  leading: const Icon(Icons.favorite),
                  title: const Text('我的收藏'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('搜索'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('浏览记录'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),

                // 添加其他项目
                ListTile(
                  leading: const Icon(Icons.perm_identity),
                  title: const Text('个人信息'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('账号安全'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sentiment_satisfied_alt_outlined),
                  title: const Text('帮助与反馈'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('关于'),
                  onTap: () {
                    // 处理点击事件
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('退出登录'),
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
