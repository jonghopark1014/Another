import 'package:another/constant/color.dart';
import 'package:flutter/material.dart';
import '../account/login.dart';
import '../account/signup_userinfo.dart';
import '../record/challenge.dart';

class RecordTab extends StatelessWidget {
  const RecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // 뒤로가기
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // 로그인 페이지로 이동하는 로직을 작성
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                // 로그인 페이지로 이동하는 로직을 작성
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupUserInfoPage()),
                );
              },
              child: Text('키 몸무게'),
            ),
            ElevatedButton(
              onPressed: () {
                // 로그인 페이지로 이동하는 로직을 작성
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengePage()),
                );
              },
              child: Text('챌린지'),
            ),
          ]
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/img/logo_small.png'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('안녕하세요 왕현석님!\n오늘도 함께 달려볼까요?', style: TextStyle(color: Colors.white)),
                Column(
                  children: [
                    Text('Lv.1', style: TextStyle(color: Colors.white)),
                    CircleAvatar(backgroundColor: Colors.grey, radius: 32)
                  ],
                )
              ],
            ),
            Row(
              children: [
                CategoryTitle(title: 'MY 챌린지'),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                  color: Colors.white,
                ),
              ]
            ),
            MyChallenge(), // 나의 챌린지
            CategoryTitle(title: '나의 활동 기록'),
            MyRecord()
          ]
        )
      )
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String title;
  const CategoryTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Text(
          '$title',
          style: TextStyle(
              color: SERVEONE_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 16
          )
      ),
    );
  }
}


class MyChallenge extends StatelessWidget {
  const MyChallenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: [
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                  SizedBox(width: 5),
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                  SizedBox(width: 5),
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                  SizedBox(width: 5),
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                  SizedBox(width: 5),
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                  SizedBox(width: 5),
                  Image.asset('assets/img/10min_gold.png', height: 64, width: 64),
                ]
            )
        )
    );
  }
}



class MyRecord extends StatefulWidget {
  const MyRecord({Key? key}) : super(key: key);

  @override
  State<MyRecord> createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  int _selectedIndex  = 0;
  List<String> buttonTexts = ['오늘', '주간', '월간', '전체'];

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                  color: _selectedIndex == 0 ? MAIN_COLOR : SERVEONE_COLOR, width: 2),
            ),
            onPressed: () => _updateIndex(0),
            child: Text('오늘', style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == 0 ? MAIN_COLOR : SERVEONE_COLOR,
            )),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                  color: _selectedIndex == 1 ? MAIN_COLOR : SERVEONE_COLOR, width: 2),
            ),
            onPressed: () => _updateIndex(1),
            child: Text('주간', style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == 1 ? MAIN_COLOR : SERVEONE_COLOR,
            )),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                  color: _selectedIndex == 2 ? MAIN_COLOR : SERVEONE_COLOR, width: 2),
            ),
            onPressed: () => _updateIndex(2),
            child: Text('월간', style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == 2 ? MAIN_COLOR : SERVEONE_COLOR,
            )),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                  color: _selectedIndex == 3 ? MAIN_COLOR : SERVEONE_COLOR, width: 2),
            ),
            onPressed: () => _updateIndex(3),
            child: Text('전체', style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == 3 ? MAIN_COLOR : SERVEONE_COLOR,
            )),
          ),
          OutlinedButton(
            onPressed: () => _updateIndex(4),
            child: Icon(Icons.calendar_today,
              color: _selectedIndex == 4 ? MAIN_COLOR : SERVEONE_COLOR,),
          ),
        ],
      );
    }
  }