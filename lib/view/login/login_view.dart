import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:admin/view/login/components/flip_card.dart';
import 'package:admin/view/login/components/particles.dart';
import 'package:admin/view/login/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> with TickerProviderStateMixin {
  final controller = Get.put(LoginController());
  late Animation<double> frontAnimation;
  late Animation<double> backAnimation;
  late AnimationController animationController;
  bool hasHalf = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animationController.addListener(() {
      if (animationController.value > 0.5) {
        if (hasHalf == false) {
          controller.isFront.value = !controller.isFront.value;
        }
        hasHalf = true;
      }
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        hasHalf = false;
      }
    });
    frontAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)));
    backAnimation = Tween(begin: 1.5, end: 2.0).animate(CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.5, 1.0, curve: Curves.easeOut)));
  }

  animate() {
    animationController.stop();
    animationController.value = 0;
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Widget frontLoginCard() {
    return ClipRect(
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200.withOpacity(0.3)),
          height: 600,
          width: 380,
          child: Center(
            child: loginCardContent(),
          ),
        ),
      ),
    );
  }

  Container loginCardContent() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ClipOval(
              child: Image.asset(
                'images/login_logo.png',
                fit: BoxFit.contain,
                width: 140,
              ),
            ),
          ),
          Text(
            "Login",
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0xFF212332),
                fontSize: 50),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.loginUsernameController,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'username',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.loginPwdController,
              style: TextStyle(
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Obx(
              () => FlutterToggleTab(
                width: 20,
                borderRadius: 15,
                selectedIndex: controller.identify2.value - 1,
                isShadowEnable: true,
                selectedTextStyle: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                unSelectedTextStyle: TextStyle(
                    color: Color(0xFF212332),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                unSelectedBackgroundColors: [Colors.transparent],
                labels: ["产品", "技术"],
                icons: [Icons.lightbulb, Icons.android_outlined],
                selectedLabelIndex: (index) {
                  controller.identify2.value = index + 1;
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: RoundedLoadingButton(
              resetDuration: Duration(seconds: 5),
              resetAfterDuration: true,
              child: Text(
                'GO!',
                style: TextStyle(color: Colors.white),
              ),
              controller: controller.btnController,
              onPressed: controller.handleLogin,
              height: 45,
              width: 200,
              color: Color(0xFF2A2D3E),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
            child: Text(
              "no account? click double!",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF2A2D3E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backRegisterCard() {
    return ClipRect(
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200.withOpacity(0.3)),
          height: 600,
          width: 380,
          child: Center(
            child: registerCardContent(),
          ),
        ),
      ),
    );
  }

  Container registerCardContent() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Text(
            "Register",
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0xFF212332),
                fontSize: 50),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.registerUsernameController,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'username',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.registerPwdController,
              style: TextStyle(
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.registerConfirmPwdController,
              style: TextStyle(
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password again',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              controller: controller.registerEmailController,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'email',
                hintStyle: TextStyle(
                  color: Color(0xFF212332),
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
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFF212332),
                ),
                focusColor: Color(0xFF212332),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFF2A2D3E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Obx(
              () => FlutterToggleTab(
                width: 20,
                borderRadius: 15,
                selectedIndex: controller.identify1.value - 1,
                isShadowEnable: true,
                selectedTextStyle: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                unSelectedTextStyle: TextStyle(
                    color: Color(0xFF212332),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                unSelectedBackgroundColors: [Colors.transparent],
                labels: ["产品", "技术"],
                icons: [Icons.lightbulb, Icons.android_outlined],
                selectedLabelIndex: (index) {
                  controller.identify1.value = index + 1;
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: AnimatedButton(
              height: 35,
              width: 200,
              text: 'JOIN!',
              isReverse: true,
              textStyle: TextStyle(fontSize: 14),
              selectedTextColor: Colors.white,
              selectedBackgroundColor: controller.registerColor2,
              transitionType: TransitionType.CENTER_LR_OUT,
              // textStyle: submitTextStyle,
              backgroundColor: controller.registerColor1,
              borderColor: Color(0xFF2A2D3E),
              borderRadius: 20,
              borderWidth: 1,
              onPress: () => {
                controller.handleRegister().then(
                      (value) => {
                        if (value == 0)
                          {
                            Timer(
                              Duration(seconds: 1),
                              () {
                                animate();
                              },
                            ),
                          }
                      },
                    ),
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
            child: Text(
              "already have account? click double!",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF2A2D3E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginCard(Widget frontComponent, Widget backComponent) {
    return FlipCard(
      frontComponent: frontComponent,
      backComponent: backComponent,
      isFront: controller.isFront.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    double value = 0;
    if (animationController.status == AnimationStatus.forward) {
      if (hasHalf == true) {
        value = backAnimation.value;
      } else {
        value = frontAnimation.value;
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: AnimatedBackground()),
          Positioned.fill(child: Particles(30)),
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onDoubleTap: () {
                  animate();
                },
                child: Container(
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(pi * value),
                    alignment: Alignment.center,
                    child: IndexedStack(
                      index: controller.isFront.value ? 0 : 1,
                      children: [
                        frontLoginCard(),
                        backRegisterCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
