import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LineChart(avgPace()
    );
  }
  LineChartData avgPace() {
    return LineChartData(

    );
  }
}
