import 'package:another/constant/const/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RecordChart extends StatelessWidget {
  final String x;
  final double y1graph;
  final double y2graph;
  final String y1text;
  final String y2text;
  const RecordChart(this.x, this.y1graph, this.y2graph, this.y1text, this.y2text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      // x축, 첫번째 값, 두번째 값
      ChartData(x, y1graph, y2graph, y1text, y2text),
    ];

    return Center(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 0),
        ),
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          borderWidth: 0,
          primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            minorTickLines: MinorTickLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            labelsExtent: 0,
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            minorGridLines: MinorGridLines(width: 0),
            minorTickLines: MinorTickLines(width: 0),
            axisLine: AxisLine(width: 0),
          ),
          series: <CartesianSeries>[
            ColumnSeries<ChartData, String>(
              width: 0.9,

              spacing: 0.05,
              color: Color(0xFF8E8E8E).withOpacity(0.8),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),

              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1graph,
              dataLabelMapper: (ChartData data, _) => data.y1text,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(fontSize: 12, color: WHITE_COLOR),
              ),
            ),
            ColumnSeries<ChartData, String>(
              width: 0.9,

              spacing: 0.05,
              color: Color(0xFF4AF279).withOpacity(0.8),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),

              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2graph,
              dataLabelMapper: (ChartData data, _) => data.y2text,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(fontSize: 12, color: WHITE_COLOR),
              ),
            ),
            LineSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2graph,
              color: WHITE_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y1graph, this.y2graph, this.y1text, this.y2text);
  final String x;
  final double y1graph;
  final double y2graph;
  final String y1text;
  final String y2text;
}
