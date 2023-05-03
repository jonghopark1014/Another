import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class SignupApi {

  static Future<void> joinUser({
    required String email,
    required String password,
    required String nickname,
    required bool isMale,
    int? height,
    int? weight})
    async {
      var url = Uri.parse('${_baseUrl}/user/join');
      Map<String, dynamic> requestBody = {
        'username': email,
        'password': password,
        'nickname': nickname,
        'sex': isMale ? 'MALE' : 'FEMALE',
        'height' : height,
        'weight' : weight,
      };

      // 요청
      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(requestBody));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('회원가입 성공');
      } else {
        print('회원가입 실패');
      }
  }
}
