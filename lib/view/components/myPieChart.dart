import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyPieChart extends StatefulWidget {
  final int total;
  final List<int> numList;

  MyPieChart({
    Key? key,
    required this.total,
    required this.numList,
  });

  @override
  _MyPieChartState createState() =>
      _MyPieChartState(total: total, numList: numList);
}

class _MyPieChartState extends State<MyPieChart>
    with SingleTickerProviderStateMixin {

  final int total;
  final List<int> numList;
  int all = 0;

  _MyPieChartState({
    required this.total,
    required this.numList,
  });

  late AnimationController _animationController;
  Color enterColor = Colors.black54;
  Color exitColor = Colors.transparent;
  Color enterBackColor = Color(0xFF212332);
  Color exitBackColor = Color(0xFF2A2D3E);
  bool isEnter = false;

  //控制饼图使用的
  late Animation<double> _progressAnimation;

  //控制数字使用的
  late Animation<double> _numberAnimation;
  List _list = [
    {"title": "已创建", "number": 0, "color": Colors.blue},
    {"title": "执行中", "number": 0, "color": Colors.deepOrangeAccent},
    {"title": "已拒绝", "number": 0, "color": Colors.redAccent},
    {"title": "未通过", "number": 0, "color": Colors.amber},
    {"title": "已完成", "number": 0, "color": Colors.green},
    {"title": "已超时", "number": 0, "color": Colors.deepPurple},
  ];

  @override
  void initState() {
    super.initState();
    numList.forEach((element) {
      all += element;
    });
    //初始化
    _animationController = new AnimationController(
      //执行时间为 1 秒
        duration: Duration(milliseconds: 1000),
        vsync: this);
    //在 100 ~ 1000 毫秒的区间内执行画饼的操作动画
    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        //执行时间 区间
        curve: Interval(0.1, 1.0, curve: Curves.bounceOut),
      ),
    );
    //在 100 ~ 1000 毫秒的区间 执行最上层的数字抬高的操作动画
    _numberAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        //执行时间 区间
        curve: Interval(0.1, 1.0, curve: Curves.bounceOut),
      ),
    );
    //添加 一个监听 刷新页面
    _animationController.addListener(() {
      setState(() {});
    });
    setState(() {
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Color(0xFF2A2D3E),
            shape: BoxShape.circle,
            /*
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: -8 * _bgAnimation.value,
                offset:
                    Offset(-5 * _bgAnimation.value, -5 * _bgAnimation.value),
                blurRadius: 30 * _bgAnimation.value,
              ),
              BoxShadow(
                //模糊颜色
                color: Colors.blue[300]!.withOpacity(0.3),
                //模糊半径
                spreadRadius: 2 * _bgAnimation.value,
                //阴影偏移量
                offset: Offset(5 * _bgAnimation.value, 5 * _bgAnimation.value),
                //模糊度
                blurRadius: 20 * _bgAnimation.value,
              ),
            ],*/
          ),
          child: CustomPaint(
            size: Size(200, 200),
            painter: MyPainter(_list, _progressAnimation.value, numList),
          ),
        ),
        MouseRegion(
          onEnter: (event) {
            setState(() {
              isEnter = !isEnter;
            });
          },
          onExit: (event) {
            setState(() {
              isEnter = !isEnter;
            });
          },
          // cursor: SystemMouseCursors.click,
          child: Container(
            width: isEnter ? 150 : 140,
            height: isEnter ? 150 : 140,
            decoration: BoxDecoration(
              color: isEnter ? enterBackColor : exitBackColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3 * _numberAnimation.value,
                  blurRadius: 5 * _numberAnimation.value,
                  offset: Offset(
                      5 * _numberAnimation.value, 5 * _numberAnimation.value),
                  color: isEnter ? enterColor : exitColor,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "总需求",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(all.toString(), style: TextStyle(fontSize: 18))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  List list;
  List numberList;
  double progress;

  MyPainter(this.list, this.progress, this.numberList);

  Paint _paint = new Paint()
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double startRadian = -pi / 2;
    //需求总数量
    double total = 0.0;
    numberList.forEach((element) {
      total += element;
    });
    //开始绘制
    for (var i = 0; i < list.length; i++) {
      //当前要绘制的选项
      var num = numberList[i];
      var item = list[i];

      //计算所占的比例
      double flag = num / total;

      //计算弧度
      double sweepRadin = flag * 2 * pi * progress;

      //开始绘制弧
      //设置一下画笔的颜色
      _paint.color = item["color"];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startRadian, sweepRadin, true, _paint);

      //累加下次开始绘制的角度
      startRadian += sweepRadin;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
