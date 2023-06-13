import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage {
  static Future<void> saveImage(List<Widget> imageWidgets, int index) async {
    if (index < 0 || index >= imageWidgets.length) {
      return; // 索引越界，不执行保存操作
    }

    Widget imageWidget = imageWidgets[index];
    if (imageWidget is Image) {
      ImageProvider imageProvider = imageWidget.image;
      if (imageProvider is MemoryImage) {
        Uint8List bytes = imageProvider.bytes;
        try {
          // 保存图像到相册
          final result = await ImageGallerySaver.saveImage(bytes);
          if (result['isSuccess']) {
            print("保存成功");
          } else {
            print("保存失败");
          }
        } catch (e) {
          print("保存失败: $e");
        }
      } else if (imageProvider is FileImage) {
        String filePath = imageProvider.file.path;
        try {
          // 保存图像到相册
          final result = await ImageGallerySaver.saveFile(filePath);
          if (result['isSuccess']) {
            print("保存成功");
          } else {
            print("保存失败");
          }
        } catch (e) {
          print("保存失败: $e");
        }
      }
    }
  }
}
