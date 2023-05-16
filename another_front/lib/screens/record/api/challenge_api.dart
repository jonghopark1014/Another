import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class GetChallenge{
  static Future<List<dynamic>> challengeList(int userId)
  async {
    var url = Uri.parse('$_baseUrl/badge/all/$userId');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200){
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

        return responseBody['data'];
      }
    } catch (error) {
      print(error);
      print('가져오기 실패');
    }
    print('null');
    return [];
  }

  static Future<List<dynamic>> successChallengeList(int userId)
  async {
    var url = Uri.parse('$_baseUrl/badge/success/$userId');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200){
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

        return responseBody['data'];
      }
    } catch (error) {
      print(error);
      print('가져오기 실패');
    }
    print('null');
    return [];
  }
}