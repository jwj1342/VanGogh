import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlePage extends StatelessWidget {
  final String articlePath;

  const ArticlePage({required this.articlePath});

  Future<String> _loadArticle() async {
    return await rootBundle.loadString(articlePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              child: Markdown(data: snapshot.data.toString()),
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
