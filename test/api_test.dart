import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vangogh/Common/RemoteAPI.dart';

void main() {
  test('Test getRecommendation', () async {
    List<Map<String, dynamic>> recommendation = await RemoteAPI(null).getRecommendation();
    if (kDebugMode) {
      print(recommendation);
    }
    // 进行进一步的断言和测试逻辑
    expect(recommendation, isA<List<Map<String, dynamic>>>());
    expect(recommendation.length, greaterThan(0));
  });
}
