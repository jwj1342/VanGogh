import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:vangogh/Model/User.dart';

class RemoteAPI {
  RemoteAPI(BuildContext? context);

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
      print(response.reasonPhrase);
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
      return bytes ;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRecommendation() async {
    try {
      var url = Uri.parse('http://127.0.0.1:9000/picture/getRecommend'); // 替换为实际的登录接口URL
      var response = await http.get(url);

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> decodedBody = json.decode(responseBody);
        List<Map<String, dynamic>> result = [];
        if (decodedBody is List) {
          result = decodedBody.map((item) => item as Map<String, dynamic>).toList();
        } else {
          print('Invalid response body format');
        }
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error occurred while sending the request: $error');
      return [];
    }
  }
}
