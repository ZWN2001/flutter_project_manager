import 'package:admin/view/components/header.dart';
import 'package:admin/view/dashboard/components/storage_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'components/all_demands.dart';
import 'my_demand_board_logic.dart';


class MyDemandBoardPage extends StatelessWidget {
  final logic = Get.put(MyDemandBoardLogic());

  //会报错
  //The provided ScrollController is currently attached to more than one ScrollPosition.
  //暂时无解（两个滑动发生了冲突）
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: '需求面板',),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: GetBuilder<MyDemandBoardLogic>(
                    builder: (value)=>Column(
                      children: [
                      AllMyDemands(
                          demandsData: logic.allDoingDemands,
                        ),
                        // // if (Responsive.isMobile(context))
                        //   SizedBox(height: defaultPadding),
                        // // if (Responsive.isMobile(context))
                        //   StorageDetails(),
                      ],
                    ),
                  ),
                ),
                // if (!Responsive.isMobile(context))
                //   SizedBox(width: defaultPadding),
                // // On Mobile means if the screen is less than 850 we dont want to show it
                // if (!Responsive.isMobile(context))
                //   Expanded(
                //     flex: 2,
                //     child: StorageDetails(),
                //   ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
