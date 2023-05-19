

import 'package:flutter/cupertino.dart';

import '../../../constant/const/color.dart';

class RunningMyHIstoryButton extends StatelessWidget {
  const RunningMyHIstoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: SERVEONE_COLOR,
        ),
        child: Center(
          child: Text(
            "내 기록",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}