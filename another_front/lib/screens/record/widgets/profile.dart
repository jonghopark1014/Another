import 'package:flutter/material.dart';
import 'package:another/constant/const/color.dart';
import 'package:provider/provider.dart';
import 'package:another/main.dart';
import 'package:another/screens/account/edit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:another/screens/record/api/user_level_exp_api.dart';
import 'dart:io';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  int _userLevel = 0;
  double _userExp = 0;
  String? _userProfileImg;
  bool _isLoading = true;

  Future<void> _getUserLevelExp() async {
    int userId = Provider.of<UserInfo>(context, listen: false).userId;
    Map<String, dynamic> userLevelExp =
        await UserLevelExpApi.getUserLevelExp(userId);
    final userInfoProvider = Provider.of<UserInfo>(context, listen: false);
    userInfoProvider.userExp = userLevelExp['exp'];
    userInfoProvider.userLevel = userLevelExp['level'];
    userInfoProvider.profileImg = userLevelExp['profileImgUrl'];

    // UserInfo.updateProfileImg 에 _userProfileImg

    setState(() {
      _userLevel = userLevelExp['level'];
      _userExp = userLevelExp['exp'];
      _userProfileImg = userLevelExp['profileImgUrl'];
      _isLoading = false;
    });
  }

  void changeProfileImg(String? profileImg) {
    setState(() {
      _userProfileImg = profileImg!;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLevelExp();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Stack(
                children: [
                  CircularPercentIndicator(
                    header: SizedBox(height: 20),
                    radius: 50,
                    lineWidth: 10,
                    percent: _userExp,
                    center: Container(
                      width: 90,
                      height: 90,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_userProfileImg!),
                        radius: 45,
                      ),
                    ),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileEditPage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: MAIN_COLOR,
                        radius: 15,
                        child: Icon(
                          Icons.edit,
                          color: WHITE_COLOR,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 0,
                    child: Text(
                      'Lv.${_userLevel}',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          );
  }
}
