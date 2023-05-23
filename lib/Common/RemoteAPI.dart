import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:vangogh/Model/User.dart';

class RemoteAPI {
  RemoteAPI(BuildContext context);
  Future login(String username, String password) async {
    const url = 'https://64fb1cec-4fdb-47a6-9056-92daa6fb9ac7.mock.pstmn.io'; // 替换为实际的登录接口URL
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
}