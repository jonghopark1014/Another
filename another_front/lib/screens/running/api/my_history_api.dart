import 'dart:convert';

import 'package:another/constant/const/data.dart';
import 'package:http/http.dart' as http;


Future<dynamic> myHistoryApi(int userId) async {
  var url = Uri.parse('$baseUrl/versus/record/$userId/myrecord');
  var response = await http.get(url);

  return jsonDecode(response.body)["data"]["content"];
}