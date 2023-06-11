import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
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

  void _deleteImageWidgets(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('imagePaths');//获取图片路径
    try{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存成功"),
      ));
      if (imagePaths != null) {
        //imagePaths.removeRange(index,index); // 仅能在第一张完成删除操作，但会删除其之后的所有图片
        imagePaths.remove(index); // 点任意一张图片都删除所有图片
      }
      prefs.setStringList('imagePaths', imagePaths!);//保存图片路径
      _loadImageWidgets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存失败: $e"),
      ));
  }}

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImageTEST(_image!);
      }
    });
  }
  //注意下面的是用于测试使用的，不是真正的上传图片
  Future<void> _uploadImageTEST(File imageFile) async {
    print('开始测试${imageFile.path}');
    setState(() {
      _imageWidgets.add(Image.memory(imageFile.readAsBytesSync()));
    });
    _saveImageWidgets();
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
        _imageWidgets.add(Image.memory(Uint8List.fromList(bytes)));
      });
      _saveImageWidgets();
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
              leading: Icon(Icons.share),
              title: Text('分享'),
              onTap: () {
                // 处理分享逻辑
                shareImage(index);
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save),
              title: Text('保存'),
              onTap: () {
                // 处理保存逻辑
                saveImage(index);
               // Navigator.pop(context);
              },
            ),
            ListTile(
                leading:Icon(Icons.delete),
                title:Text('删除'),
                onTap:(){
                  _deleteImageWidgets(index);
                  Navigator.pop(context);
                }
            )
          ],
        );
      },
    );
  }
  saveImage (int index) async {
    try {

     String imagePath="";
      //转换为Uint8List类型的字节数组。
      Uint8List imageBytes;
      ByteData bytes = await rootBundle.load(imagePath);
      imageBytes = bytes.buffer.asUint8List();
      // 保存图片到相册
      await ImageGallerySaver.saveImage(imageBytes);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存成功"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存失败: $e"),
      ));
    }
  }
  void shareImage(int index) async {
    try {
      //加载指定路径的文件，并将其存储在变量data中。
      String imagePath="";
      final data = await rootBundle.load(imagePath);
      // 将data对象中的字节缓冲区存储在变量buffer中
      final buffer = data.buffer;
      await Share.shareXFiles([
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          mimeType: 'image/png',
        ),
      ]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("分享成功"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("分享失败: $e"),
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
              child: Divider(
                color: Colors.black26,
                thickness: 3,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        onPressed: _getImage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
