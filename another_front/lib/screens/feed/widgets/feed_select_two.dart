import 'package:another/constant/color.dart';
import 'package:another/screens/feed/widgets/tabs.dart';
import 'package:flutter/material.dart';

class FeedSelectTwo extends StatefulWidget implements PreferredSizeWidget {
  const FeedSelectTwo({Key? key}) : super(key: key);

  @override
  State<FeedSelectTwo> createState() => _FeedSelectTwoState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FeedSelectTwoState extends State<FeedSelectTwo>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('로고'),
        backgroundColor: BACKGROUND_COLOR,
        bottom: TabBar(
          controller: tabController,
          tabs: TABS.map(
            (e) => Tab(
              child: Text(e.label),
            ),
          ).toList(),
        ),
    );
  }
}
