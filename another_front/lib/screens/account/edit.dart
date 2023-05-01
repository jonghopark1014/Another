import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import '../../widgets/intro_header.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntroHeader(),
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/kazuha.jpg'),
            radius: 35,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  labelText: '닉네임',
                  hintText: '새로운 닉네임을 입력해주세요.',
                  hintStyle: TextStyle(color: SERVEONE_COLOR),
                  labelStyle: TextStyle(
                    color: SERVEONE_COLOR, // 원하는 라벨 텍스트 색상으로 변경
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                  ),
                ),
                maxLines: null,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: SERVEONE_COLOR,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}