import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class GetRecord {
  static Future<Map<String, dynamic>> getTodayRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/today');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print('getTodayRecord');
        // print(responseBody['data']);
        return responseBody['data'];
      } else {
        // print('getTodayRecord오류');
        // print(response.statusCode);
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }


  static Future<Map<String, dynamic>> getWeekRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/week');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print('getWeekRecord');
        // print(responseBody['data']);
        return responseBody['data'];
      } else {
        // print('getWeekRecord오류');
        // print(response.statusCode);
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getMonthRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/month');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print('getMonthRecord');
        // print(responseBody['data']);
        return responseBody['data'];
      } else {
        // print('getMonthRecord오류');
        // print(response.statusCode);
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getAllRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/all');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print('getAllRecord');
        // print(responseBody['data']);
        return responseBody['data'];
      } else {
        // print('getAllRecord오류');
        // print(response.statusCode);
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }
}
