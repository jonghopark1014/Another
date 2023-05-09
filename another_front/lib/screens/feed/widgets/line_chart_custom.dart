import 'package:another/constant/text_style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';

class Chart extends StatelessWidget {
  final List<PacesData> chartData;
  const Chart({
    required this.chartData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double averagePaces =
        chartData.map((e) => e.userPace).reduce((a, b) => a + b) /
            chartData.length;
    return SfCartesianChart(
      // 범례
      legend:
          Legend(isVisible: false, textStyle: TextStyle(color: WHITE_COLOR)),
      // 숫자 나오게 하는
      tooltipBehavior: TooltipBehavior(enable: true),
      // 그래프 선 색깔
      plotAreaBorderColor: BACKGROUND_COLOR,
      // 그래프 안의 색상 변경
      // plotAreaBackgroundColor: WHITE_COLOR,
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(color: WHITE_COLOR),
        title: AxisTitle(
          text: '거리',
          textStyle: MyTextStyle.twentyTextStyle,
        ),
        tickPosition: TickPosition.inside,
        borderColor: MAIN_COLOR,
        rangePadding: ChartRangePadding.none,
        labelPosition: ChartDataLabelPosition.inside,
        labelsExtent: 0,
        axisLine: AxisLine(color: MAIN_COLOR, width: 3.5),
        majorTickLines: MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: '페이스',
          textStyle: MyTextStyle.twentyTextStyle,
        ),
        // 구분선 없애기
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(color: WHITE_COLOR),
        labelsExtent: 0,
        // y축 색깔
        borderColor: MAIN_COLOR,
        tickPosition: TickPosition.inside,
        labelPosition: ChartDataLabelPosition.inside,
        rangePadding: ChartRangePadding.additional,
        axisLine: AxisLine(color: MAIN_COLOR, width: 3.5),
        // 구분선
        majorTickLines: MajorTickLines(width: 0),
      ),
      // 주석
      series: <SplineSeries<PacesData, num>>[
        SplineSeries<PacesData, num>(
          dataSource: chartData,
          xValueMapper: (PacesData paces, _) => paces.runningDistance,
          yValueMapper: (PacesData paces, _) => paces.userPace,
          name: '페이스',
          pointColorMapper: _getPointColor,
          markerSettings: MarkerSettings(
            isVisible: false,
            shape: DataMarkerType.circle,
            borderWidth: 2,
            color: MAIN_COLOR,
          ),
          dataLabelSettings: DataLabelSettings(isVisible: false),
        ),
      ],
      // 평균선 구하는 그래프
      // annotations: <CartesianChartAnnotation>[
      //   CartesianChartAnnotation(
      //       widget: Container(
      //         height: 3,
      //         width: double.infinity,
      //         color: MAIN_COLOR,
      //       ),
      //       coordinateUnit: CoordinateUnit.point,
      //       x: chartData.first.distance,
      //       y: averagePaces,
      //       verticalAlignment: ChartAlignment.near)
      // ],
    );
  }

  Color _getPointColor(PacesData pacesData, _) {
    if (pacesData.userPace > 13) {
      return RED_COLOR;
    } else {
      return WHITE_COLOR;
    }
  }
}

class PacesData {
  final double runningDistance;
  final double userPace;

  PacesData({required this.runningDistance, required this.userPace});
}
