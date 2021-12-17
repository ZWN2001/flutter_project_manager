import 'package:admin/utils/dialog.dart';
import 'package:admin/utils/sharedpreference_util.dart';
import 'package:admin/view/components/inkwell_basic_card/inkwell_basic_card_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';

import '../../components/color_hex.dart';

/// 封面
Widget taskCardCover({required int id, required String taskState, required String taskProject,
  required String taskPriority, required String taskTitle, required String taskCreater,
  required String taskCreateTime, required String taskManager, required String taskDeadLine}) {
  double height = 165.0;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    child: Container(
      height: height,
      child: Row(
        children: [
          Container(
            width: 88,
            color: HexColor.fromHex('5D4A99'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$id',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text.rich(
                      TextSpan(
                        text: taskState,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 64,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                                taskTitle,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )
                            ),
                            Spacer(),
                            Text(
                              '优先级:  $taskPriority',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '所属项目:  $taskProject',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      explainText('创建人', taskCreater),
                      explainText('创建时间', taskCreateTime),
                      explainText('负责人', taskManager),
                      explainText('截止时间', taskDeadLine),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/// 展开后的封面
Widget taskCardDetailCover({required int id, required String taskState, required String taskCreater,
    required String taskCreateTime, required String taskManager, required String taskDeadLine}) {
 SharedPreferences s = SharedPreferenceUtil.instance;
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 44,
          color: HexColor.fromHex('5D4A99'),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 28,),
              Text(
                '$id',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Expanded(child: SizedBox(width: 12,)),
              Text(
                '状态',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Expanded(child: SizedBox(width: 12,)),
              if(s.getString('identity') == '产品')
                createrMenu,
              if(s.getString('identity') == '技术')
                managerMenu,
            ],
          ),
        ),
        Stack(
          children: [
            Image.asset(
              'assets/images/taskCardBackgroundImage.png',
              width: double.infinity,
              height: 86,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              bottom: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  explainText('创建人', taskCreater, subtitleColor: Colors.white),
                  explainText('创建时间', taskCreateTime, subtitleColor: Colors.white),
                  explainText('负责人', taskManager, subtitleColor: Colors.white),
                  explainText('截止时间', taskDeadLine, subtitleColor: Colors.white),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

PopupMenuButton managerMenu = new PopupMenuButton<String>(
    onSelected: (String value) {

    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.download_done,
                    color: Colors.white,
                  ),
                  // SizedBox(width: 2,),
                  Text('已完成该需求'),
                ],
              ),
              onTap: (){
                DialogUtil.showMyDialog(context, dialogContent(), "完成需求");
              },
            ),

            value: '完成',
          ),
          PopupMenuItem(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.highlight_off, color: Colors.white,),
                  // SizedBox(width: 2,),
                  Text('拒绝该需求')
                ],
              ),
              onTap: (){
                DialogUtil.showMyDialog(context, dialogContent(), "拒绝需求");
              },
            ),
            value: '拒绝',
          ),
        ]
);



PopupMenuButton createrMenu = new PopupMenuButton<String>(
    onSelected: (String value) {

    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem(
        child: GestureDetector(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.download_done,color: Colors.white,),
              // SizedBox(width: 2,),
              Text('需求验收通过'),
            ],
          ),
          onTap: (){
            DialogUtil.showMyDialog(context, dialogContent(), "通过验收");
          },
        ),
        value: '通过',
      ),
      PopupMenuItem(
        child: GestureDetector(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.highlight_off,color: Colors.white,),
              // SizedBox(width: 2,),
              Text('需求验收未通过'),
            ],
          ),
          onTap: (){
            DialogUtil.showMyDialog(context, dialogContent(), "未通过验收");
          },
        ),
        value: '未通过',
      )
    ]);

Widget dialogContent(){
  return Card(
      margin: EdgeInsets.all(4),
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '    说明:',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ),
            Container(
              color: Colors.white,
              child:  Padding(
                padding: EdgeInsets.all(4),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black
                  ),
                  maxLines: 4,
                ),
              ),
            ),
          ],
        ),
      )
  );
}

/// 标题（第一行
Widget taskCardTitleComponent({required String taskTitle, required String taskProject,required String taskPriority}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 12,),
            Text(
              taskTitle,
              style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
               fontSize: 24,
             ),
           ),
            Spacer(),
            Text(
              '优先级:$taskPriority',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Text(
              '所属项目:  $taskProject',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    ),
  );
}

/// 流程（第二行
Widget taskCardFlowChartComponent({required List flowInfo, required BuildContext context}) {
  List info = [ 'zwn','2021-12-12 21:34:34'];
  return BasicCard(
    margin: EdgeInsets.zero,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(22, 0, 10, 0),
        child: Text(
          '近期动态：${info[0]}于${info[1]}对需求做了改动',
          style: TextStyle(
              fontSize: 18,
              color: Colors.black
          ),
        ),
      ),
        onTap: (){
          DialogUtil.showMyDialog(context,timeLineWidget(),'需求log');
        }
  );
}

///dialog的内容
Widget timeLineWidget(){
  return Card(
    color: Colors.white,
    child:Padding(
      padding: EdgeInsets.only(top: 16),
      child: SizedBox(
        width: 320,
        height: 360,
        child: Timeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0.07,
          ),
          builder: TimelineTileBuilder.fromStyle(
            indicatorStyle: IndicatorStyle.outlined,
            contentsAlign: ContentsAlign.basic,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Timeline Event $index',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            itemCount: 2,
          ),
        ),
      ),
    ),
  );
}

/// 下载文档
Widget taskCardGetFileComponent() {
  return ClipRRect(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              primary: HexColor.fromHex('FEBE16'),
            ),
            onPressed: () {

            },
            child: Container(
              height: 36,
              child: Center(
                child: Text(
                  '下载需求文档',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text('5 人已下载需求文档', style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ))
        ],
      ),
    ),
  );
}

/// 三行文字
Widget multipleLineText(String line1, String line2, String line3) {
  return Text.rich(
    TextSpan(
      style: TextStyle(
        height: 1.4,
      ),
      children: [
        TextSpan(
          text: '$line1\n',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        TextSpan(
          text: '$line2\n',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        TextSpan(
          text: line3,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

///
Widget explainText(String title, String subtitle,
    {Color? titleColor, Color? subtitleColor}) {
  return Text.rich(
    TextSpan(
        style: TextStyle(
          height: 1.4,
        ),
        children: [
          TextSpan(
              text: '$title\n',
              style: TextStyle(
                color: titleColor ?? Colors.grey,
                fontSize: 13,
              )),
          TextSpan(
            text: subtitle,
            style: TextStyle(
              color: subtitleColor ?? Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ]),
  );
}
