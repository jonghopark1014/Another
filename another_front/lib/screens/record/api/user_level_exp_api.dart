import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class UserLevelExpApi{
  static Future<Map<String, dynamic>> getUserLevelExp()
  async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId');

    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        int userLevel = responseBody['data']['level'] ?? 0;
        int userExp = responseBody['data']['exp'] ?? 0;
        double progress = 0.0;
        switch (userLevel) {
          case 1:
            progress = userExp / 10;
            break;
          case 2:
            progress = userExp / 50;
            break;
          case 3:
            progress = userExp / 100;
            break;
          case 4:
            progress = userExp / 500;
            break;
          case 5:
            progress = userExp / 1000;
            break;
          case 6:
            progress = userExp / 5000;
            break;
          case 7:
            progress = userExp / 10000;
            break;
          case 8:
            progress = userExp / 50000;
            break;
          case 9:
            progress = userExp / 100000;
            break;
          case 10:
            progress = 0;
            break;
        }
        print('$userLevel, $progress');
        return {'level': userLevel, 'exp': progress};
      }
    } catch (error) {
      print(error);
      print('유저 레벨,경험치 가져오기 실패');
    }
    print('null');
    return {'level': 0, 'exp': 0};
  }
}