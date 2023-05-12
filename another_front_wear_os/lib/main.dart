import 'dart:convert';

import 'package:another_front_wear_os/common/const/color.dart';
import 'package:another_front_wear_os/screen/watch_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  receiveDataFromPhone();
  runApp(
    MaterialApp(

      home: const HomeScreen(),
      theme: ThemeData(
          platform: TargetPlatform.android,
          scaffoldBackgroundColor: BACKGROUND_COLOR),

    ),
  );
}

void receiveDataFromPhone() {
  const messageChannel =
  const BasicMessageChannel<String>('com.example.another', StringCodec());
  print('안돼?');
  // 데이터 수신
  messageChannel.setMessageHandler(
        (String? data) async {
      if (data != null) {
        final decodedData = json.decode(data);
        print(decodedData);
        return decodedData;
      } else {
        return 'ddd';
      }
    },
  );
  print('안돼????');
}