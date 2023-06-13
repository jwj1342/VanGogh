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
  test('Image UploadV2 Test', () async {
    // 提供一个有效的图片文件路径
    const imageFilePath = 'assets/images/placeholder.jpg';

    // 创建一个临时文件，用于测试
    final imageFile = File(imageFilePath);

    // 设置测试用的用户名、访客标志和标题
    final username = 'testUser';
    final isVisitor = false;
    final title = 'Test Image';

    // 调用上传图片的函数
    final result = await RemoteAPI(null).uploadImageV2(imageFile,username,isVisitor,title);

    // 检查结果是否为null
    expect(result, isNotNull);

    // 检查返回的图片数据是否有效
    expect(result!.length, greaterThan(0));
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




