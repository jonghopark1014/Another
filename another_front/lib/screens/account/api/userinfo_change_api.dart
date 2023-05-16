import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:another/main.dart';

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class UserInfoChangeApi {
  // 유저 정보 변경
  static Future<void> userInfoChange({
    required int height,
    required int weight,
    required String nickname,
  }) async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/user/profile/$userId');

    // HTTP PATCH 요청 보내기
    var headers = {'Content-Type': 'application/json'};
    var body =
        json.encode({'height': height, 'weight': weight, 'nickname': nickname});
    var response = await http.patch(url, headers: headers, body: body);

    // 응답 출력
    if (response.statusCode == 200) {
      print(await response.body);
      print('키몸무게 변경 성공');
    } else {
      print('키몸무게닉네임 요청실패: ${response.statusCode}');
    }
  }

  // 프로필 사진 변경
  static Future<void> profileImgChange({File? pickedFile}) async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/user/profile/image/$userId');

    // HTTP PATCH 요청 보내기
    var request = http.MultipartRequest('PATCH', url);

    request.files.add(await http.MultipartFile.fromPath(
      'profileImage',
      pickedFile!.path,
    ));
    var response = await request.send();

    // 응답 출력
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('성공');
    } else {
      print('프로필사진 변경 요청실패: ${response.statusCode}');
    }
  }
}
