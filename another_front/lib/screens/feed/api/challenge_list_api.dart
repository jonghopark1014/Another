import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class ChallengeListApi {
  static Future<dynamic> getFeed(
      ) async {
    var url = Uri.parse('$_baseUrl/versus/together');
    // 요청
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('함께 달린 사람 가져오기 성공');
      var responseBody = json.decode(response.body);
      return responseBody;
    } else {
      print('함께 달린 사람 가져오기 실패');
    }
  }
}
