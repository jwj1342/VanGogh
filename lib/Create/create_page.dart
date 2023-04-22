import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(_image!);
      }
    });
  }

  Future<void> _uploadImage(File imageFile) async {
    print('开始上传图片：${imageFile.path}');
    // 这里自定义上传逻辑
    var request = http.MultipartRequest('POST', Uri.parse(''));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    print("状态码:");
    print(res.statusCode);
    print("响应体:");
    print(await res.stream.bytesToString());
  }

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
