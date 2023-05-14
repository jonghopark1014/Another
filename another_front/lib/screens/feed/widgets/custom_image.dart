import 'dart:io';

import 'package:another/constant/const/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({Key? key}) : super(key: key);

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  XFile? image;
  final _picker = ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  void onTapPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        this.image = image;
      });
    }
  }

  // 사진 찍기
  void onPhotoPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      setState(() {
        this.image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        title: Text(
          '첨부',
          style: TextStyle(
            color: MAIN_COLOR,
          ),
        ),
      ),
      body: Column(children: [
        _IconsTap(
          onTapPressed: onTapPressed,
          onPhotoPressed: onPhotoPressed,
        ),
      ]),
    );
  }
}

// 아이콘 두개
class _IconsTap extends StatelessWidget {
  final VoidCallback onPhotoPressed;
  final VoidCallback onTapPressed;

  const _IconsTap({
    required this.onTapPressed,
    required this.onPhotoPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            onTapPressed;
          },
          icon: Icon(
            Icons.photo_library,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        IconButton(
          onPressed: () {
            onPhotoPressed;
          },
          icon: Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ],
    );
  }
}
