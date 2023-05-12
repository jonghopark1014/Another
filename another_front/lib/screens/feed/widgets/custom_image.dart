import 'dart:io';

import 'package:another/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({Key? key}) : super(key: key);
  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late List<XFile?> images = [];

  void onTapPressed() async {
    print('사진 아이콘');
    final image = await ImagePicker().pickMultiImage(
      imageQuality: 100,
    );
    print('선택완료');
    print(image);
    setState(() {
      images = image;
    });
  }

  // 사진 찍기
  void onPhotoPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      setState(() {
        images.add(image);
      });
    }
  }

  @override
  void initState() {
    onTapPressed();
    // TODO: implement initState
    super.initState();
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
      body: Column(
        children: [
          _IconsTap(
            onTapPressed: onTapPressed,
            onPhotoPressed: onPhotoPressed,
          ),
          images.isNotEmpty
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),

                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      // Why network for web?
                      // See https://pub.dev/packages/image_picker_for_web#limitations-on-the-web-platform
                      return Semantics(
                        label: 'image_picker_example_picked_image',
                        child: Image.file(
                          File(images[index]!.path),
                          errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) =>
                              const Center(
                                  child:
                                      Text('This image type is not supported')),
                        ),
                      );
                    },
                    itemCount: images.length,
                  ),
                )
              : Text(
                  '안뜨노',
                  style: TextStyle(color: Colors.white),
                ),
        ],
      ),
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
