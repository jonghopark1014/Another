import 'dart:convert';

import 'package:http/http.dart' as http;


const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<dynamic> recommendChallengeApi(int userId) async {
  print('요청');
  var url = Uri.parse('$_baseUrl/api/run/recommendChallenge/$userId');
  var response = await http.get(url);
  print('리턴값 출력');
  print(jsonDecode(response.body));

  return jsonDecode(response.body);
}