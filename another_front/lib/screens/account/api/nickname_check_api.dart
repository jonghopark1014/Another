import 'dart:convert';
import 'package:another/constant/const/data.dart';
import 'package:http/http.dart' as http;



class emailCheckApi {
  static Future<String> emailCheck({
    required String email,
    required Function emailPossible,
    required Function emailDuplication
  })
  async {
    var url = Uri.parse('$baseUrl/user/checkname/${email}');

    try{
      var response = await http.get(url);
      print('요청');
      // 통신에 성공한 경우
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['data'] == true) {
          emailPossible();
          return '사용 가능';
        } else {
          emailDuplication();
          print('이미 있음');
          return '이미 있음';
        }
      } else {
        print('오류 발생');
        return '사용할 수 없는 Email입니다';
      }
      // 통신에 실패한 경우
    } catch (error) {
      print('통신 실패');
      return '서버 오류';
    }
  }
}

class doubleCheckApi {
  static Future<String> doubleCheck({
    required String nickname,
    required Function nicknamePossible,
    required Function nicknameDuplication
  })
  async {
    var url = Uri.parse('$baseUrl/user/duplicate/nickname/$nickname');

    try {
      var response = await http.get(url);
      print('요청');
      // 통신에 성공한 경우
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['data'] == true) {
          print("여긴가?");
          nicknamePossible();
          return '사용 가능';
        } else {
          nicknameDuplication();
          print('이미 있음');
          return '이미 있음';
        }
      } else {
        print('오류 발생');
        return '사용할 수 없는 닉네임입니다';
      }
      // 통신에 실패한 경우
    } catch (error) {
      print(error);
      print('통신 실패');
      return '서버 오류';
    }
  }
}