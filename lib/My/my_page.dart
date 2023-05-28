import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _followerCount = 0;
  int _favoriteCount = 0;
  int _likeCount = 0;

  Future<int> _fetchFollowerCount() async {
    // TODO: 异步请求获取关注数
    await Future.delayed(Duration(seconds: 1));
    return 100;
  }

  Future<int> _fetchFavoriteCount() async {
    // TODO: 异步请求获取收藏数
    await Future.delayed(Duration(seconds: 1));
    return 200;
  }

  Future<int> _fetchLikeCount() async {
    // TODO: 异步请求获取点赞数
    await Future.delayed(Duration(seconds: 1));
    return 300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcce5ff),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color:const Color(0xffcce5ff),
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
                  backgroundImage: AssetImage('assets/avatar.jpg'),
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
                    _buildInfoColumn('关注', _followerCount),
                    _buildInfoColumn('获赞', _likeCount),
                    _buildInfoColumn('收藏', _favoriteCount),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListTile(
                    Icons.favorite, '我的收藏', () {}),
                _buildListTile(Icons.search, '搜索', () {}),
                _buildListTile(Icons.history, '浏览记录', () {}),
                _buildListTile(Icons.person_outline, '个人信息', () {}),
                _buildListTile(Icons.security, '账号安全', () {}),
                _buildListTile(Icons.settings, '设置', () {}),
                _buildListTile(Icons.help_outline, '帮助与反馈', () {}),
                _buildListTile(Icons.info_outline, '关于', () {}),
                _buildListTile(Icons.exit_to_app, '退出登录', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildInfoColumn(String title, int count) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 4.0),
        FutureBuilder<int>(
          future: title == '关注'
              ? _fetchFollowerCount()
              : title == '收藏'
              ? _fetchFavoriteCount()
              : _fetchLikeCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error');
            }
            return Text(
              snapshot.data.toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            );
          },
        ),
      ],
    );
  }

  ListTile _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}




