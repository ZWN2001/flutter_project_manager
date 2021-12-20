import 'package:admin/view/components/header.dart';
import 'package:admin/view/demand_board/components/all_demands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'archived_demand_board_logic.dart';


class ArchivedDemandBoardPage extends StatelessWidget {
  final logic = Get.put(ArchivedDemandBoardLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: '归档需求',),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: AllMyDemands(
                          demandsData: logic.allDoneDemands,
                        ),
                        // // if (Responsive.isMobile(context))
                        //   SizedBox(height: defaultPadding),
                        // // if (Responsive.isMobile(context))
                        //   StorageDetails(),

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
