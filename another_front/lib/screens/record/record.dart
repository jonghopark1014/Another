import 'package:another/constant/color.dart';
import 'package:another/screens/account/edit.dart';
import 'package:another/screens/record/widgets/period_total_record.dart';
import 'package:flutter/material.dart';
import '../account/login.dart';
import '../account/signup_userinfo.dart';
import '../record/challenge.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'widgets/category_title.dart';
import './widgets/record_running_history.dart';
import '../../main.dart';
import 'package:provider/provider.dart';

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
                MaterialPageRoute(builder: (context) => ChallengePage()),
              );
            },
            child: Text('챌린지'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/logo_small.png'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '안녕하세요 ${context.watch<UserInfo>().nickname}님!\n오늘도 함께 달려볼까요?',
                    style: TextStyle(color: Colors.white),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircularPercentIndicator(
                            radius: 50,
                            lineWidth: 10,
                            percent: 0.6,
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
                              'Lv.1',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  CategoryTitle(title: 'MY 챌린지'),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChallengePage()),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    color: Colors.white,
                    iconSize: 14,
                  )
                ],
              ),
              MyChallenge(), // 나의 챌린지
              CategoryTitle(title: '나의 활동 기록'),
              MyRecord(),
            ],
          ),
        ),
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
          ],
        ),
      ),
    );
  }
}

class MyRecord extends StatefulWidget {
  const MyRecord({Key? key}) : super(key: key);

  @override
  State<MyRecord> createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  int _selectedIndex = 0;
  bool _isCalendarOpen = false;

  void _updateContent(int index, bool isCalendarOpen) {
    setState(() {
      _selectedIndex = index;
      _isCalendarOpen = isCalendarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                side: BorderSide(
                    color: _selectedIndex == 0 ? MAIN_COLOR : SERVEONE_COLOR,
                    width: 2),
              ),
              onPressed: () => _updateContent(0, false),
              child: Text('오늘',
                  style: TextStyle(
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
                    color: _selectedIndex == 1 ? MAIN_COLOR : SERVEONE_COLOR,
                    width: 2),
              ),
              onPressed: () => _updateContent(1, false),
              child: Text('이번 주',
                  style: TextStyle(
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
                    color: _selectedIndex == 2 ? MAIN_COLOR : SERVEONE_COLOR,
                    width: 2),
              ),
              onPressed: () => _updateContent(2, false),
              child: Text('이번 달',
                  style: TextStyle(
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
                    color: _selectedIndex == 3 ? MAIN_COLOR : SERVEONE_COLOR,
                    width: 2),
              ),
              onPressed: () => _updateContent(3, false),
              child: Text('전체',
                  style: TextStyle(
                    fontSize: 12,
                    color: _selectedIndex == 3 ? MAIN_COLOR : SERVEONE_COLOR,
                  )),
            ),
            OutlinedButton(
                onPressed: () {
                  if (_selectedIndex != 4) {
                    return _updateContent(4, true);
                  } else if (_selectedIndex == 4 && _isCalendarOpen == true) {
                    return _updateContent(4, false);
                  } else if (_selectedIndex == 4 && _isCalendarOpen == false) {
                    return _updateContent(4, true);
                  }
                },
                child: Icon(
                  Icons.calendar_today,
                  color: _isCalendarOpen == true ? MAIN_COLOR : SERVEONE_COLOR,
                )),
          ],
        ),
        MyRecordContents(
            selectedIndex: _selectedIndex, isCalendarOpen: _isCalendarOpen)
      ],
    );
  }
}

class MyRecordContents extends StatefulWidget {
  final int selectedIndex;
  final bool isCalendarOpen;

  const MyRecordContents(
      {Key? key, required this.selectedIndex, required this.isCalendarOpen})
      : super(key: key);

  @override
  State<MyRecordContents> createState() => _MyRecordContentsState();
}

class _MyRecordContentsState extends State<MyRecordContents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.isCalendarOpen == true
            ? TableCalendarScreen()
            : Text('달력 없음}', style: TextStyle(color: Colors.white)),

        PeriodTotalRecord(selectedIndex: widget.selectedIndex), // 조회 기간 총 기록

// 나중에 Pageview 써봐라
        widget.selectedIndex == 0
            ? Column(
                children: [
                  TodayRecord(),
                ],
              )
            : widget.selectedIndex == 1
                ? Column(
                    children: [
                      ThisWeekRecord(),
                    ],
                  )
                : widget.selectedIndex == 2
                    ? Column(
                        children: [
                          ThisMonthRecord(),
                        ],
                      )
                    : widget.selectedIndex == 3
                        ? Column(
                            children: [
                              AllRecord(),
                            ],
                          )
                        : widget.selectedIndex == 4
                            ? Text('인덱스 4임',
                                style: TextStyle(color: Colors.white))
                            : Text('잘못된 인덱스')
      ],
    );
  }
}

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);
  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final forDate = Provider.of<ForDate>(context);

    DateTime selectDay = DateTime(
      forDate.forFocus.year,
      forDate.forFocus.month,
      forDate.forFocus.day,
    );

    selectedDay = selectDay;
    focusedDay = forDate.forFocus;

    return TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2021),
        lastDay: DateTime.utc(2025),
        focusedDay: focusedDay,
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.white),
          headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leftChevronIcon:
              Icon(Icons.arrow_left, size: 40.0, color: Colors.white),
          rightChevronIcon:
              Icon(Icons.arrow_right, size: 40.0, color: Colors.white),
        ),
        calendarStyle: CalendarStyle(
            canMarkersOverflow: false,
            // marker 여러개 일 때 cell 영역을 벗어날지 여부
            markersAutoAligned: true,
            // 자동정렬 여부
            markerSize: 10,
            // 마커 크기 조절
            markerSizeScale: 10,
            // 마커 크기 비율 조절
            markersAnchor: 0.7,
            // 마커 기준점 조절
            markerMargin: EdgeInsets.symmetric(horizontal: 0.3),
            // 마커 margin 조절
            markersAlignment: Alignment.bottomCenter,
            // 마커 위치 조절
            markersMaxCount: 3,
            // 한줄에 보여지는 마커 개수
            markersOffset: PositionedOffset(),
            // 마커 모양 조절
            markerDecoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(
              color: Colors.white,
            ),
            isTodayHighlighted: true,
            // today 표시 여부
            // today 글자 스타일
            todayTextStyle: TextStyle(
              color: MAIN_COLOR,
            ),
            // today 모양 스타일
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MAIN_COLOR,
              ),
            ),
            // selectedDay 글자 조정
            selectedTextStyle: const TextStyle(color: Colors.white),
            // selectedDay 모양 조정
            selectedDecoration: const BoxDecoration(
              color: MAIN_COLOR,
              shape: BoxShape.circle,
            ),
            // disabledDay 글자 조정
            disabledTextStyle:
                TextStyle(color: SERVEONE_COLOR.withOpacity(0.2)),
            weekendTextStyle: TextStyle(color: Colors.white)),
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          // 선택된 날짜의 상태를 갱신
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
            forDate.changeValue(selectedDay);
          });

          // 현재 선택된 달력의 월과 다른 경우, 해당 달력으로 이동
          if (selectedDay.month != focusedDay.month) {
            setState(() {
              focusedDay = DateTime(selectedDay.year, selectedDay.month, 1);
            });
          }
        },
        selectedDayPredicate: (DateTime day) {
          // selectedDay 와 동일한 날짜의 모양을 바꿔줌
          return isSameDay(selectedDay, day);
        });
  }
}
