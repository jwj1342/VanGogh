import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  File? _image;
  List<Widget> _imageWidgets = [];

  @override
  void initState() {
    super.initState();
    _loadImageWidgets();
  }

  void _loadImageWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('imagePaths');
    if (imagePaths != null) {
      setState(() {
        _imageWidgets = imagePaths.map((path) => Image.file(File(path))).toList();
      });
    }
  }

  @override
  void dispose() {
    _saveImageWidgets();
    super.dispose();
  }

  void _saveImageWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = _imageWidgets
        .map((image) => (image as Image).image as FileImage)
        .map((fileImage) => fileImage.file.path)
        .toList();
    prefs.setStringList('imagePaths', imagePaths);
  }

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
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://demo-test-vangogh-xrgfpupeat.cn-hangzhou.fcapp.run/test'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: 'image.jpg',
      ),
    );
    http.StreamedResponse response = await request.send();
    if (/*response.statusCode == 200*/true) {
      List<int> bytes = await response.stream.toBytes();
      setState(() {
        // _imageWidgets.add(Image.memory(Uint8List.fromList(bytes)));
        _imageWidgets.add(Image.file(imageFile));
      });
      _saveImageWidgets(); // 保存到 SharedPreferences
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用 super.build(context)
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
                SizedBox(
                  height: 480,
                  child: ListView.builder(
                    itemCount: _imageWidgets.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: _imageWidgets[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _getImage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
