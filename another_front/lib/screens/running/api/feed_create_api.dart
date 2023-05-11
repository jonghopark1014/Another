import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;


const String _baseUrl = 'https://k8b308.p.ssafy.io';

Future<dynamic> feedCreateApi(String runningId, List<Uint8List> feedPics) async {
  var url = Uri.parse('/api/feed/create');
  var response = await http.post(url);

  return jsonDecode(response.body)["data"]["content"];
}