import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:another/widgets/target_box.dart';
import '../../../constant/color.dart';

class MyRecordResult extends StatelessWidget {
  const MyRecordResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);
    print(now);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 16.0,
      ),
      child: Container(
        height: 180.0,
        decoration: BoxDecoration(
          color: BLACK_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(color: MAIN_COLOR, fontSize: 20.0),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '25,789',
                            style: TextStyle(color: MAIN_COLOR, fontSize: 40.0),
                          ),
                          Text('걸음',
                              style:
                                  TextStyle(color: MAIN_COLOR, fontSize: 20.0))
                        ],
                      ),
                    ],
                  ),
                  ImageProfileSetting()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TargetBox(
                      name: 'km',
                      textColor: WHITE_COLOR,
                      recordColor: SERVEONE_COLOR,
                    ),
                    TargetBox(
                      name: 'kcal',
                      textColor: WHITE_COLOR,
                      recordColor: SERVEONE_COLOR,
                    ),
                    TargetBox(
                      name: '시간',
                      textColor: WHITE_COLOR,
                      recordColor: SERVEONE_COLOR,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget ImageProfileSetting() {
  return Center(
    child: Stack(
      children: <Widget>[
        CircleAvatar(

          backgroundImage: AssetImage('assets/img/kazuha.jpg'),
          radius: 45,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: MAIN_COLOR,
              radius: 15,
              child: Icon(
                Icons.edit,
                color: WHITE_COLOR,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
