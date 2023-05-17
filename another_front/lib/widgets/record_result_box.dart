import 'package:another/constant/const/text_style.dart';
import 'package:flutter/material.dart';

class RecordResultBox extends StatelessWidget {
  final String name;
  final String data;
  final Color textColor;
  final Color recordColor;

  const RecordResultBox({
    required this.data,
    required this.name,
    required this.textColor,
    required this.recordColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width < 160.0 ? width : 160,
        height: 100.0,
        child: Column(
          children: [
            Text(
              name,
              style: MyTextStyle.twentyTextStyle.copyWith(color: recordColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Text(
                data,
                style: MyTextStyle.thirtyTextStyle.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
