import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage {
  static Future<bool> saveImage(List<String> imageUrl, int index) async{
    var response = await Dio().get(
        imageUrl[index],
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 80,
        name: "hello");
    if(result){
      return true;
    }else{
      return false;
    }
  }

}
