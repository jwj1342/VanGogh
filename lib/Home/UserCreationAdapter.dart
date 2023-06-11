import 'UserCreation.dart';

class UserCreationAdapter {
  static List<UserCreation> adapt(List<Map<String, dynamic>> data) {
    return data.map((item) {
      return UserCreation(
        item['likes'],
        imagePath: item['url'],
        title: item['title'],
        username: "john",);
    }).toList();
  }
}
