import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

class ShareImage {
  static Future<String?> shareImage(List<String> imageUrls, int index) async {
    if (index >= 0 && index < imageUrls.length) {
      var response = await Dio().get(
          imageUrls[index],
          options: Options(responseType: ResponseType.bytes));
      var bytes = response.data;
      try {
        await Share.shareXFiles(
          [
            XFile.fromData(bytes, name: 'image.png',mimeType: 'image/png')
          ],
          subject: '分享图像',
          text: '请查看附加的图像文件',
        );
        return "ok";
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return null;
      }
    }
    return null; // 如果索引无效，返回空字符串
  }
}
