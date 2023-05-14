import 'dart:io';
import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';
import '../../widgets/intro_header.dart';
import '../../main.dart';
import 'package:provider/provider.dart';
import './widgets/height_weight_picker.dart';
import './widgets/pass_button.dart';
import './widgets/complete_button.dart';
import './widgets/image_picker.dart';
import './api/userinfo_change_api.dart';
import 'package:another/screens/account/api/nickname_check_api.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final GlobalKey<ProfileImageState> _imagePickerKey =
      GlobalKey<ProfileImageState>();
  String _profileImgUrl = '';
  int _height = 0;
  int _weight = 0;
  String? errorText;
  File? profileImg;
  bool isNicknamePossible = true;
  bool isNicknameButtonActive = false;

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
    if (context.read<UserInfo>().nickname == _nicknameController.text) {
      isNicknamePossible = true;
      isNicknameButtonActive = false;
    }
    if (value == null || value.isEmpty) {
      isNicknamePossible = false;
      isNicknameButtonActive = false;
      return '닉네임을 입력해주세요.';
    }
    if (value.length < 2 || value.length > 8) {
      isNicknamePossible = false;
      isNicknameButtonActive = false;
      return '닉네임은 2~8자 이내로 입력해주세요.';
    }
    isNicknamePossible = false;
    isNicknameButtonActive = true;
    return null; // 유효성 검사 통과
  }

  void _onSavePressed() async {
    // 프로필 사진 수정한 경우
    if (isNicknamePossible == true) {
      if (profileImg != null) {
        await UserInfoChangeApi.profileImgChange(pickedFile: profileImg!);
      }
      // 유저 정보
      await UserInfoChangeApi.userInfoChange(
        height: _height,
        weight: _weight,
        nickname: _nicknameController.text,
      );
      Navigator.pop(context); // 뒤로가기
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보가 변경되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('닉네임 중복확인을 해주세요.')),
      );
    }
  }

  // 백엔드와 API 통신을 통해 사용 가능하다는 통신을 받으면 true로 변경 (nickname_check_api.dart)
  void nicknamePossible() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('사용 가능한 닉네임입니다')),
    );
    setState(() {
      isNicknamePossible = true;
    });
  }
  void nicknameDuplication(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('이미 사용중인 닉네임입니다')),
    );
    setState(() {
      isNicknamePossible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntroHeader(),
          SizedBox(height: 16),
          ProfileImage(
            profileImg: _profileImgUrl,
            key: _imagePickerKey,
            onFileChanged: (img) => setState(() => profileImg = img),
          ),
          Padding(
              padding: EdgeInsets.all(25),
              child: Stack(
                children: [
                  TextFormField(
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
                        color: SERVEONE_COLOR,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: SERVEONE_COLOR),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: SERVEONE_COLOR),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: SERVEONE_COLOR),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 8,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: SERVEONE_COLOR,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 10,
                    child: ElevatedButton(
                      onPressed:
                          isNicknameButtonActive && isNicknamePossible == false
                              ? () async {
                                  if (await doubleCheckApi.doubleCheck(
                                          nickname: _nicknameController.text,
                                          nicknamePossible: nicknamePossible,
                                      nicknameDuplication: nicknameDuplication) ==
                                      '사용 가능') {
                                    isNicknamePossible = true;
                                    print('사용 가능');
                                  } else {
                                    isNicknamePossible = false;
                                    print('사용 불가');
                                  }
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.white,
                      ),
                      child: Text('중복확인'),
                    ),
                  )
                ],
              )),
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
                  _onSavePressed();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
