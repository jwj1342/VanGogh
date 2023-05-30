import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:vangogh/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RemoteAPI {
  RemoteAPI(BuildContext context);
  Future login(String username, String password) async {
    const url = 'https://3aaa50f4-2bce-4e53-baff-454c222e14bd.mock.pstmn.io/auth/login'; // 替换为实际的登录接口URL
    final headers = {'Authorization': ' '}; // 设置请求头
    final body = {
      'username': username,
      'password': password,
    };

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return User.fromJson(responseBody);
      // return true;
    } else {
      return null;
    }
  }
  Future register(String username, String password) async {
    const url = 'https://796c8ecb-a000-4e76-83c0-716d6d7ff464.mock.pstmn.io/register'; // 替换为实际的注册接口URL
    final headers = {'Authorization': ' '}; // 设置请求头
    final body = {
      'username': username,
      'password': password,
    };

    final response = await http.post(Uri.parse(url), headers: headers, body: body);
//如果状态码为200,准换为json数据并返回
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
     // print(response.body);
      return User.fromJson(responseBody);
    } else {
      return null;
    }
  }
}
