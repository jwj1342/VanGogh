import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlePage extends StatelessWidget {
  final String articlePath;
  final String appBarTitle;

  const ArticlePage({
    required this.articlePath,
    required this.appBarTitle,
  });

  Future<String> _loadArticle() async {
    return await rootBundle.loadString(articlePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xA6ECE8B9), // 修改背景颜色
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF634634), // 设置导航栏文字颜色为黑色
          ),
        ),
        centerTitle: true,
        // 设置导航栏文字居中
        backgroundColor: Color(0xffECE8B9),
        //elevation: 0, // 去除底部阴影
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF634634),
          onPressed: () {
            Navigator.pop(context); // 返回上一个页面
          },
        ),
      ),
      body: FutureBuilder(
        future: _loadArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Markdown(
                data: snapshot.data.toString(),
                styleSheet: MarkdownStyleSheet(
                  // 设置Markdown样式
                  h1: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF634634),
                  ),
                  h2: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF634634),
                  ),
                  p: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load article'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
