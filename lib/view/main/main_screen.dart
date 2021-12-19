import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/utils/responsive.dart';
import 'package:admin/utils/sharedpreference_util.dart';
import 'package:admin/view/add_demand/AddDemandView.dart';
import 'package:admin/view/archived_demand_board/archived_demand_board_view.dart';
import 'package:admin/view/demand_board/my_demand_board_view.dart';
import 'package:admin/view/log/log_view.dart';
import 'package:admin/view/profile/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainScreen extends StatelessWidget {
  final mainScreenController = Get.put(MainScreenLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Obx(()=>mainScreenController.list[mainScreenController.selectedItem.value]),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreenLogic extends GetxController{
  RxInt selectedItem = 0.obs;
  final List<Widget> list = [
    LogPage(),
    AddDemandPage(),
    MyDemandBoardPage(),
    ArchivedDemandBoardPage(),
    ProfilePage(),
    // TODO: add here
  ];
}

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenLogic());
  }
}


class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainScreenController = Get.put(MainScreenLogic());
    SharedPreferences _s = SharedPreferenceUtil.instance;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "团队日志",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              mainScreenController.selectedItem.value = 0;
            },
          ),
          if(_s.getString('identity') == '产品')
          DrawerListTile(
            title: "添加需求",
            svgSrc: "assets/icons/menu_add_demand.svg",
            press: () {
              mainScreenController.selectedItem.value = 1;
            },
          ),
          DrawerListTile(
            title: "需求面板",
            svgSrc: "icons/menu_developing.svg",
            press: () {
              mainScreenController.selectedItem.value = 2;
            },
          ),
          DrawerListTile(
            title: "归档",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              mainScreenController.selectedItem.value = 3;
            },
          ),
          DrawerListTile(
            title: "个人中心",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              mainScreenController.selectedItem.value = 4;
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {

            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

