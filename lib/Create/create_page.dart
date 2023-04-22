import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xf3a7bbae), //背景
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '时光清浅处',
              style: TextStyle(
                  color: Color(0xff252323),
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              '一步一安然',
              style: TextStyle(
                  color: Color(0xff252323),
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              //分割线
              child: Divider(
                color: Colors.black26,
                thickness: 5,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CreatedSelectButtom(
                  onPress: () {},
                  text: "全部",
                ),
                CreatedSelectButtom(
                  onPress: () {},
                  text: "已编辑",
                ),
                CreatedSelectButtom(
                  onPress: () {},
                  text: "已发布",
                ),
                Wrap(
                  //通过流式布局排列图片
                  spacing: 2,
                  runSpacing: 5,
                  children: <Widget>[],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: //加号
          FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {},
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

class CreatedSelectButtom extends StatelessWidget {
  const CreatedSelectButtom({
    super.key,
    required this.onPress,
    required this.text,
  });

  final VoidCallback onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      //三个button
      padding: const EdgeInsets.fromLTRB(0, 10, 4, 30),
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(CupertinoColors.inactiveGray),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14)),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
