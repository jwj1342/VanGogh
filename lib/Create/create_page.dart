import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  File? _image;
  List<Widget> _imageWidgets = [];
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
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://demo-test-vangogh-xrgfpupeat.cn-hangzhou.fcapp.run/test'));
    List<int> imageBytes = await imageFile.readAsBytes();
    var headers = {'Content-Type': 'image/jpeg'};
    request.bodyBytes = imageBytes;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      List<int> bytes = await response.stream.toBytes();
      setState(() {
        _imageWidgets.add(Image.memory(Uint8List.fromList(bytes)));
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  List<Widget> _colors = [
    new Container(
      height: 180.0,
      color: Colors.lightBlueAccent,
    ),
    new Container(
      height: 180.0,
      color: Colors.amber,
    ),
    new Container(
      height: 180.0,
      color: Colors.deepOrangeAccent,
    ),
    new Container(
      height: 180.0,
      color: Colors.purpleAccent,
    ),
  ];
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
                thickness: 3,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Container(
                  height: 10,
                ),
                //TODO:1.这个地方的流式布局会导致边界溢出，需要处理
                //TODO：2.这个不要单使用流式布局而是使用类似照片墙的效果
                SizedBox(
                  height: 480,
                  child: ListView.builder( // 后续将此处的_colors改为_imageWidgets
                      itemCount: _colors.length,      //这里必须要指定List的长度
                      itemBuilder:(context,index){      //需要传入两个参数，然后Builder会自动从0一直循环到最大长度
                        return ListTile(
                          title: _colors[index],  //每次取出index的索引对应的数据返回
                        );
                      },
                  )
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: //加号
          FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _getImage();
        },
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _getImage();
          },
        ),
      ),
    );
  }
}

//三个按钮的样式被封装在下面这个Widget中
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
