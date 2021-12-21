import 'package:admin/utils/responsive.dart';
import 'package:admin/view/profile/components/linear_chart_card.dart';
import 'package:admin/view/profile/profile_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

class ProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  // Text("profile",style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left,),
                  Container(
                    margin: EdgeInsets.only(left: 36, top: 36, bottom: 36),
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // border: new Border.all(color: Colors.white54, width: 0.5),
                      // color: Color(0xff292b49),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff292b49),
                          Color(0xFF161B24),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: Container(
                                height: 180,
                                width: 180,
                                color: Colors.blueAccent,
                                child: Center(
                                  child: Text(
                                    controller.username.substring(0, 1),
                                    style: TextStyle(fontSize: 80),
                                  ),
                                ),
                              ),
                              // child: ClipOval(
                              //   child: Image.asset(
                              //     'images/lzw_img.png',
                              //     fit: BoxFit.fill,
                              //     width: 180,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.username,
                                style: TextStyle(fontSize: 50),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "邮箱：" + controller.email.value,
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  showAnimatedDialog(
                                    axis: Axis.horizontal,
                                    alignment: Alignment.topCenter,
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return DialogContent(
                                          controller: controller);
                                    },
                                    animationType:
                                        DialogTransitionType.slideFromTop,
                                    curve: Curves.linear,
                                  );
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(horizontal: 0))),
                                child: Text(
                                  "修改密码",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 36),
                    width: 520,
                    child: LinearChartCard(list: controller.spotList),
                  ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context))
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.myLogList.length == 0
                        ? noLogContainer()
                        : buildMyLogContainer(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Container buildMyLogContainer() {
    return Container(
      margin: EdgeInsets.only(left: 36, top: 36, right: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: new Border.all(color: Colors.white54, width: 0.5),
        gradient: LinearGradient(
          colors: [
            Color(0xff292b49),
            Color(0xFF161B24),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      // height: 700,
      // width: 300,
      constraints: BoxConstraints(
        minHeight: 650,
        maxHeight: 700,
        // maxWidth: 450,
        minWidth: 300,
      ),
      child: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          contentsAlign: ContentsAlign.alternating,
          oppositeContentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              controller.myLogList.elementAt(index)['ctime'].toString(),
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              controller.myLogList.elementAt(index)['commit'].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          itemCount: controller.myLogList.length,
        ),
      ),
    );
  }

  Container noLogContainer() {
    return Container(
      margin: EdgeInsets.only(left: 36, top: 36, right: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: new Border.all(color: Colors.white54, width: 0.5),
        gradient: LinearGradient(
          colors: [
            Color(0xff292b49),
            Color(0xFF161B24),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 650,
        maxHeight: 700,
        // maxWidth: 450,
        minWidth: 300,
      ),
      child: Center(
        child: Text(
          '最近还没有提交记录哦，摸鱼人！',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff292b49),
        ),
        margin: EdgeInsets.only(top: 230, left: 380, right: 380, bottom: 230),
        width: 300,
        height: 200,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '修改密码',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 50, right: 50),
              child: TextField(
                controller: controller.oldPwdController,
                decoration: InputDecoration(
                  hintText: '原密码',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 30,
                  ),
                  focusColor: Color(0xFF212332),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 50, right: 50),
              child: TextField(
                controller: controller.newPwdController,
                decoration: InputDecoration(
                  hintText: '新密码',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 30,
                  ),
                  focusColor: Color(0xFF212332),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 50, right: 50),
              child: TextField(
                controller: controller.confirmPwdController,
                decoration: InputDecoration(
                  hintText: '再次输入新密码',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 30,
                  ),
                  focusColor: Color(0xFF212332),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '取消',
                        style: TextStyle(fontSize: 16),
                      )),
                  TextButton(
                      onPressed: () {
                        controller.changePassword();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
