import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  File? _image;
  List<Widget> _imageWidgets = [];
  SharedPreferences _prefs = SharedPreferences.getInstance() as SharedPreferences;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(_image!);
        saveImageToSharedPreferences(_image!); // 这句可能有问题
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadImageFromSharedPreferences(_image.toString()); // 这句可能有问题
  }


  // 从Shared Preferences中加载图像
  Future<File?> loadImageFromSharedPreferences(String imageUrl) async {
    final imageFile = await _prefs.getString(imageUrl);
    if (imageFile != null) {
      return File(imageFile);
    } else {
      return null;
    }
  }

  // 将图像保存到Shared Preferences中
  Future<void> saveImageToSharedPreferences(File image) async {
    final imageName = await _generateImageName();
    final bytes = await image.readAsBytes();
    await _prefs.setString(imageName, bytes as String);
  }

  // 从磁盘上删除图像文件
  Future<void> deleteImageFromSharedPreferences(String imageUrl) async {
    if (imageUrl != null) {
      await _prefs.remove(imageUrl);
    }
  }

  // 从Shared Preferences中获取图像名称
  Future<String> getImageName() async {
    return 'image_' + await _generateImageName();
  }

  // 帮助生成唯一的图像名称
  Future<String> _generateImageName() async {
    return DateTime.now().toIso8601String().replaceAll(':\\d+\$', '').substring(0, 8);
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
                  height: 5,
                ),
                //TODO:1.这个地方的流式布局会导致边界溢出，需要处理
                //TODO：2.这个不要单使用流式布局而是使用类似照片墙的效果
                SizedBox(
                  height: 480,
                  child: ListView.builder( // 后续将此处的_colors改为_imageWidgets
                      itemCount: _imageWidgets.length,      //这里必须要指定List的长度
                      itemBuilder:(context,index){      //需要传入两个参数，然后Builder会自动从0一直循环到最大长度
                        return ListTile(
                          title: _imageWidgets[index],  //每次取出index的索引对应的数据返回
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