// import 'dart:convert';
// import 'package:another/constant/const/data.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:another/main.dart';
// import 'package:provider/provider.dart';
//
// class LoginApi {
//
//   static Future<void> loginUser({
//     required String username,
//     required String password,
//     required BuildContext context,
//   })
//   async {
//     var url = Uri.parse('$baseUrl/user/login');
//     Map<String, dynamic> requestBody = {
//       'username': username,
//       'password': password,
//     };
//
//     // 요청
//     var response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(requestBody));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('로그인 성공');
//       print('userid: ${response.headers['userid']}');
//       print('authorization: ${response.headers['authorization']}');
//       print('refresh: ${response.headers['refresh']}');
//       final userInfo = context.read<UserInfo>();
//       final userId = response.headers['userid'];
//       final accessToken = response.headers['authorization'];
//       final refreshToken = response.headers['refresh'];
//       userInfo.updateUserInfo(userId!, accessToken!, refreshToken!);
//
//     } else {
//       print('로그인 실패');
//     }
//   }
// }