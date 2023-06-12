import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class ShareImage {
  static Future<String?> shareImage(List<Widget> imageWidgets, int index) async {
    if (index >= 0 && index < imageWidgets.length) {
      final image = imageWidgets[index] as Image;
      final fileImage = image.image as FileImage;
      final fileBytes = await fileImage.file.readAsBytes();
      final imageBytes = Uint8List.fromList(fileBytes);
      try {
        await Share.shareXFiles([
          XFile.fromData(
            imageBytes,
            mimeType: 'image/png',
          ),
        ]);
        return "ok";
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null; // 如果索引无效，返回空字符串
  }
}