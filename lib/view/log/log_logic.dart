import 'package:admin/utils/sharedpreference_util.dart';
import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class LogController extends GetxController {
  SharedPreferences s = SharedPreferenceUtil.instance;
  late final String username;
  late String token;
  RxList allLogList = [].obs;
  List<int> demandDetailNum = [0,0,0,0,0,0].obs;
  RxInt totalDemand = 0.obs;

  // 获取团队所有日志
  Future getAllLogs() async {
    Dio dio = Dio();
    Response response = await dio.post('http://localhost:8081/log/all',
        options: Options(headers: {'token': token}));
    int code = response.data['code'];
    if (code == 0) {
      allLogList.value = response.data['data'];
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

  // 获取总需求和各需求数量
  Future getDemandDetail() async {
    Dio dio = Dio();
    Response response = await dio.post('http://localhost:8081/demand/num',
        options: Options(headers: {'token': token}));
    int code = response.data['code'];
    if (code == 0) {
      String data = response.data['data'];
      List list = data.split(',');
      for (int i = 0; i < 6; i++) {
        List temp = list.elementAt(i).toString().split('=');
        demandDetailNum[i] = int.parse(temp[1]);
        totalDemand.value += int.parse(temp[1]);
      }
    } else {
      print('error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    username = s.getString('username') ?? "default";
    token = s.getString('token') ?? "no";
    getAllLogs();
    getDemandDetail();
    update();
  }
}

class LogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogController>(() => LogController());
  }
}
