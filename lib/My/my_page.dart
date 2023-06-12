import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final int _followerCount = 0;
  final int _favoriteCount = 0;
  final int _likeCount = 0;

  Future<String> _fetchFollowerCount() async {
    // TODO: 异步请求获取关注数
    await Future.delayed(const Duration(seconds: 1));
    return '100';
  }

  Future<String> _fetchFavoriteCount() async {
    // TODO: 异步请求获取收藏数
    await Future.delayed(const Duration(seconds: 1));
    return '200';
  }

  Future<String> _fetchLikeCount() async {
    // TODO: 异步请求获取点赞数
    await Future.delayed(const Duration(seconds: 1));
    return '300';
  }

  Future<String> _uploadAvatar() async {
    // TODO: 用户上传图片，并返回 URL 地址
    await Future.delayed(const Duration(seconds: 1));
    return 'https://cdn.example.com/user/avatar.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcce5ff),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10,35,10,0),
            padding: const EdgeInsets.all(40.0),
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
                  backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                  //默认图片
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
          child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
            child: ListView(
              children: [

                  _buildListTile(Icons.favorite, '我的收藏', () {}),
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
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 4.0),
        FutureBuilder<String>(
          future: title == '关注'
              ? _fetchFollowerCount()
              : title == '收藏'
              ? _fetchFavoriteCount()
              : _fetchLikeCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            return Text(
              snapshot.data.toString(),
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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




