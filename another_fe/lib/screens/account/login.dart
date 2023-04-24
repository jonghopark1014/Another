import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo_small.png', // 이미지 파일 경로
              height: 80.0, // 이미지 높이 설정
            ),
            Text(
              '함께하는 즐거운 러닝',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '몸을 움직이는 즐거움,시작해볼까요?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            TextField(
              decoration: InputDecoration(
                labelText: '아이디(이메일)',
                prefixIcon: Icon(Icons.email),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                prefixIcon: Icon(Icons.lock),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 페이지로 이동하는 로직 작성
                    // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.blue,
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
                      color: Colors.blue,
                    ),
                  ),
                ),

              ]
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 로그인 버튼 클릭 시 로그인 로직 작성
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 16.0),
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
    );
  }
}