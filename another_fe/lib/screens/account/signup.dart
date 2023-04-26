import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'signup_userinfo.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
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
      style: TextStyle(color: SERVEONE_COLOR), // 원하는 입력 텍스트 색상으로 변경
    );
  }
}

class CustomInputForm extends StatefulWidget {
  const CustomInputForm({Key? key}) : super(key: key);
  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  bool isMaleSelected = true;

  // // 사용자가 입력한 값을 서버로 전송
  // void _submitForm() async {
  //   if(_formKey.currentState!.validate()){
  //     // 사용자가 입력한 값을 가져옴
  //     String email = emailController.text;
  //     String password = pwController.text;
  //     String nickname = nicknameController.text;
  //
  //     // HTTP POST 요청 보내기
  //     var response = await http.post(
  //         Uri.parse('https://example.com/register'), // 백엔드의 API 엔드포인트
  //         body: json.encode({
  //         'email': email,
  //         'password': password,
  //         'nickname': nickname,
  //         }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     // 응답 처리
  //     if (response.statusCode == 200) {
  //       // 성공적으로 응답이 왔을 경우
  //       print('회원가입 성공');
  //     } else {
  //       // 응답이 실패했을 경우
  //       print('회원가입 실패: ${response.body}');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            labelText: '이메일',
            validator: (value) {
              // 입력값이 없는 경우
              if (value == null || value.isEmpty) {
                return '이메일을 입력해주세요.';
              }
              // 입력한 경우 이메일 형식 검사
              String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // 이메일 정규식
              RegExp regex = RegExp(emailPattern);
              if (!regex.hasMatch(value)) {
                return '잘못된 이메일 형식입니다.';
              }
              // 잘 된 경우
              return null;
            },
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: pwController,
            labelText: '비밀번호',
            validator: (value) {
              if (value == null || value.isEmpty){
                return '비밀번호를 입력해주세요.';
              }
              // 비밀번호 길이 검사
              if (value.length < 8 || value.length > 16){
                return '8~16자 사이로 입력해주세요.';
              }
              // 특수문자 포함 여부 검사
              String pattern = r'^(?=.*?[!@#$%^&*(),.?":{}|<>])';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)){
                return '특수문자를 포함하여 입력해주세요.';
              }
              // 잘 된 경우
              return null;
            },
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: pwCheckController,
            labelText: '비밀번호 확인',
            validator: (value) {
              if (value != pwController.text){
                return '비밀번호를 다시 입력해주세요.';
              }
              // 잘 된 경우
              return null;
            },
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: nicknameController,
            labelText: '닉네임',
          ),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '성별',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: SERVEONE_COLOR,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ToggleButtons(
                    children: <Widget>[
                      Text('남'),
                      Text('여'),
                    ],

                    isSelected: [isMaleSelected, !isMaleSelected],
                    borderRadius: BorderRadius.circular(20), // 테두리 radius
                    color: MAIN_COLOR, // 선택되지 않은 버튼의 색
                    borderColor: MAIN_COLOR, // 선택되지 않은 버튼의 테두리 색
                    selectedColor: Colors.black87, // 선택된 버튼의 글자색
                    selectedBorderColor: MAIN_COLOR, // 선택된 버튼의 테두리 색
                    fillColor: MAIN_COLOR, // 선택된 버튼의 배경 색
                    onPressed: (int index) {
                      setState(() {
                        isMaleSelected = index == 0 ? true : false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 120),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: ElevatedButton(
              onPressed: () {
                // _submitForm();
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => SignupUserInfoPage()
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(MAIN_COLOR),
                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48.0))
              ),
              child: const Text('다음으로'),
            ),
          ),
        ],
      ),
    );
  }
}



class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/img/logo_small.png',
              height: 80.0,
            ),
            SizedBox(height: 16.0),
            Text(
              '함께하는 즐거운 러닝',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: SERVEONE_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              '몸을 움직이는 즐거움, 시작해볼까요?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: SERVEONE_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            CustomInputForm(),

            Spacer(),
          ],
        ),
      ),
    );
  }
}