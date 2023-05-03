
import 'package:another/screens/feed/feed_screen.dart';
import 'package:another/constant/color.dart';
import 'package:another/screens/record/Record.dart';
import 'package:another/screens/running/Running.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:provider/provider.dart';

import 'feed/feed_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  Map _runningColor = {
    'background': SERVETWO_COLOR,
    'text': WHITE_COLOR,
  };

  final List<Widget> _tabs = [
    FeedScreen(),  // 피드 탭
    RunningTab(), // 런닝 탭
    RecordTab(), // 기록 탭
  ];

  void _onRunningTab(int index) {
    if (index == 1){
      _runningColor['background'] = SERVETWO_COLOR;
      _runningColor['text'] = WHITE_COLOR;
    }
    else {
      if (index == 2) {
        final forDate = Provider.of<ForDate>(context, listen: false);
        forDate.changeValue(DateTime.now());
      }
      _runningColor['background'] = MAIN_COLOR;
      _runningColor['text'] = BLACK_COLOR;
    }
  }

  void _onTabTapped(int index) {
    _onRunningTab(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: Center(child: _tabs[_selectedIndex]),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: CONTOUR_COLOR,
          selectedItemColor: Colors.white,
          unselectedItemColor: SERVETWO_COLOR,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_photo_outlined),
              label: '오운완',
            ),
            BottomNavigationBarItem(
              icon: Transform.scale(
                scale: 3,
                child: Transform.translate(
                  offset: Offset(0, -2),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_run_rounded,
                          color: _runningColor['text'],
                          size: 12,
                        ),
                        Text(
                          '러닝',
                          style: TextStyle(
                            color: _runningColor['text'],
                            fontSize: 7,
                          ),
                        ),
                    ]),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: CONTOUR_COLOR,
                        width: 2,
                      ),
                      color: _runningColor['background'],
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              label: 'My',
            ),
          ],
        ),
      ),
    );
  }
}
