import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage {
  static Future<String?> saveImage(List<Widget> imageWidgets, int index) async {
    if (index >= 0 && index < imageWidgets.length) {
      final image = imageWidgets[index] as Image;
      final fileImage = image.image as FileImage;
      final fileBytes = await fileImage.file.readAsBytes();
      final imageBytes = Uint8List.fromList(fileBytes);
      final result = await ImageGallerySaver.saveImage(imageBytes);
      return result['filePath'];
    }

    return null; // 如果索引无效，返回空字符串
  }
}
