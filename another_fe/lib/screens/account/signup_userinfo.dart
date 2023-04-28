import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../widgets/intro_header.dart';
import '../running/running.dart';

class SignupUserInfoPage extends StatefulWidget {
  const SignupUserInfoPage({Key? key}) : super(key: key);
  @override
  State<SignupUserInfoPage> createState() => _SignupUserInfoPageState();
}

class _SignupUserInfoPageState extends State<SignupUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        IntroHeader(),
        Expanded(
            child: HeightWeightPicker(
          initialHeight: 170,
          initialWeight: 60,
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [PassButton(), CompleteButton()],
        ),
      ]),
    );
  }
}

class HeightWeightPicker extends StatefulWidget {
  final int initialHeight;
  final int initialWeight;

  HeightWeightPicker(
      {required this.initialHeight, required this.initialWeight});

  @override
  _HeightWeightPickerState createState() => _HeightWeightPickerState();
}

class _HeightWeightPickerState extends State<HeightWeightPicker> {
  late int _heightValue;
  late int _weightValue;

  @override
  void initState() {
    super.initState();
    _heightValue = widget.initialHeight;
    _weightValue = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('　키　',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              NumberPicker(
                value: _heightValue,
                minValue: 100,
                maxValue: 200,
                step: 1,
                haptics: true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: MAIN_COLOR),
                ),
                textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                selectedTextStyle: TextStyle(
                    color: MAIN_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                itemHeight: 30,
                onChanged: (value) => setState(() => _heightValue = value),
              ),
              Text('cm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('몸무게',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              NumberPicker(
                value: _weightValue,
                minValue: 30,
                maxValue: 150,
                step: 1,
                haptics: true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: MAIN_COLOR),
                ),
                textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                selectedTextStyle: TextStyle(
                  color: MAIN_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                itemHeight: 30,
                onChanged: (value) => setState(() => _weightValue = value),
              ),
              Text('kg',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 32),
        Text('키 : $_heightValue, 몸무게 : $_weightValue',
            style: TextStyle(color: Colors.white))
      ],
    );
  }
}

class PassButton extends StatelessWidget {
  const PassButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 40,
        margin: EdgeInsets.only(bottom: 20),
        child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => RunningTab(),
                  ),
                  (route) => false);
            },
            style: ButtonStyle(
              side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
                  return BorderSide(color: MAIN_COLOR, width: 2);
                },
              ),
            ),
            child: Text('건너뛰기', style: TextStyle(color: MAIN_COLOR))));
  }
}

class CompleteButton extends StatelessWidget {
  const CompleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      margin: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          // 가입완료 버튼 클릭 시 로직
          // 키, 몸무게를 저장해서 데이터 보내주면 될 것 같음! (백으로 보내? store로 보내?)
        },
        child: Text('가입완료'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(MAIN_COLOR),
        ),
      ),
    );
  }
}
