import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class saveRunningTime {

  static const _baseUrl = "https://k8b308.p.ssafy.io";

  static Future<void> sendTopic({
    required String runningId,
    required int userId
  })
  async {
    Uri url = Uri.parse('');
    // if (userId % 3 == 0) {
    //   url = Uri.parse('$_baseUrl/topics/endZero');
    // }
    // else if (userId % 3 == 1) {
    //   url = Uri.parse('$_baseUrl/topics/endOne');
    // }
    // else {
    //   url = Uri.parse('$_baseUrl/topics/endTwo');
    // }
    url = Uri.parse('$_baseUrl/topics/endZero');
    Map<String, dynamic> runData = {
      'runningId': runningId,
    };

    Map<String, dynamic> requestBody = {
      'records': [
        {'value' : runData}
      ]
    };
    // 요청
    var response = await http.post(
        url,
        headers: {"Content-Type": "application/vnd.kafka.json.v2+json"},
        body: json.encode(requestBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('topic 전송 성공');
    } else {
      print('topic 전송 실패');
    }
  }

  static Future<void> saveRunData({
    required int userId,
    required String runningId,
    required String runningTime,
    required double runningDistance,
    required int userCalories,
    required String userPace,
    required Uint8List? runningPic,
    String? hostRunningId,
  })
  async {
    print("===================run/stop===============");
    var url = Uri.parse('$_baseUrl/api/run/stop');

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({"Content-Type" : "multipart/form-data"});

    request.files.add(http.MultipartFile.fromBytes('runningPic', runningPic as List<int>, filename: 'runPic.jpg'));

    List<String> runTime = runningTime.split(':');

    var runningSec = int.parse(runTime[0]) * 3600 + int.parse(runTime[1]) * 60 + int.parse(runTime[2]);

    double pace = 0;
    for (int i = 0; i < userPace.length; i++) {
      if (userPace[i] == "'") {
        pace += double.parse(userPace.substring(0, i)) * 60;
        print(userPace.substring(i + 1, userPace.length - 1));
        pace += double.parse(userPace.substring(i + 1, userPace.length - 2));
        break;
      }
    }

    request.fields['userId'] = userId.toString();
    request.fields['runningId'] = runningId;
    request.fields['runningTime'] = runningSec.toString();
    request.fields['runningDistance'] = double.parse(runningDistance.toStringAsFixed(3)).toString();
    request.fields['userCalories'] = userCalories.toString();
    request.fields['userPace'] = pace.toString();
    request.fields['createDate'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (hostRunningId != null) {
      request.fields['hostRunningId'] = hostRunningId.toString();
    }
    print(request.fields);

    //
    // Map<String, dynamic> runData = {
    //   'userId' : userId,
    //   'runningId': runningId,
    //   'runningTime': runningTime,
    //   'runningDistance': runningDistance,
    //   'kcal': userCalories,
    //   'speed': userPace,
    // };

    print("===================run/stop4===============");
    // 요청
    // var response = await http.post(
    //     url,
    //     headers: {"Content-Type": "application/json"},
    //     body: json.encode(runData));
    var response = await request.send();
    print("===================run/stop2===============");
    print(response.statusCode);
    // print();
    print("===================run/stop3===============");
    if (response.statusCode == 200) {
      print('topic 전송 성공');
    } else {
      print('topic 전송 실패');
    }
  }
}
