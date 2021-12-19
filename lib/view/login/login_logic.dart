import 'dart:async';
import 'dart:ui';

import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/utils/sharedpreference_util.dart';
import 'package:admin/utils/string_util.dart';
import 'package:admin/view/login/login_view.dart';
import 'package:admin/view/main/main_screen.dart';
import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  SharedPreferences s = SharedPreferenceUtil.instance;
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerPwdController = TextEditingController();
  TextEditingController registerConfirmPwdController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPwdController = TextEditingController();
  RxString loginUsername = "".obs;
  RxString loginPassword = "".obs;
  RxString registerUsername = "".obs;
  RxString registerPwd = "".obs;
  RxString registerConfirmPwd = "".obs;
  RxBool isFront = true.obs;
  Color registerColor1 = Color(0xFF212332);
  Color registerColor2 = Color(0xFF2A2D3E);
  int value = 0;
  RxInt identify1 = 1.obs;
  RxInt identify2 = 1.obs;

  void changeCard() {
    this.isFront.value = true;
    LoginState().animate();
  }

  // 处理登录事件
  Future handleLogin() async {
    String username = loginUsernameController.text.trim();
    String pwd = loginPwdController.text.trim();
    if (username.isEmpty || pwd.isEmpty) {
      Timer(Duration(seconds: 2), () {
        btnController.error();
        Navigator.push(
          Get.context!,
          AwesomeMessageRoute(
            awesomeMessage: AwesomeMessage(
              title: "登录失败",
              message: "信息不可为空",
              borderRadius: 20,
              backgroundColor: Colors.red[400]!,
              awesomeMessagePosition: AwesomeMessagePosition.TOP,
              margin: EdgeInsets.only(top: 30, left: 200, right: 200),
            ),
            theme: null,
          ),
        );
        // Fluttertoast.showToast(
        //   msg: "登录失败",
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.redAccent,
        // );
      });
      return;
    } else {
      Dio dio = Dio();
      Response response = await dio.post(
        'http://localhost:8081/user/login',
        queryParameters: {
          'username': username,
          'password': pwd,
          'identity': identify2.value,
        },
        options: Options(
          sendTimeout: 500,
          receiveTimeout: 500,
        ),
      );
      int code = response.data['code'];
      print(code);
      if (code == 0) {
        String token = response.data['data'];
        String ide = identify2.value == 2 ? "技术" : "产品";
        s.setString('identity', ide);
        s.setString('token', token);
        s.setString('username', username);
        btnController.success();
        Timer(Duration(seconds: 1), () {
          Get.to(() {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuController(),
                ),
              ],
              child: MainScreen(),
            );
          });
        });
      } else {
        Timer(Duration(seconds: 2), () {
          btnController.error();
          Navigator.push(
            Get.context!,
            AwesomeMessageRoute(
              awesomeMessage: AwesomeMessage(
                title: "登录失败",
                message: "信息错误",
                borderRadius: 20,
                backgroundColor: Colors.red[400]!,
                awesomeMessagePosition: AwesomeMessagePosition.TOP,
                margin: EdgeInsets.only(top: 30, left: 200, right: 200),
              ),
              theme: null,
            ),
          );
          // Fluttertoast.showToast(
          //   msg: "登录失败",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.redAccent,
          // );
        });
      }
    }
  }

  // 处理注册事件
  Future handleRegister() async {
    String username = registerUsernameController.text.trim();
    String pwd = registerPwdController.text.trim();
    String confirmPwd = registerConfirmPwdController.text.trim();
    String email = registerEmailController.text.trim();
    if (username.isEmpty || pwd.isEmpty || confirmPwd.isEmpty) {
      Fluttertoast.showToast(
        msg: "信息不可为空",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      return 1;
    } else if (pwd != confirmPwd) {
      Fluttertoast.showToast(
        msg: "两次密码不同",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      return 1;
    } else if (!StringUtil.isEmail(email)) {
      Fluttertoast.showToast(
        msg: "请检查邮箱格式",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return 1;
    } else if (username.length >= 20 || confirmPwd.length >= 20) {
      Fluttertoast.showToast(
        msg: "用户名及密码长度不得超过20",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      return 1;
    } else {
      Response response;
      Dio dio = Dio();
      response = await dio.post(
        'http://localhost:8081/user/register',
        queryParameters: {
          'username': username,
          'password': confirmPwd,
          'email': email,
          'identity': identify1.value,
        },
        options: Options(
          sendTimeout: 500,
          receiveTimeout: 500,
        ),
      );
      int code = response.data['code'];
      if (code == 0) {
        Fluttertoast.showToast(
          msg: "注册成功",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
        );
        return 0;
      } else {
        Fluttertoast.showToast(
          msg: "注册失败",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent,
        );
        return 1;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
