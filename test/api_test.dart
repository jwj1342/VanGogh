import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:vangogh/Common/RemoteAPI.dart';

void main() {
  test('Test getRecommendation', () async {
    List<Map<String, dynamic>> recommendation = await RemoteAPI(null).getRecommendation();
    print(recommendation);
    // 进行进一步的断言和测试逻辑
    expect(recommendation, isA<List<Map<String, dynamic>>>());
    expect(recommendation.length, greaterThan(0));
  });
}
