import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearChart extends StatelessWidget {
  final bool isShowingMainData;
  final List<FlSpot> list;

  const LinearChart({required this.isShowingMainData, required this.list});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 14,
    maxY: 20,
    minY: 0,
  );

  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData2,
    minX: 0,
    maxX: 14,
    maxY: 25,
    minY: 0,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: bottomTitles,
    rightTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    leftTitles: leftTitles(
      getTitles: (value) {
        switch (value.toInt()) {
          case 5:
            return '5';
          case 10:
            return '10';
          case 15:
            return '15';
          case 20:
            return '20';
        }
        return '';
      },
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: bottomTitles,
    rightTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    leftTitles: leftTitles(
      getTitles: (value) {
        switch (value.toInt()) {
          case 5:
            return '5';
          case 10:
            return '10';
          case 15:
            return '15';
          case 20:
            return '20';
          case 25:
            return '25';
        }
        return '';
      },
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,
  ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
    getTitles: getTitles,
    showTitles: true,
    margin: 8,
    interval: 1,
    reservedSize: 40,
    getTextStyles: (context, value) => const TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 22,
    margin: 10,
    interval: 1,
    getTextStyles: (context, value) => const TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    getTitles: (value) {
      switch (value.toInt()) {
        case 1:
          return 'JUN';
        case 4:
          return 'APR';
        case 7:
          return 'JUL';
        case 10:
          return 'OCT';
      }
      return '';
    },
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xff4e4965), width: 4),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    colors: [const Color(0xff27b6fc)],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: list,
    // const [
    //   FlSpot(1, 1),
    //   FlSpot(3, 15),
    //   FlSpot(5, 12),
    //   FlSpot(7, 6),
    //   FlSpot(9, 2),
    //   // FlSpot(11, 22),
    //   FlSpot(12, 18),
    // ],
  );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    colors: const [Color(0x4427b6fc)],
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: list,
    // const [
    //   FlSpot(1, 1),
    //   FlSpot(3, 15),
    //   FlSpot(5, 12),
    //   FlSpot(7, 6),
    //   FlSpot(9, 2),
    //   FlSpot(11, 22),
    //   FlSpot(12, 18),
    // ],
  );


}
