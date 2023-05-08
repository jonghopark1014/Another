import 'package:another/constant/text_style.dart';
import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  final double radius;
  final double profileFontSize;
  final String nickname;
  final String profilePic;

  const ImageProfile({
    required this.profilePic,
    required this.radius,
    required this.profileFontSize,
    required this.nickname,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
            radius: radius,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            nickname,
            style: MyTextStyle.sixteenTextStyle.copyWith(fontSize: profileFontSize),
          ),
        ],
      ),
    );
  }
}
