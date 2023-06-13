import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class ShareImage {
  static Future<String?> shareImage(List<Widget> imageWidgets, int index) async {
    if (index >= 0 && index < imageWidgets.length) {
      Widget imageWidget = imageWidgets[index];
      if (imageWidget is Image) {
        ImageProvider imageProvider = imageWidget.image;
        if (imageProvider is MemoryImage) {
          Uint8List bytes = imageProvider.bytes;
          try {
            await Share.shareXFiles(
              [
                XFile.fromData(bytes, name: 'image.png')
              ],
              subject: '分享图像',
              text: '请查看附加的图像文件',
            );
            return "ok";
          } catch (e) {
            print(e);
            return null;
          }
        } else if (imageProvider is FileImage) {
          String filePath = imageProvider.file.path;
          try {
            await Share.shareXFiles(
              [
                XFile(filePath)
              ],
              subject: '分享图像',
              text: '请查看附加的图像文件',
            );
            return "ok";
          } catch (e) {
            print(e);
            return null;
          }
        }
      }
    }
    return null; // 如果索引无效，返回空字符串
  }
}
