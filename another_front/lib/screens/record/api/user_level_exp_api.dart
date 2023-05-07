import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class UserLevelExpApi{
  static Future<void> getUserLevelExp({
    required int userId
})
  async {
    var url = Uri.parse('${_baseUrl}/record/${userId}');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        int userLevel = responseBody['level'];
        int userExp = responseBody['exp'];
      }
    } catch (error) {
      print('유저 레벨,경험치 가져오기 실패');
    }
  }
}