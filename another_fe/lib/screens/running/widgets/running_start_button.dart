
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class RunningStartButton extends StatelessWidget {
  const RunningStartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          color: MAIN_COLOR,
        ),
        child: Center(
            child: Icon(
              Icons.play_arrow,
              size: 80,
            )
        ),
      ),
    );
  }
}