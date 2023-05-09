import 'package:flutter/material.dart';

import '../constant/color.dart';

class GoBackAppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  String? runningId;
  String? title;
  GoBackAppBarStyle({
    this.runningId,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BACKGROUND_COLOR,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop(runningId ?? '');
        },
        icon: Icon(
          Icons.navigate_before,
          size: 40.0,
        ),
      ),
      title: Text(title ?? ''),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
