import 'dart:io';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:vangogh/Model/User.dart';
import 'package:flutter/widgets.dart';



void main() {
  // 创建一个 RemoteAPI 实例
  final remoteAPI = RemoteAPI(null);

  // 登录功能测试
  test('Login Test', () async {
    // 提供一个有效的用户名和密码
    const username = 'jwj1342';
    const password = '123456';

    // 执行登录操作
    final user = await remoteAPI.login(username, password);

    // 验证登录是否成功
    expect(user, isNotNull);
    // 根据实际情况进行进一步的断言，验证返回的用户对象是否符合预期
    // expect(user.username, equals('expected_username'));
    // expect(user.password, equals('expected_password'));
    // ...
  });

  // 注册功能测试
  test('Register Test', () async {
    // 提供一个有效的用户名和密码
    const username = 'dym';
    const password = '333';

    // 执行注册操作
    final user = await remoteAPI.register(username, password);

    // 验证注册是否成功
    expect(user, isNotNull);
    // 根据实际情况进行进一步的断言，验证返回的用户对象是否符合预期
    // expect(user.username, equals('expected_username'));
    // expect(user.password, equals('expected_password'));
    // ...
  });

  // 图片上传功能测试
  test('Image Upload Test', () async {
    // 提供一个有效的图片文件路径
    const imageFilePath = 'assets/images/placeholder.jpg';

    // 创建一个临时文件副本
    final tempImageFile = await _createTempImageFile(imageFilePath);

    // 执行图片上传操作
    final imageUrl = await remoteAPI._uploadImage(tempImageFile);

    // 验证图片上传是否成功
    expect(imageUrl, isNotNull);
    // 根据实际情况进行进一步的断言，验证返回的图片URL是否符合预期
    // expect(imageUrl, equals('expected_image_url'));
    // ...
  });
}

// 创建临时文件副本
Future<File> _createTempImageFile(String imageFilePath) async {
  final originalFile = File(imageFilePath);
  final tempDir = Directory.systemTemp;
  final tempFileName = path.basename(imageFilePath);
  final tempFilePath = path.join(tempDir.path, tempFileName);
  final tempFile = await originalFile.copy(tempFilePath);
  return tempFile;
}














class RemoteAPI {
  RemoteAPI(BuildContext ? context);

  Future login(String username, String password) async {
    const url =
        'https://springboot-web-framework-suavkxfcpe.cn-hangzhou.fcapp.run/auth/login'; // 替换为实际的登录接口URL
    final headers = {'Content-Type': 'application/json'}; // 设置请求头

    final body = {
      'username': username,
      'password': password,
    };
    var jsonb = json.encoder.convert(body);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonb);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return User.fromJson(responseBody);
      // return true;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return null;
    }
  }

  Future register(String username, String password) async {
    const url =
        'https://64fb1cec-4fdb-47a6-9056-92daa6fb9ac7.mock.pstmn.io'; // 替换为实际的登录接口URL
    final headers = {'Authorization': ' '}; // 设置请求头

    final body = {
      'username': username,
      'password': password,
    };
    var jsonb = json.encoder.convert(body);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonb);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return User.fromJson(responseBody);
    }
    if (response.statusCode == 401) {
      return response.body;
    }
    return null;
  }

  Future<List<int>?> _uploadImage(File imageFile) async {
    if (kDebugMode) {
      print('开始上传图片：${imageFile.path}');
    }
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
      return bytes ;
    } else {
      return null;
    }
  }
}



