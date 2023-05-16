import 'package:another/constant/const/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/record/api/challenge_api.dart';
import 'package:another/screens/record/api/history_record_api.dart';
import 'package:another/screens/record/widgets/period_total_record.dart';
import 'package:flutter/material.dart';
import '../account/login.dart';
import '../account/signup_userinfo.dart';
import '../record/challenge.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'widgets/category_title.dart';
import 'package:another/main.dart';
import 'package:provider/provider.dart';
import 'package:another/screens/record/widgets/profile.dart';
import 'package:another/screens/record/widgets/record_chart.dart';
import 'package:another/screens/record/api/period_total_record_api.dart';
import 'package:another/screens/record/widgets/target_record_item.dart';
import 'package:another/screens/record/widgets/record_chart.dart';
import 'dart:convert';
import 'dart:collection';

class RecordTab extends StatelessWidget {
  const RecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1C1A1E),
                        Color(0xFF3D2F4A),
                      ],
                      stops: [
                        MediaQuery.of(context).size.height * 0,
                        MediaQuery.of(context).size.height * 0.3,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/img/logo_small.png',
                            width: 120, height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                '안녕하세요 ${context.watch<UserInfo>().nickname}님!\n오늘도 함께 달려볼까요?',
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Flexible(
                              child: ProfileWidget(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    CategoryTitle(title: 'MY 챌린지'),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChallengePage()),
                                        );
                                      },
                                      icon: Icon(
                                          Icons.arrow_forward_ios_outlined),
                                      color: Colors.white,
                                      iconSize: 14,
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                MyChallenge(), // 나의 챌린지
                                CategoryTitle(title: '나의 활동 기록'),
                                SizedBox(height: 5),
                                MyRecord(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyChallenge extends StatefulWidget {
  const MyChallenge({Key? key}) : super(key: key);

  @override
  State<MyChallenge> createState() => _MyChallengeState();
}

class _MyChallengeState extends State<MyChallenge> {
  List<dynamic> _successChallenge = [];
  bool _isLoading = true;

  Future<void> getSuccessChallenge() async {
    int userId = Provider.of<UserInfo>(context, listen: false).userId;
    List<dynamic> data = await GetChallenge.successChallengeList(userId);
    setState(() {
      _successChallenge = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSuccessChallenge();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Row(
                children:
                    // if API가 0개이면 띄워줄거 작성해야함
                    _successChallenge.isEmpty
                        ? [
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              alignment: Alignment.center,
                              // color: WHITE_COLOR,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '아직 획득한 뱃지가 없어요.',
                                    style: TextStyle(
                                        color: WHITE_COLOR.withOpacity(0.85),
                                        fontSize: 14),
                                  ),
                                  Text(
                                    '런닝을 뛰어 뱃지를 얻어보세요.',
                                    style: TextStyle(
                                        color: WHITE_COLOR.withOpacity(0.85),
                                        fontSize: 14),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (_) => HomeScreen(),
                                          ),
                                          (route) => false);
                                    },
                                    child: Text('뛰러가기'),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        : _successChallenge
                            .map(
                              (challenge) => Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      challenge['challengeUrl'],
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(challenge['challengeName'],
                                        style: TextStyle(
                                            color: SERVETWO_COLOR,
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            )
                            .toList(),
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
  Map<String, dynamic> _periodData = {};
  Map<String, dynamic> _historyData = {};
  Map<String, dynamic> _markerData = {};
  String? selectedDay;
  bool _isLoading = true; // 데이터를 받아오는 중

  @override
  void initState() {
    super.initState();
    getRecord(null);
  }

  void _updateContent(int index, bool isCalendarOpen) {
    setState(() {
      _selectedIndex = index;
      _isCalendarOpen = isCalendarOpen;
    });
  }

  Future<void> getRecord(String? selectedDay) async {
    int userId = Provider.of<UserInfo>(context, listen: false).userId;
    Map<String, dynamic> data1 = {};
    Map<String, dynamic> data2 = {};
    Map<String, dynamic> data3 = {};
    setState(() {
      _isLoading = true;
    });
    switch (_selectedIndex) {
      case 0:
        data1 = await GetPeriodRecord.getTodayPeriodRecord(userId);
        data2 = await GetHistoryRecord.getTodayHistoryRecord(userId);
        break;
      case 1:
        data1 = await GetPeriodRecord.getWeekPeriodRecord(userId);
        data2 = await GetHistoryRecord.getWeekHistoryRecord(userId);
        break;
      case 2:
        data1 = await GetPeriodRecord.getMonthPeriodRecord(userId);
        data2 = await GetHistoryRecord.getMonthHistoryRecord(userId);
        break;
      case 3:
        data1 = await GetPeriodRecord.getAllPeriodRecord(userId);
        data2 = await GetHistoryRecord.getAllHistoryRecord(userId);
        break;
      case 4:
        data1 =
            await GetPeriodRecord.getPeriodRecordSelectDay(userId, selectedDay);
        data2 = await GetHistoryRecord.getHistoryRecordSelectDay(
            userId, selectedDay);
        data3 =
            await GetHistoryRecord.getAllHistoryRecord(userId); // 마커 찍기 용 데이터
        break;
      default:
        data1 = {};
        data2 = {};
        break;
    }
    setState(() {
      _periodData = data1;
      _historyData = data2;
      _markerData = data3;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('===================');
    // print('_periodData: $_periodData');
    // print('_historyData: $_historyData');
    // print('_markerData: $_markerData');
    // print('===================');
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
              onPressed: () => {
                _updateContent(0, false),
                getRecord(null),
              },
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
              onPressed: () => {
                _updateContent(1, false),
                getRecord(null),
              },
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
              onPressed: () => {
                _updateContent(2, false),
                getRecord(null),
              },
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
              onPressed: () => {
                _updateContent(3, false),
                getRecord(null),
              },
              child: Text('전체',
                  style: TextStyle(
                    fontSize: 12,
                    color: _selectedIndex == 3 ? MAIN_COLOR : SERVEONE_COLOR,
                  )),
            ),
            OutlinedButton(
                onPressed: () {
                  if (_selectedIndex != 4) {
                    _updateContent(4, true);
                    getRecord(Provider.of<ForDate>(context, listen: false)
                        .forFocusFormat);
                  } else if (_selectedIndex == 4 && _isCalendarOpen == true) {
                    _updateContent(4, false);
                  } else if (_selectedIndex == 4 && _isCalendarOpen == false) {
                    _updateContent(4, true);
                  }
                },
                child: Icon(
                  Icons.calendar_today,
                  color: _isCalendarOpen == true ? MAIN_COLOR : SERVEONE_COLOR,
                )),
          ],
        ),
        _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : MyRecordContents(
                getRecord: getRecord,
                selectedIndex: _selectedIndex,
                isCalendarOpen: _isCalendarOpen,
                periodData: _periodData,
                historyData: _historyData,
                markerData: _markerData,
              )
      ],
    );
  }
}

class MyRecordContents extends StatefulWidget {
  final int selectedIndex;
  final bool isCalendarOpen;
  final Map<String, dynamic>? periodData;
  final Map<String, dynamic>? historyData;
  final Map<String, dynamic>? markerData;
  final Function(String?) getRecord;

  const MyRecordContents({
    Key? key,
    required this.selectedIndex,
    required this.isCalendarOpen,
    required this.periodData,
    required this.historyData,
    required this.markerData,
    required this.getRecord,
  }) : super(key: key);

  @override
  State<MyRecordContents> createState() => _MyRecordContentsState();
}

class _MyRecordContentsState extends State<MyRecordContents> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<Event>> parseMarkerData(Map<String, dynamic>? markerData) {
    if (markerData == null || markerData['content'] == null) {
      return {};
    }

    List<Map<String, dynamic>> markerList =
        List<Map<String, dynamic>>.from(markerData['content']);

    Map<DateTime, List<Event>> parseMarkerDataResult = {};

    for (Map<String, dynamic> marker in markerList) {
      DateTime createDate =
          DateTime.parse(marker['createDate']).toUtc();
      Event id = Event(marker['id']);
      if (parseMarkerDataResult.containsKey(createDate)) {
        parseMarkerDataResult[createDate]!.add(id);
      } else {
        parseMarkerDataResult[createDate] = [id];
      }
    }
    // print('parseMarkerDataResult: $parseMarkerDataResult');
    return parseMarkerDataResult;
  }

  List<Event> _getEventsForDay(DateTime day) {
    // print(day);
    return parseMarkerData(widget.markerData)[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // print('_getEventsForDay: $_getEventsForDay');
    final forDate = Provider.of<ForDate>(context);

    DateTime selectDay = DateTime(
      forDate.forFocus.year,
      forDate.forFocus.month,
      forDate.forFocus.day,
    );

    selectedDay = selectDay;
    focusedDay = forDate.forFocus;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isCalendarOpen == true
            ? TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime.utc(2021),
                lastDay: DateTime.utc(2025),
                focusedDay: focusedDay,
                eventLoader: _getEventsForDay,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMM(locale).format(date),
                  formatButtonVisible: false,
                  titleTextStyle:
                      TextStyle(fontSize: 20.0, color: Colors.white),
                  headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  leftChevronIcon:
                      Icon(Icons.arrow_left, size: 40.0, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.arrow_right, size: 40.0, color: Colors.white),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, event) {
                    if (event.isNotEmpty) {
                      return event.length >= 10
                          ? Icon(Icons.directions_run,
                              color: Color(0xFF84DE1C), size: 14)
                          : event.length >= 5
                              ? Icon(Icons.directions_run,
                                  color: Color(0xFF57CD3A).withOpacity(0.8),
                                  size: 14)
                              : Icon(Icons.directions_run,
                                  color: Color(0xFF60B44C), size: 14);
                    }
                  },
                ),
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: false, // marker 여러개 일 때 cell 영역을 벗어날지 여부
                  markersAlignment: Alignment.bottomCenter, // 마커 위치 조절
                  markerSize: 10,
                  markersMaxCount: 3, // 마커 최대 개수
                  markerDecoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  // today 표시 여부
                  isTodayHighlighted: true,
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
                  disabledTextStyle: TextStyle(
                    color: SERVEONE_COLOR.withOpacity(0.2),
                  ),
                  weekendTextStyle: TextStyle(color: Colors.white),
                ),
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  final getRecordDay =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                  widget.getRecord(getRecordDay);
                  // 선택된 날짜의 상태를 갱신
                  setState(
                    () {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                      forDate.changeValue(selectedDay);
                    },
                  );

                  // 현재 선택된 달력의 월과 다른 경우, 해당 달력으로 이동
                  if (selectedDay.month != focusedDay.month) {
                    setState(
                      () {
                        focusedDay =
                            DateTime(selectedDay.year, selectedDay.month, 1);
                      },
                    );
                  }
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줌
                  return isSameDay(selectedDay, day);
                },
              )
            : SizedBox.shrink(),
        SizedBox(height: 10),
        PeriodTotalRecord(
          selectedIndex: widget.selectedIndex,
          recordData: widget.periodData,
        ), // 조회 기간 총 기록
        SizedBox(height: 20),
        widget.historyData!['content'].length == 0
            ? SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '러닝 기록',
                  style: TextStyle(color: WHITE_COLOR, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
        Column(
          children: [
            for (int i = 0; i <= widget.historyData!['content'].length - 1; i++)
              Target(
                  targetname: widget.historyData!['content'][i]['createDate']
                          .toString() ??
                      '-',
                  runningDistance: widget.historyData!['content'][i]
                              ['runningDistance']
                          .toString() ??
                      '-',
                  userCalorie: widget.historyData!['content'][i]['userCalories']
                          .toString() ??
                      '-',
                  runningTime: widget.historyData!['content'][i]['runningTime']
                          .toString() ??
                      '-',
                  userPace: widget.historyData!['content'][i]['userPace']
                          .toString() ??
                      '-',
                  runningId: widget.historyData!['content'][i]['id'])
          ],
        ),
        widget.selectedIndex != 3 &&
                widget.selectedIndex != 4 &&
                widget.historyData!['content'].isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: RecordChart(
                      '평균 시간',
                      widget.periodData!['prevAvg']['originalTime'].toDouble(),
                      widget.periodData!['curAvg']['originalTime'].toDouble(),
                      widget.periodData!['prevAvg']['avgTime'].toString(),
                      widget.periodData!['curAvg']['avgTime'].toString(),
                    ),
                  ),
                  Expanded(
                    child: RecordChart(
                      '평균 거리(km)',
                      widget.periodData!['prevAvg']['avgDistance'],
                      widget.periodData!['curAvg']['avgDistance'],
                      widget.periodData!['prevAvg']['avgDistance'].toString(),
                      widget.periodData!['curAvg']['avgDistance'].toString(),
                    ),
                  ),
                  Expanded(
                    child: RecordChart(
                      '평균 kcal',
                      widget.periodData!['prevAvg']['avgKcal'],
                      widget.periodData!['curAvg']['avgKcal'],
                      widget.periodData!['prevAvg']['avgKcal'].toString(),
                      widget.periodData!['curAvg']['avgKcal'].toString(),
                    ),
                  ),
                  Expanded(
                    child: RecordChart(
                      '평균 페이스',
                      widget.periodData!['curAvg']['originalPace'] == 0 ||
                              widget.periodData!['prevAvg']['originalPace'] == 0
                          ? widget.periodData!['prevAvg']['originalPace']
                          : widget.periodData!['curAvg']['originalPace'],
                      widget.periodData!['curAvg']['originalPace'] == 0 ||
                              widget.periodData!['prevAvg']['originalPace'] == 0
                          ? widget.periodData!['curAvg']['originalPace']
                          : widget.periodData!['prevAvg']['originalPace'],
                      widget.periodData!['prevAvg']['avgPace'].toString(),
                      widget.periodData!['curAvg']['avgPace'].toString(),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
        widget.selectedIndex != 3 &&
                widget.selectedIndex != 4 &&
                widget.historyData!['content'].isNotEmpty
            ? Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: CONTOUR_COLOR, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 10,
                                width: 35,
                                color: MAIN_COLOR.withOpacity(0.5)),
                            SizedBox(width: 10),
                            Text(
                              (() {
                                switch (widget.selectedIndex) {
                                  case 0:
                                    return "어제 기록";
                                  case 1:
                                    return "저번주 기록";
                                  case 2:
                                    return "저번달 기록";
                                  default:
                                    return '';
                                }
                              })(),
                              style: TextStyle(color: WHITE_COLOR),
                            ),
                            SizedBox(width: 40),
                            Container(
                                height: 10,
                                width: 35,
                                color: MAIN_COLOR.withOpacity(0.5)),
                            SizedBox(width: 10),
                            Text(
                              (() {
                                switch (widget.selectedIndex) {
                                  case 0:
                                    return "오늘 기록";
                                  case 1:
                                    return "이번주 기록";
                                  case 2:
                                    return "이번달 기록";
                                  default:
                                    return '';
                                }
                              })(),
                              style: TextStyle(color: WHITE_COLOR),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }
}

class Event {
  String id;

  Event(this.id);
}
