import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class MyFeedApi {
  static Future<dynamic> getFeed(
      String userId
      ) async {

    var url = Uri.parse('$_baseUrl/feed/$userId');
    // 요청
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('나의 피드 가져오기 성공');
      var responseBody = json.decode(response.body);
      return responseBody;
    } else {
      print('나의 피드 가져오기 실패');
    }
  }
}
