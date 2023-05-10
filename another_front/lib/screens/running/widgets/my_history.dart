// 내기록들 띄우는 위젯
import 'package:another/constant/color.dart';
import 'package:another/main.dart';
import 'package:another/screens/running/api/my_history_api.dart';
import 'package:another/widgets/target.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  late ChallengeData challengeData;
  bool dataGet = false;
  List<dynamic> historyList = [];
  late final _userInfo;
  late final _userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userInfo = Provider.of<UserInfo>(context, listen: false);
    // _userId = _userInfo.userId;
    _userId = 1; // 더미========================================
    challengeData = Provider.of<ChallengeData>(context, listen: false);
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    if (dataGet) {
      return ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          return ElevatedButton(
            // 눌렀을 때 하이라이트
            onPressed: () => {
              challengeData.setValues(
                historyList[index]['runningId'].toString(),
                historyList[index]['runningDistance'].toString(),
                historyList[index]['runningTime'].toString(),
                historyList[index]['userCalories'].toString(),
                historyList[index]['userPace'].toString(),
              )
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(2),
              primary: BACKGROUND_COLOR,
            ),
            child: Target(
              targetname: historyList[index]['createDate'],
              runningDistance: historyList[index]['runningDistance'].toString(),
              userCalorie: historyList[index]['userCalories'].toString(),
              runningTime: historyList[index]['runningTime'].toString(),
              userPace: historyList[index]['userPace'],
            ),
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  void getHistory() async {
    var myHistory = await myHistoryApi(_userId);
    setState(() {
      historyList = myHistory;
      dataGet = true;
    });
  }
}
