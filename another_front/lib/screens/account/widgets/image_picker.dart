import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:another/constant/color.dart';

class ProfileImage extends StatefulWidget {
  final String profileImg;

  const ProfileImage({Key? key, required this.profileImg}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late var _profileImg;
  File? _pickedFile; // 사진 선택한 파일

  @override
  void initState() {
    super.initState();
    _profileImg = Image.network(widget.profileImg);
  }

  // 카메라로 사진 찍기
  void _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
      });
    } else {
      print('이미지 선택안함');
    }
  }

  // 갤러리에서 사진 선택
  void _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
        print(_pickedFile);
      });
    } else {
      print('이미지 선택 안 함');
    }
  }


  // 바텀 시트에서 선택지를 보여줍니다.
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft:  Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft:  Radius.circular(20)),
              color: SERVEONE_COLOR,
          ),
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  "사진 촬영",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getCameraImage();
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text(
                  "갤러리에서 선택",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getPhotoLibraryImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundImage: _pickedFile == null
                  ? _profileImg.image
                  : FileImage(File(_pickedFile!.path)),
              radius: 50,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              width: 100,
              height: 100,
            ),
            Positioned(
                bottom: 22,
                right: 22,
                child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  color: Colors.black,
                  iconSize: 40,
                  onPressed: () => _showPicker(context),
                )),
          ],
        )
      ],
    );
  }
}
