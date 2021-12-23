import 'dart:async';

import 'package:admin/utils/sharedpreference_util.dart';
import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  SharedPreferences s = SharedPreferenceUtil.instance;
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  List myLogList = [].obs;
  List<FlSpot> spotList = [];
  List<int> monthLogNumList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  late final String username;
  late String token;
  RxString email = "".obs;

  // 获取email
  Future getSelfInfo() async {
    Dio dio = Dio();
    Response response = await dio.post('http://localhost:8081/user/self',
        options: Options(headers: {'token': token}));
    int code = response.data['code'];
    if (code == 0) {
      Map map = response.data['data'];
      email.value = map['email'];
    } else {
      Timer(Duration(seconds: 1), () {
        Fluttertoast.showToast(
          msg: "请检查网络",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
        );
      });
    }
  }

  // 获取我的log
  Future getMyLog() async {
    Dio dio = Dio();
    Response response = await dio.post('http://localhost:8081/log/self',
        options: Options(headers: {'token': token}));
    int code = response.data['code'];
    if (code == 0) {
      myLogList = response.data['data'];
      getMonthNum();
      getSpotList();
    } else {
      Navigator.push(
        Get.context!,
        AwesomeMessageRoute(
          awesomeMessage: AwesomeMessage(
            title: "获取日志失败",
            message: response.data['message'],
            borderRadius: 20,
            backgroundColor: Colors.red[400]!,
            awesomeMessagePosition: AwesomeMessagePosition.TOP,
            margin: EdgeInsets.only(top: 30, left: 200, right: 200),
          ),
          theme: null,
        ),
      );
    }
  }

  // 修改密码事件
  Future changePassword() async {
    String oldPwd = oldPwdController.text.trim();
    String newPwd = newPwdController.text.trim();
    String confirmPwd = confirmPwdController.text.trim();
    if (oldPwd == "" || newPwd == "" || confirmPwd == "") {
      Fluttertoast.showToast(msg: "信息不可为空");
      // Navigator.push(
      //   Get.context!,
      //   AwesomeMessageRoute(
      //     awesomeMessage: AwesomeMessage(
      //       title: "修改失败",
      //       message: "信息不可为空",
      //       borderRadius: 20,
      //       backgroundColor: Colors.red[400]!,
      //       awesomeMessagePosition: AwesomeMessagePosition.TOP,
      //       margin: EdgeInsets.only(top: 30, left: 200, right: 200),
      //     ),
      //     theme: null,
      //   ),
      // );
      oldPwdController.clear();
      newPwdController.clear();
      confirmPwdController.clear();
      return;
    } else if (newPwd != confirmPwd) {
      Fluttertoast.showToast(msg: '两次密码不同');
      // Navigator.push(
      //   Get.context!,
      //   AwesomeMessageRoute(
      //     awesomeMessage: AwesomeMessage(
      //       title: "修改失败",
      //       message: "两次密码不同",
      //       borderRadius: 20,
      //       backgroundColor: Colors.red[400]!,
      //       awesomeMessagePosition: AwesomeMessagePosition.TOP,
      //       margin: EdgeInsets.only(top: 30, left: 200, right: 200),
      //     ),
      //     theme: null,
      //   ),
      // );
      oldPwdController.clear();
      newPwdController.clear();
      confirmPwdController.clear();
      return;
    } else {
      Dio dio = Dio();
      Response response =
          await dio.post('http://localhost:8081/user/reset', queryParameters: {
        'username': username,
        'old_password': oldPwd,
        'new_password': confirmPwd,
      });
      int code = response.data['code'];
      print(code);
      if (code == 0) {
        Navigator.push(
          Get.context!,
          AwesomeMessageRoute(
            awesomeMessage: AwesomeMessage(
              title: "修改成功",
              message: '请记住新密码',
              borderRadius: 20,
              backgroundColor: Colors.green[200]!,
              awesomeMessagePosition: AwesomeMessagePosition.TOP,
              margin: EdgeInsets.only(top: 30, left: 200, right: 200),
            ),
            theme: null,
          ),
        );
        oldPwdController.clear();
        newPwdController.clear();
        confirmPwdController.clear();
      } else {
        Navigator.push(
          Get.context!,
          AwesomeMessageRoute(
            awesomeMessage: AwesomeMessage(
              title: "修改失败",
              message: response.data['message'],
              borderRadius: 20,
              backgroundColor: Colors.red[400]!,
              awesomeMessagePosition: AwesomeMessagePosition.TOP,
              margin: EdgeInsets.only(top: 30, left: 200, right: 200),
            ),
            theme: null,
          ),
        );
        oldPwdController.clear();
        newPwdController.clear();
        confirmPwdController.clear();
      }
    }
  }

  // 填充spotList
  void getSpotList() {
    spotList.clear();
    for (int i = 0; i < 12; i++) {
      spotList.add(FlSpot((i + 1).toDouble(), monthLogNumList[i].toDouble()));
      // print("aaa"+monthLogNumList[i].toDouble().toString());
    }
  }

  // 解析英语月份到数字
  void getMonthNum() {
    monthLogNumList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    myLogList.forEach((element) {
      String ctime = element['ctime'];
      List<String> list = ctime.split(" ");
      print(list.toString());
      String mon = list.elementAt(1);
      print(mon);
      switch (mon) {
        case 'Jan':
          monthLogNumList[0]++;
          break;
        case 'Feb':
          monthLogNumList[1]++;
          break;
        case 'Mar':
          monthLogNumList[2]++;
          break;
        case 'Apr':
          monthLogNumList[3]++;
          break;
        case 'May':
          monthLogNumList[4]++;
          break;
        case 'Jun':
          monthLogNumList[5]++;
          break;
        case 'Jul':
          monthLogNumList[6]++;
          break;
        case 'Aug':
          monthLogNumList[7]++;
          break;
        case 'Sept':
          monthLogNumList[8]++;
          break;
        case 'Oct':
          monthLogNumList[9]++;
          break;
        case 'Nov':
          monthLogNumList[10]++;
          break;
        case 'Dec':
          monthLogNumList[11]++;
          print('yes');
          break;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    username = s.getString('username') ?? "default";
    token = s.getString('token') ?? "no";
    getSelfInfo();
    getMyLog();
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
