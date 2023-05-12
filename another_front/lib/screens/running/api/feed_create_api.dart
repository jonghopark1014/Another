import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<bool> feedCreateApi(
    int userId, String runningId, List<Uint8List> feedPics) async {
  Uri url = Uri.parse('https://k8b308.p.ssafy.io/api/feed/create');
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll({"Content-Type": "multipart/form-data"});
  for (var i = 0; i < feedPics.length - 1; i++) {
    print(feedPics[i]);
    request.files.add(http.MultipartFile.fromBytes('feedPics', feedPics[i],
        contentType: MediaType('multipart', 'form-data'),
        filename: 'feedPics.jpg'));
  }
  var jsonRequest = jsonEncode({
    "userId": userId,
    "runningId": runningId,
  });
  request.files.add(http.MultipartFile.fromString(
    'addFeedRequestDto',
    jsonRequest,
    contentType: MediaType('application', 'json'),
  ));


  print('1');
  var response = await request.send();
  print('2');
  print(response.statusCode);
  print('3');
  if (response.statusCode == 200) {
    print('오운완 등록 성공');
    return true;
  } else {
    print('오운완 등록 실패');
    return false;
  }
}
