import 'package:admin/view/components/info_card.dart';
import 'package:admin/view/components/myPieChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StorageDetails extends StatelessWidget {
  final int total;
  final List<int> numList;

  StorageDetails({
    Key? key,
    required this.total,
    required this.numList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Storage Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: defaultPadding),
          /*Chart(
            enableCentralTitle: true,
            paiChartSelectionDatas: paiChartSelectionDatas,
            centralTitle: '共计',
            centralSubTitle: 'xxx条',
          ),*/
          MyPieChart(
              total: total, numList: numList,),
          InfoCard(
            svgSrc: "assets/icons/demand_created.svg",
            title: "已创建",
            amount: "",
            subTitle: numList[0].toString(),
          ),
          InfoCard(
            svgSrc: "assets/icons/demand_doing.svg",
            title: "执行中",
            amount: "",
            subTitle: numList[1].toString(),
          ),
          InfoCard(
            svgSrc: "assets/icons/demand_rejected.svg",
            title: "已拒绝",
            amount: "",
            subTitle: numList[2].toString(),
          ),
          InfoCard(
            svgSrc: "assets/icons/demand_fail.svg",
            title: "未通过",
            amount: "",
            subTitle: numList[3].toString(),
          ),
          InfoCard(
            svgSrc: "assets/icons/demand_finished.svg",
            title: "已完成",
            amount: "",
            subTitle: numList[4].toString(),
          ),
          InfoCard(
            svgSrc: "assets/icons/demand_overtime.svg",
            title: "已超时",
            amount: "",
            subTitle: numList[5].toString(),
          ),
        ],
      ),
    );
  }

  final List<PieChartSectionData> paiChartSelectionDatas = [
    PieChartSectionData(
      color: primaryColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Color(0xFF26E5FF),
      value: 20,
      showTitle: false,
      radius: 22,
    ),
    PieChartSectionData(
      color: Color(0xFFFFCF26),
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: Color(0xFFEE2727),
      value: 15,
      showTitle: false,
      radius: 16,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.1),
      value: 25,
      showTitle: false,
      radius: 13,
    ),
  ];
}
