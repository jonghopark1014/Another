import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class FeedApi {
  static Future<dynamic> getFeed() async {
    var url = Uri.parse('$_baseUrl/feed');
    // 요청
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('최신 피드 가져오기 성공');
      var responseBody = json.decode(response.body);
      return responseBody;

    } else {
      print('최신 피드 가져오기 실패');
    }
  }
}
