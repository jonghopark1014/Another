import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';

class SignupUserInfoPage extends StatefulWidget {
  const SignupUserInfoPage({Key? key}) : super(key: key);

  @override
  State<SignupUserInfoPage> createState() => _SignupUserInfoPageState();
}

class _SignupUserInfoPageState extends State<SignupUserInfoPage> {
  double _height = 170.0;
  double _weight = 60.0;

  void _incrementHeight() {
    setState(() {
      _height -= 1;
    });
  }

  void _decrementHeight() {
    setState(() {
      _height += 1;
    });
  }

  void _incrementWeight() {
    setState(() {
      _weight += 1;
    });
  }

  void _decrementWeight() {
    setState(() {
      _weight -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('키와 몸무게 설정'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '키',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _height += details.delta.dy * -0.1; // 위로 드래그하면 작아지도록 수정
                });
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.blueGrey,
                ),
                child: Center(
                  child: Text(
                    '${_height.toInt()} cm', // 값에 단위 추가
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              '몸무게',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _weight += details.delta.dy * 0.1; // 아래로 드래그하면 커지도록 수정
                });
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.blueGrey,
                ),
                child: Center(
                  child: Text(
                    '${_weight.toInt()} kg', // 값에 단위 추가
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}