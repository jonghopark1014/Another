import 'dart:io';
import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import '../../widgets/intro_header.dart';
import '../../main.dart';
import 'package:provider/provider.dart';
import './widgets/height_weight_picker.dart';
import './widgets/pass_button.dart';
import './widgets/complete_button.dart';
import './widgets/image_picker.dart';
import './api/userinfo_change_api.dart';
import './api/profileimg_change_api.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final GlobalKey<ProfileImageState> _imagePickerKey = GlobalKey<ProfileImageState>();
  String _profileImgUrl = '';
  int _height = 0;
  int _weight = 0;
  String? errorText;
  File? profileImg;

  @override
  void initState() {
    final userInfo = context.read<UserInfo>();
    _nicknameController.text = userInfo.nickname;
    _profileImgUrl = userInfo.profileImg;
    _height = userInfo.height;
    _weight = userInfo.weight;
    super.initState();
  }

  // 닉네임 유효성 검사 함수
  String? _validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.length < 2 || value.length > 8) {
      return '닉네임은 2~8자 이내로 입력해주세요.';
    }
    return null; // 유효성 검사 통과
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntroHeader(),
          SizedBox(height: 16),
          ProfileImage(profileImg: _profileImgUrl, key: _imagePickerKey),
          Padding(
            padding: EdgeInsets.all(25),
            child: TextFormField(
              controller: _nicknameController,
              validator: _validateNickname,
              onChanged: (value) {
                setState(() {
                  errorText = _validateNickname(value);
                });
              },
              decoration: InputDecoration(
                labelText: '닉네임',
                hintText: '새로운 닉네임을 입력해주세요.',
                hintStyle: TextStyle(color: SERVEONE_COLOR),
                errorText: errorText,
                labelStyle: TextStyle(
                  color: SERVEONE_COLOR, // 원하는 라벨 텍스트 색상으로 변경
                ),
                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                ),
              ),
              maxLines: 1,
              maxLength: 8,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: SERVEONE_COLOR,
              ),
            ),
          ),
          HeightWeightPicker(
            initialHeight: _height,
            initialWeight: _weight,
            onHeightChanged: (height) => setState(() => _height = height),
            onWeightChanged: (weight) => setState(() => _weight = weight),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PassButton(
                text: '취소',
                onPressed: () {
                  Navigator.pop(context); // 뒤로가기
                },
              ),
              CompleteButton(
                text: '수정 완료',
                onPressed: () {
                  UserInfoChangeApi.userInfoChange(
                      height: _height,
                      weight: _weight,
                      nickname: _nicknameController.text
                  );
                  // UserInfoChangeApi.profileImgChange(
                  //     pickedFile: _profileImgUrl
                  // );
                  print(_height);
                  print(_weight);
                  print(_nicknameController.text);
                  print(_profileImgUrl);
                  Navigator.pop(context); // 뒤로가기
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
