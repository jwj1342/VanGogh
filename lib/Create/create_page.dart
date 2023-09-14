import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vangogh/Common/SaveImageFromGallery.dart';
import 'package:vangogh/Common/ShareImageFromGallery.dart';

import '../Common/RemoteAPI.dart';

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
  bool isVisitor = false;
  String? _username;
  String title = '';
  List<Widget> _imageWidgets = [];
  List<String> _imageStrings=[];

  //initState()方法是初始化状态，当Widget第一次插入到Widget树时会被调用，
  //对于每一个State对象，Flutter只会调用一次该方法，所以，通常在该方法中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。
  @override
  void initState() {
    super.initState();
    _loadImageWidgets();
  }

  //加载图片
  void _loadImageWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('imagePaths');
    //List<Image> _imageFiles = [];
    if (imagePaths != null&&imagePaths.isNotEmpty) {
      setState(() {
        _imageWidgets=[];
        for(String imageString in imagePaths){
          //_imageWidgets.add(Image.network(imageString));
          _imageWidgets.add(CachedNetworkImage(placeholder: (context, url) => const CircularProgressIndicator(),imageUrl:imageString));
        }
      });
      _imageStrings=imagePaths;
    }else{
      setState(() {_imageWidgets=[];}); // 删除最后一张图片清空页面
    }

    if (kDebugMode) {
      print("此时图片："+_imageWidgets.toString());
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
    prefs.setStringList('imagePaths', _imageStrings);
  }


  void _deleteImageWidgets(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('imagePaths'); //获取图片路径
    try {
      if (imagePaths != null) {
        imagePaths.removeAt(index);
      }
      prefs.setStringList('imagePaths', imagePaths!);

      _imageStrings.removeAt(index);
      _imageWidgets.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("删除成功"),
      ));
      _loadImageWidgets(); // 再次刷新以更新页面显示内容

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("保存失败: $e"),
      ));
    }
  }


  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // 在 build 之后设置状态
    if (mounted) {
      // 检查当前 State 对象是否仍然存在于 widget 树中
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          //用户名，是否是游客
          _userData();
          _showInputDialog();// 获取图片标题

        }
      });
      _saveImageWidgets();// 更新图片列表
    }
  }

  Future<void> _userData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('Username') ?? "你是游客吧";
    });
    if (_username == "你是游客吧") isVisitor = true;
    if (kDebugMode) {
      print(_username!);
      print(isVisitor);
    }
  }

  Future<void> _showInputDialog() async {
    String? imageName;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('输入图片名称'),
          content: TextField(
            onChanged: (String value) {
              imageName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                Navigator.pop(context, imageName);
              },
            ),
          ],
        );
      },
    ).then((value) async {
      if (value != null) {
        if (kDebugMode) {
          print("image");
          print(value);
        }
        var responseBody = await RemoteAPI(context)
            .uploadImage(_image!, _username!,  value); //传递数据
        String imageUrl = responseBody!['imageUrlAfter']; //这一步是将返回数据转换成json格式
        setState(() {
          _imageStrings.add(imageUrl);
        });
        if (kDebugMode) {
          print(_imageStrings);
        }
        _saveImageWidgets();
        _loadImageWidgets();
      }
    });
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
                ShareImage.shareImage(_imageStrings , index);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("分享成功"),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('保存'),
              onTap: () async {
                // 处理保存逻辑
                var saveResult = SaveImage.saveImage(_imageStrings, index);
                if (await saveResult){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("保存成功"),
                  ));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("保存失败"),
                  ));
                }
                Navigator.pop(context);
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
          _getImage(); //+号的点击事件
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
