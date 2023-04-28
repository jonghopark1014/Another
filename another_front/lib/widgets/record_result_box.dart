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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 160.0,
        height: 100.0,
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: recordColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Text(
                data,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
