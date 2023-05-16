import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io/api';

class GetPeriodRecord {
  static Future<Map<String, dynamic>> getTodayPeriodRecord(int userId) async {
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


  static Future<Map<String, dynamic>> getWeekPeriodRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/week');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
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

  static Future<Map<String, dynamic>> getMonthPeriodRecord(int userId) async {
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

  static Future<Map<String, dynamic>> getAllPeriodRecord(int userId) async {
    var url = Uri.parse('$_baseUrl/record/$userId/all');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print('getAllRecord');
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

  // 달력 선택 날짜에 대한 총 기록
  static Future<Map<String, dynamic>> getPeriodRecordSelectDay(int userId, String? date) async {
    int userId = 1;
    var url = Uri.parse('$_baseUrl/record/$userId/interval?createDate=$date');
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
