// 러닝 세팅 세부
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../constant/color.dart';

class DetailSetting extends StatefulWidget {
  const DetailSetting({
    super.key,
  });
  @override
  State<DetailSetting> createState() => _DetailSettingState();
}

class _DetailSettingState extends State<DetailSetting> {
  int _distance = 0;
  int _min = 0;
  List<int> _interval = [0, 0];
  bool _isSet = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: BACKGROUND_COLOR,
      ),
      onPressed: getResult,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _distance != 0
                ? Row(
                    children: [
                      Text(
                        _distance.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: WHITE_COLOR,
                        ),
                      ),
                      Text(
                        ' km',
                        style: TextStyle(
                          fontSize: 18,
                          color: SERVETWO_COLOR,
                        ),
                      )
                    ],
                  )
                : Text(
                    '거리 목표를 설정해주세요!',
                    style: TextStyle(
                      fontSize: 18,
                      color: SERVETWO_COLOR,
                    ),
                  ),
            _min != 0
                ? Row(
                    children: [
                      Text(
                        _min.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: WHITE_COLOR,
                        ),
                      ),
                      Text(
                        ' min',
                        style: TextStyle(
                          fontSize: 18,
                          color: SERVETWO_COLOR,
                        ),
                      )
                    ],
                  )
                : Text(
                    '시간을 설정해주세요!',
                    style: TextStyle(
                      fontSize: 18,
                      color: SERVETWO_COLOR,
                    ),
                  ),
            _interval[0] != 0 && _interval[1] != 0
                ? Row(
                    children: [
                      // Icons.directions_run_rounded,
                      Text(
                        _interval[0].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: WHITE_COLOR,
                        ),
                      ),
                      Text(
                        ' min',
                        style: TextStyle(
                          fontSize: 18,
                          color: SERVETWO_COLOR,
                        ),
                      ),
                      // Icons.directions_walk_rounded,
                      Text(
                        _interval[1].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: WHITE_COLOR,
                        ),
                      ),
                      Text(
                        ' min',
                        style: TextStyle(
                          fontSize: 18,
                          color: SERVETWO_COLOR,
                        ),
                      )
                    ],
                  )
                : Text(
                    '러닝시간과 걷기시간을 설정해주세요!',
                    style: TextStyle(
                      fontSize: 18,
                      color: SERVETWO_COLOR,
                    ),
                  ),
          ]),
    );
  }
  // 모달창에서 정보받기
  void getResult() async {
    final result = await showModalBottomSheet(
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(40),
            child: DialData(),
          );
        });
    if (result != null) {
      print('$result======================================');
      setState(() {
        _distance = result[0];
        _min = result[1];
        _interval = result[2];
      });
    }
  }

  // 러닝 세부 설정 모달창
  Future<dynamic> detailSettingModal() {
    return showModalBottomSheet(
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(40),
            child: DialData(),
          );
        });
  }
}

class DialData extends StatefulWidget {
  const DialData({Key? key}) : super(key: key);

  @override
  State<DialData> createState() => _DialDataState();
}

class _DialDataState extends State<DialData> {
  int _distance = 0;
  int _min = 0;
  List<int> _interval = [0, 0];
  bool _isSet = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '거리(km)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          NumberPicker(
            minValue: 0,
            maxValue: 50,
            value: _distance,
            step: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: MAIN_COLOR,
              ),
            ),
            textStyle: TextStyle(
              color: Colors.grey.withOpacity(0.7),
            ),
            selectedTextStyle: TextStyle(
                color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
            itemHeight: 30,
            onChanged: (value) {
              setState(() {
                _distance = value;
                _isSet = true;
              });
            },
          ),
          Text('km',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '시간(분)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          NumberPicker(
            minValue: 0,
            maxValue: 50,
            value: _min,
            step: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: MAIN_COLOR),
            ),
            textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
            selectedTextStyle: TextStyle(
                color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
            itemHeight: 30,
            onChanged: (value) {
              setState(() {
                _min = value;
                _isSet = true;
              });
            },
          ),
          Text('분',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '인터벌',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            NumberPicker(
              minValue: 0,
              maxValue: 50,
              value: _interval[0],
              step: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: MAIN_COLOR),
              ),
              textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
              selectedTextStyle: TextStyle(
                  color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
              itemHeight: 30,
              itemWidth: 60,
              onChanged: (value) {
                setState(() {
                  _interval[0] = value;
                  _isSet = true;
                });
              },
            ),
            Text(
              '분',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            NumberPicker(
              minValue: 0,
              maxValue: 50,
              value: _interval[1],
              step: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: MAIN_COLOR),
              ),
              textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
              selectedTextStyle: TextStyle(
                  color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
              itemHeight: 30,
              itemWidth: 60,
              onChanged: (value) {
                setState(() {
                  _interval[1] = value;
                  _isSet = true;
                });
              },
            ),
            Text(
              '분',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(

            backgroundColor: MAIN_COLOR,
          ),
          onPressed: () {
            Navigator.pop(context, [_distance, _min, _interval]);
          },
          child: Text(
            '설정 완료',
            style: TextStyle(
              color: WHITE_COLOR,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
