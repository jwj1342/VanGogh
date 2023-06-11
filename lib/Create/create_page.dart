import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vangogh/Common/SaveImageFromGallery.dart';
import 'package:vangogh/Common/ShareImageFromGallery.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>
    with AutomaticKeepAliveClientMixin {
  //with AutomaticKeepAliveClientMixin是为了保持页面状态
  @override
  bool get wantKeepAlive => true; //重写wantKeepAlive方法，返回true

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
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //获取SharedPreferences实例
    List<String>? imagePaths = prefs.getStringList('imagePaths'); //获取图片路径
    if (imagePaths != null) {
      setState(() {
        _imageWidgets =
            imagePaths.map((path) => Image.file(File(path))).toList();
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
    List<String> imagePaths = _imageWidgets //获取图片路径
        .map((image) => (image as Image).image as FileImage) //将图片转换为FileImage
        .map((fileImage) => fileImage.file.path) //获取图片路径
        .toList(); //转换为List
    //上面的代码是为了将图片路径转换为List<String>类型
    prefs.setStringList('imagePaths', imagePaths); //保存图片路径
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
    if (kDebugMode) {
      print('开始上传图片：${imageFile.path}');
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://demo-test-vangogh-xrgfpupeat.cn-hangzhou.fcapp.run/test'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: 'image.jpg',
      ),
    );
    http.StreamedResponse response = await request.send();
    if (/*response.statusCode == 200*/ true) {
      setState(() {
        _imageWidgets.add(Image.file(imageFile));
      });
      _saveImageWidgets(); // 保存到 SharedPreferences
    } else {
      print(response.reasonPhrase);
    }
  }

  void _showImageMenu(int index) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享'),
              onTap: () {
                // 处理分享逻辑
                ShareImage.shareImage(_imageWidgets, index);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("分享成功"),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('保存'),
              onTap: () {
                // 处理保存逻辑
                SaveImage.saveImage(_imageWidgets, index);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("保存成功"),
                ));
              },
            ),
            ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('删除'),
                onTap: () {
                  _deleteImageWidgets(index);
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void _deleteImageWidgets(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('imagePaths'); //获取图片路径
    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("删除成功"),
      ));
      if (imagePaths != null) {
        //imagePaths.removeRange(index,index); // 仅能在第一张完成删除操作，但会删除其之后的所有图片
        imagePaths.remove(index); // 点任意一张图片都删除所有图片
      }
      prefs.setStringList('imagePaths', imagePaths!); //保存图片路径
      _loadImageWidgets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存失败: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xf3a7bbae),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _imageWidgets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showImageMenu(index);
                    },
                    child: Container(
                      child: _imageWidgets[index],
                    ),
                  );
                },
              ),
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
