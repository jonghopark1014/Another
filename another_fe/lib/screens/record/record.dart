import 'package:flutter/material.dart';
import '../account/login.dart';
import '../account/signup_userinfo.dart';
import '../record/challenge.dart';

class RecordTab extends StatelessWidget {
  const RecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); //뒤로가기
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Records Tab'),
              ElevatedButton(
                onPressed: () {
                  // 로그인 페이지로 이동하는 로직을 작성
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('로그인 페이지'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 로그인 페이지로 이동하는 로직을 작성
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupUserInfoPage()),
                  );
                },
                child: Text('키 몸무게 페이지'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 로그인 페이지로 이동하는 로직을 작성
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengePage()),
                  );
                },
                child: Text('챌린지 페이지'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}