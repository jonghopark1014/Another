import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class UserInfoChangeApi {
  // 유저 정보 변경
  static Future<void> userInfoChange({
    required int height,
    required int weight,
    required String nickname,
  })
  async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/user/profile/$userId');

    // HTTP PATCH 요청 보내기
    var request = http.MultipartRequest('PATCH', url);
    var userUpdateForm = {
      'height': height,
      'weight': weight,
      'nickname': nickname
    };
    request.fields.addAll({
      'userUpdateForm': json.encode(userUpdateForm),
    });

    var response = await request.send();

    // 응답 출력
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('요청실패: ${response.statusCode}');
    }
  }

  // 프로필 사진 변경
  static Future<void> profileImgChange({
    required File pickedFile
  })
  async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/user/profile/image/$userId');

    // HTTP PATCH 요청 보내기
    var request = http.MultipartRequest('PATCH', url);
    request.files.add(await http.MultipartFile.fromPath(
      'profileImage',
      pickedFile.path,
    ));
    var response = await request.send();

    // 응답 출력
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('요청실패: ${response.statusCode}');
    }
  }

}