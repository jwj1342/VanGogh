import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart';

class ShareImage {
  static Future<String?> shareImage(List<String> imageUrls, int index) async {
    if (index >= 0 && index < imageUrls.length) {
      // String imageUrl = imageUrls[index];
      // Image imageWidget = Image.network(imageUrl);
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
        print(e);
        return null;
      }
      // if (imageWidget is Image) {
      //   ImageProvider imageProvider = imageWidget.image;
      //   if (imageProvider is MemoryImage||imageProvider is NetworkImage) {
      //     Uint8List bytes = imageProvider.bytes;
      //     try {
      //       await Share.shareXFiles(
      //         [
      //           XFile.fromData(bytes, name: 'image.png')
      //         ],
      //         subject: '分享图像',
      //         text: '请查看附加的图像文件',
      //       );
      //       return "ok";
      //     } catch (e) {
      //       print(e);
      //       return null;
      //     }
      //   } else if (imageProvider is FileImage) {
      //     String filePath = imageProvider.file.path;
      //     try {
      //       await Share.shareXFiles(
      //         [
      //           XFile(filePath)
      //         ],
      //         subject: '分享图像',
      //         text: '请查看附加的图像文件',
      //       );
      //       return "ok";
      //     } catch (e) {
      //       print(e);
      //       return null;
      //     }
      //   }
      // }
    }
    return null; // 如果索引无效，返回空字符串
  }
}
