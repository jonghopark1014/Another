import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'package:provider/provider.dart';
import 'package:another/main.dart';
import 'package:another/screens/account/edit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:another/screens/record/api/user_level_exp_api.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  int _userLevel = 0;
  double _userExp = 0;

  Future<void> _getUserLevelExp() async {
    Map<String, dynamic> userLevelExp = await UserLevelExpApi.getUserLevelExp();
    setState(() {
      _userLevel = userLevelExp['level'];
      _userExp = userLevelExp['exp'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLevelExp();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircularPercentIndicator(
              radius: 50,
              lineWidth: 10,
              percent: _userExp,
              header: Text("Icon header"),
              center: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${context.watch<UserInfo>().profileImg}'),
                radius: 45,
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
                      builder: (context) =>
                          ProfileEditPage(),
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
                'Lv.$_userLevel',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
