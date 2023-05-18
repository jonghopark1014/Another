import 'dart:convert';
import 'package:another/constant/const/data.dart';
import 'package:http/http.dart' as http;


class VersusApi {
  static Future<dynamic> getFeed(
      String runningId
      ) async {
    var url = Uri.parse('$baseUrl/versus/$runningId');
    // 요청
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('경쟁 시작 성공');
      var responseBody = json.decode(response.body);
      return responseBody;
    } else {
      print(response.statusCode);
      print('경쟁 시작 실패');
    }
  }
}
