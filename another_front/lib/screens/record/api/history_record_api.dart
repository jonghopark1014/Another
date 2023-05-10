import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class GetHistoryRecord {
  static Future<Map<String, dynamic>> getTodayHistoryRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/history/today');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getWeekHistoryRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/history/week');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getMonthHistoryRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/history/month');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getAllHistoryRecord() async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/history/today');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }
}