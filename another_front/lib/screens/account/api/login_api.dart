import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class loginApi {

  static Future<void> loginUser({
    required String email,
    required String password
  })
  async {
    var url = Uri.parse('${_baseUrl}/user/join');
    Map<String, dynamic> requestBody = {
      'username': email,
      'password': password,
    };

    // 요청
    var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('로그인 성공');
      // // 헤더에서 액세스 토큰, 리프레시 토큰, 사용자 ID 추출
      // final Map<String, String> headers = {};
      // response.headers.forEach((key, values) {
      //   headers[key] = values.join(',');
      // });
      // final String accessToken = headers['Authorization']!;
      // final String refreshToken = headers['Refresh']!;
      // final String userId = headers['userId']!;
      // print('accessToken: $accessToken');
      // print('refreshToken: $refreshToken');
      // print('userId: $userId');
    } else {
      print('로그인 실패');
    }
  }
}