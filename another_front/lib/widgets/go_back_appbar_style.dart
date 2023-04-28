import 'package:flutter/material.dart';

import '../constant/color.dart';

class GoBackAppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  const GoBackAppBarStyle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BACKGROUND_COLOR,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.navigate_before,
          size: 40.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}