import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:vangogh/Model/User.dart';

class RemoteAPI {
  static const host = 'http://121.36.86.111:8080';
  RemoteAPI(BuildContext? context);

  Future login(String username, String password) async {
    const url = '$host/user/login'; // 替换为实际的登录接口URL
    final headers = {'Content-Type': 'application/json'}; // 设置请求头

    final body = {
      'userName': username,
      'password': password,
    };
    var jsonb = json.encoder.convert(body);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonb);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
      // return true;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }


  Future register(String username, String password) async {
    const url = '$host/user/register'; // 替换为实际的登录接口URL
    final Map<String, dynamic> requestData = {
      'userName': username,
      'password': password,
    };
    print(requestData);
    final http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(requestData),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("register success");
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    }else{
      print('Request failed with status: ${response.statusCode}');
      return null;
    }

  }

  Future<List<Map<String, dynamic>>> getRecommendation() async {
    try {
      var url = '$host/image/getRecommend'; // 替换为实际的登录接口URL
      var response = await http.get(url as Uri);

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> decodedBody = json.decode(responseBody);
        List<Map<String, dynamic>> result = [];
        if (decodedBody is List) {
          result = decodedBody.map((item) => item as Map<String, dynamic>).toList();
        } else {
          if (kDebugMode) {
            print('Invalid response body format');
          }
        }
        return result;
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error occurred while sending the request: $error');
      }
      return [];
    }
  }

  // Future<List<int>?> uploadImageV1(File imageFile) async {
  //   if (kDebugMode) {
  //     print('开始上传图片：${imageFile.path}');
  //   }
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           'http://demo-test-vangogh-xrgfpupeat.cn-hangzhou.fcapp.run/test'));
  //   List<int> imageBytes = await imageFile.readAsBytes();
  //   var headers = {'Content-Type': 'image/jpeg'};
  //   request.bodyBytes = imageBytes;
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     List<int> bytes = await response.stream.toBytes();
  //     return bytes;
  //   } else {
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>?> uploadImageV2(File imageFile, String username,String title) async {
    const url='$host/image/upload';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // 添加图片文件到请求体
    var file = await http.MultipartFile.fromPath('imageFile', imageFile.path);
    request.files.add(file);

    // 添加其他参数到请求体
    request.fields['userName'] = username;
    request.fields['title'] = title;
    request.fields['prompt'] = "I would like to transform a portrait photo using a diffusion model to emulate the distinctive style of Claude Monet's Impressionism. Please apply the following characteristics to the image: soft brushstrokes, vibrant colors with emphasis on capturing the play of light and shadow, blurred edges, and a dreamy, ethereal atmosphere. I want the final result to evoke the essence of Monet's iconic Impressionist paintings, showcasing a fusion of colors and a sense of fleeting beauty in the captured moment.";
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        // 图片上传成功，返回处理后的图片数据
        Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody;
      } else {
        // 处理请求失败的情况
        if (kDebugMode) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          print('Image upload failed with status ${response.statusCode}.');
        }
        return null;
      }
    } catch (e) {
      // 处理异常
      print('Image upload failed with error $e.');
      return null;
    }
  }

  Future callProtect(String username) async {
    const url = '$host/user/protected'; // 替换为实际的登录接口URL

    final Map<String, dynamic> requestData = {
      'userName': username,
    };
    // final Map<String, String> requestData = {
    //   'userName': 'username',
    // };

    final http.Response response = await http.post(
      Uri.parse(url),
      body: requestData,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    if (response.statusCode == 200) {
      print("stay success");
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    }else{
      print('RemoteAPI_callProtect Request failed with status: ${response.statusCode}');
      return null;
    }

  }
}
