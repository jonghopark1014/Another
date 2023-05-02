import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import '../../widgets/intro_header.dart';
import '../../main.dart';
import 'package:provider/provider.dart';
import './widgets/height_weight_picker.dart';
import './widgets/pass_button.dart';
import './widgets/complete_button.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _profileImgController = TextEditingController();
  int _height = 0;
  int _weight = 0;

  @override
  void initState() {
    final userInfo = context.read<UserInfo>();
    _nicknameController.text = userInfo.nickname;
    _profileImgController.text = userInfo.profileImg;
    _height = userInfo.height;
    _weight = userInfo.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntroHeader(),
          SizedBox(height: 16),
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/kazuha.jpg'),
            radius: 50,
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
                    borderSide: BorderSide(
                        color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
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
          HeightWeightPicker(
            initialHeight: _height,
            initialWeight: _weight,
            onHeightChanged: (height) => setState(() => _height = height),
            onWeightChanged: (weight) => setState(() => _weight = weight),
          ),
          Text(
            'edit페이지 height는 ${_height} weight는 ${_weight}',
            style: TextStyle(color: WHITE_COLOR),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PassButton(text: '취소', onPressed:() {}),
              CompleteButton(text: '수정 완료', onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
