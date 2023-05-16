import 'package:another/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';
import '../../widgets/intro_header.dart';
import '../running/running.dart';
import './widgets/height_weight_picker.dart';
import './widgets/pass_button.dart';
import './widgets/complete_button.dart';
import 'package:another/screens/account/api/signup_api.dart';

class SignupUserInfoPage extends StatefulWidget {
  final String email;
  final String password;
  final String nickname;
  final bool isMale;

  const SignupUserInfoPage({
    Key? key,
    required this.email,
    required this.password,
    required this.nickname,
    required this.isMale,
  }) : super(key: key);

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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PassButton(
                text: '건너뛰기',
                onPressed: () {
                  SignupApi.joinUser(
                    context,
                    email: widget.email,
                    password: widget.password,
                    nickname: widget.nickname,
                    isMale: widget.isMale,
                    height: 170,
                    weight: 60,
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              CompleteButton(
                text: '회원가입',
                onPressed: () async {
                  // 가입완료 버튼 클릭 시 로직
                  // 키, 몸무게를 저장해서 데이터 보내주면 될 것 같음! (백으로 보내? store로 보내?)
                  bool signup = await SignupApi.joinUser(
                    context,
                    email: widget.email,
                    password: widget.password,
                    nickname: widget.nickname,
                    isMale: widget.isMale,
                    height: _height,
                    weight: _weight,
                  );
                  if (signup) {
                    // 회원가입 성공한 경우
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('회원가입이 완료되었습니다.')),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                          (route) => false,
                    );
                  } else {
                    // 회원가입 실패한 경우
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('회원가입에 실패했습니다.')),
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
