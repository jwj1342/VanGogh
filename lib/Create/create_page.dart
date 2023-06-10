import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  //with AutomaticKeepAliveClientMixin是为了保持页面状态
  @override
  bool get wantKeepAlive => true;//重写wantKeepAlive方法，返回true

  File? _image;
  List<Widget> _imageWidgets = [];


  //initState()方法是初始化状态，当Widget第一次插入到Widget树时会被调用，
  //对于每一个State对象，Flutter只会调用一次该方法，所以，通常在该方法中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。
  @override
  void initState() {
    super.initState();
    _loadImageWidgets();
  }

  //加载图片
  void _loadImageWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();//获取SharedPreferences实例
    List<String>? imagePaths = prefs.getStringList('imagePaths');//获取图片路径
    if (imagePaths != null) {
      setState(() {
        _imageWidgets = imagePaths.map((path) => Image.file(File(path))).toList();
        //将图片路径转换为图片
        //map()方法是将一个集合中的每一个元素都映射成一个新的元素，最终返回一个新的集合。
      });
    }
  }

  //dispose()方法是销毁状态，当State对象从树中被移除时，会调用此回调。
  @override
  void dispose() {
    _saveImageWidgets();
    super.dispose();
  }

  void _saveImageWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = _imageWidgets//获取图片路径
        .map((image) => (image as Image).image as FileImage)//将图片转换为FileImage
        .map((fileImage) => fileImage.file.path)//获取图片路径
        .toList();//转换为List
    //上面的代码是为了将图片路径转换为List<String>类型
    prefs.setStringList('imagePaths', imagePaths);//保存图片路径
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

    if (response.statusCode == 200) {
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));//透明状态栏
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
