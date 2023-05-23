import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  //TODO:1. 把这个组件封装成有状态的组件
  //TODO:2. 把这个组件进行封装
  //TODO:3. 重命名各个组件
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
              color: const Color(0xffcce5ff),
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
              children:  [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/placeholder.jpg'), // 设置头像图片
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
                Row00(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                list_item(icon: Icons.favorite, title: Text('我的收藏')),
                icon01(),
                icon02(),
                icon03(),
                // 添加其他项目
                icon04(),
                icon05(),
                icon06(),
                icon07(),
                icon08(),
                icon09(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class icon09 extends StatelessWidget {
  const icon09({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text('退出登录'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon08 extends StatelessWidget {
  const icon08({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('关于'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon07 extends StatelessWidget {
  const icon07({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sentiment_satisfied_alt_outlined),
      title: const Text('帮助与反馈'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon06 extends StatelessWidget {
  const icon06({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('设置'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon05 extends StatelessWidget {
  const icon05({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock_outline),
      title: const Text('账号安全'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon04 extends StatelessWidget {
  const icon04({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.perm_identity),
      title: const Text('个人信息'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon03 extends StatelessWidget {
  const icon03({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: const Text('浏览记录'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon02 extends StatelessWidget {
  const icon02({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: const Text('搜索'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class icon01 extends StatelessWidget {
  const icon01({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.favorite),
      title: const Text('我的收藏'),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class list_item extends StatelessWidget {
  const list_item({
    super.key,
    required IconData icon,
    required Text title,
  });

  IconData? get icon => null;
  String? get title => null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title!),
      onTap: () {
        // 处理点击事件
      },
    );
  }
}

class Row00 extends StatelessWidget {
  const Row00({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
