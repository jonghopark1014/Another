import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class RunningSettingButton extends StatelessWidget {
  const RunningSettingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.0,
      height: 70.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: SERVEONE_COLOR,
        ),
        child: Center(
          child: Icon(
            Icons.settings,
            size: 45,
          ),
        ),
      ),
    );
  }
}