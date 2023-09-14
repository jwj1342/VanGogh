import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:cached_network_image/cached_network_image.dart';
class SaveImage {
  static Future<bool> saveImage(List<String> imageUrl, int index) async{
    var response = await Dio().get(
        imageUrl[index],
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 80,
        name: "hello");
    // print(result);
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

}
