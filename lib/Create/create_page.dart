import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SelectImagePage extends StatefulWidget {
  const SelectImagePage({super.key});
  @override
  _SelectImagePageState createState() => _SelectImagePageState();
}

class _SelectImagePageState extends State<SelectImagePage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Image.file(
                _image!,
                height: 300,
              )
            else
              Text('请选择一张图片'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('选择图片'),
            ),
          ],
        ),
      ),
    );
  }
}
