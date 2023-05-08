import 'dart:convert';

import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<dynamic> nextChallengeApi(int userId) async {
  var url = Uri.parse('$_baseUrl/api/run/recommendChallenge');
  var response = await http.post(url);
  print('-============================================================');
  print(response.statusCode);
  print(jsonDecode(response.body));

  return jsonDecode(response.body);
}