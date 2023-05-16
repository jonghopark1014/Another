import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class GetHistoryRecord {
  static Future<Map<String, dynamic>> getTodayHistoryRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/history/today');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getWeekHistoryRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/history/week');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getMonthHistoryRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/history/month');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        return responseBody['data'];
      } else {
        return {};
      }
    } catch (error) {
      print(error);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getAllHistoryRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/history/all');

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

  // 달력 선택 날짜에 대한 기록 목록
  static Future<Map<String, dynamic>> getHistoryRecordSelectDay(int userId, String? date) async {
    var url = Uri.parse('$_baseUrl/record/$userId/history/interval?createDate=$date');

    try {
      var response = await http.post(url);
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
