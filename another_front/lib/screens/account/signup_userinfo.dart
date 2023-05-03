import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import '../../widgets/intro_header.dart';
import '../running/running.dart';
import './widgets/height_weight_picker.dart';
import './widgets/pass_button.dart';
import './widgets/complete_button.dart';

class SignupUserInfoPage extends StatefulWidget {
  const SignupUserInfoPage({Key? key}) : super(key: key);
  @override
  State<SignupUserInfoPage> createState() => _SignupUserInfoPageState();
}

class _SignupUserInfoPageState extends State<SignupUserInfoPage> {
  int _height = 170;
  int _weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IntroHeader(),
          Expanded(
              child: HeightWeightPicker(
            initialHeight: _height,
            initialWeight: _weight,
            onHeightChanged: (height) => setState(() => _height = height),
            onWeightChanged: (weight) => setState(() => _weight = weight),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PassButton(
                text: '건너뛰기',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => RunningTab(),
                      ),
                      (route) => false);
                },
              ),
              CompleteButton(
                  text: '회원가입',
                  onPressed: () {
                    // 가입완료 버튼 클릭 시 로직
                    // 키, 몸무게를 저장해서 데이터 보내주면 될 것 같음! (백으로 보내? store로 보내?)
                  })
            ],
          ),
        ],
      ),
    );
  }
}