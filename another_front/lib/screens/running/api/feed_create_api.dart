import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<bool> feedCreateApi(int userId, String runningId, List<Uint8List> feedPics) async {
  Uri url = Uri.parse('https://k8b308.p.ssafy.io/api/feed/create');
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll({"Content-Type" : "application/json"});
  for (var i = 0; i < feedPics.length; i++) {
    print(feedPics[i]);
    request.files.add(http.MultipartFile.fromBytes('feedPics', feedPics[i], filename: 'feedPics.jpg'));
  }
  request.fields['addFeedRequestDto'] = {
    "userId": userId,
    "runningId": runningId,
  }.toString();
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