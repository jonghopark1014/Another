import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'signup.dart';
import '../../widgets/intro_header.dart';
import 'package:another/screens/account/api/login_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode idFocusNode = FocusNode(); // 아이디 입력 란이 포커스 되었는지 여부
  FocusNode pwFocusNode = FocusNode(); // 비밀번호 입력 란이 포커스 되었는지 여부
  bool isFocusId = false;
  bool isFocusPw = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idFocusNode.addListener(() {
      setState(() {
        isFocusId = true;
        isFocusPw = false;
      });
    });

    pwFocusNode.addListener(() {
      setState(() {
        isFocusId = false;
        isFocusPw = true;
      });
    });

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntroHeader(),
              SizedBox(height: 40.0),
              TextField(
                controller: emailController,
                focusNode: idFocusNode,
                decoration: InputDecoration(
                  labelText: '아이디(이메일)',
                  labelStyle: TextStyle(color: SERVEONE_COLOR),
                  prefixIcon: Opacity(
                    opacity: idFocusNode.hasFocus ? 1 : 0.5,
                    child: Icon(Icons.email, color: SERVEONE_COLOR),
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
                style: TextStyle(color: SERVEONE_COLOR),
              ),
              SizedBox(height: 16),
              TextField(
                controller: pwController,
                focusNode: pwFocusNode,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(color: SERVEONE_COLOR),
                  prefixIcon: Opacity(
                    opacity: pwFocusNode.hasFocus ? 1 : 0.5,
                    child: Icon(Icons.lock, color: SERVEONE_COLOR),
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
                style: TextStyle(color: SERVEONE_COLOR),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  onPressed: () {
                    // 회원가입 페이지로 이동하는 로직 작성
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: SERVEONE_COLOR,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 페이지로 이동하는 로직 작성
                    // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                      color: SERVEONE_COLOR,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 16),
              FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      // 로그인 버튼 클릭 시 로그인 로직 작성
                      await LoginApi.loginUser(
                        email: emailController.text,
                        password: pwController.text,
                        context: context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MAIN_COLOR,
                    ),
                    child: Text('로그인'),
                  )),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     // 카카오톡 로그인 버튼 클릭 시 로그인 로직 작성
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.yellow,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         'assets/kakao_logo.png', // 카카오톡 로고 이미지 경로
              //         height: 20.0,
              //       ),
              //       SizedBox(width: 8.0),
              //       Text('카카오톡으로 로그인'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
