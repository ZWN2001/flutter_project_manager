import 'package:admin/constants.dart';
import 'package:admin/utils/responsive.dart';
import 'package:admin/view/components/header.dart';
import 'package:admin/view/dashboard/components/storage_details.dart';
import 'package:admin/view/log/components/log_item_card.dart';
import 'package:admin/view/log/log_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LogPage extends StatelessWidget {
  final controller = Get.put(LogController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: 'teamLog'),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Obx(() => controller.allLogList.isEmpty
                      ? noLogContainer()
                      : logListContainer()),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () => StorageDetails(
                        total: controller.totalDemand.value,
                        numList: controller.demandDetailNum,
                      ),
                    ),
                  ),
              ],
            ),
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: LogItemCard(
                                  senderName: "senderName",
                                  commitContent: "commitContent",
                                  projectName: "projectName",
                                  time: 'time'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Container logListContainer() {
    return Container(
      child: AnimationLimiter(
        child: ListView.builder(
          itemCount: controller.allLogList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 675),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: LogItemCard(
                    senderName: controller.allLogList.elementAt(index)['cer'],
                    commitContent:
                        controller.allLogList.elementAt(index)['commit'],
                    projectName:
                        controller.allLogList.elementAt(index)['project'],
                    time: controller.allLogList.elementAt(index)['ctime'],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container noLogContainer() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/empty_content.svg',
              width: 100,
              height: 152.5,
            ),
            Text(
              "还没有团队日志哦",
              style: TextStyle(fontSize: 20, color: Colors.white54),
            )
          ],
        ),
      ),
    );
  }
}
