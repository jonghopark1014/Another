import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

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
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(
                  color: SERVEONE_COLOR, // SERVEONE_COLOR 적용
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

              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(
                  color: SERVEONE_COLOR, // SERVEONE_COLOR 적용
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
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                labelStyle: TextStyle(
                  color: SERVEONE_COLOR, // SERVEONE_COLOR 적용
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
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '닉네임',
                labelStyle: TextStyle(
                  color: SERVEONE_COLOR, // SERVEONE_COLOR 적용
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
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text(
                  '성별',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16.0),
                Row(
                  children: <Widget>[
                    ChoiceChip(
                      label: Text('남'),
                      selected: true,
                      onSelected: (bool selected) {},
                    ),
                    SizedBox(width: 8.0),
                    ChoiceChip(
                      label: Text('여'),
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // 다음 버튼이 눌렸을 때의 동작
              },
              child: Text('다음으로'),
            ),
          ],
        ),
      ),
    );
  }
}

