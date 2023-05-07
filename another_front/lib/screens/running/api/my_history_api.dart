import 'dart:convert';

import 'package:http/http.dart' as http;


const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<dynamic> myHistoryApi(int userId) async {
  var url = Uri.parse('$_baseUrl/api/versus/record/$userId/myrecord');
  var response = await http.get(url);
  print('-============================================================');
  print(response.statusCode);
  print(jsonDecode(response.body));

  return jsonDecode(response.body);
}