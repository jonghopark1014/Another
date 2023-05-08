import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  final double radius;
  final double profileFontSize;
  const ImageProfile({
    required this.radius,
    required this.profileFontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/kazuha.jpg'),
            radius: radius,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'nickname',
            style: MyTextStyle.sixteenTextStyle.copyWith(fontSize: profileFontSize),
          ),
        ],
      ),
    );
  }
}
