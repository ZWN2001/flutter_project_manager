import 'package:admin/view/components/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'AddDemandLogic.dart';

class AddDemandPage extends StatelessWidget {
 static final AddDemandLogic _logic = Get.put(AddDemandLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: '创建需求',
            ),
            SizedBox(height: defaultPadding),
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _titleInput(),
                        _projectInput(),
                        _selectDeadLine(context),
                        _selectManager(),
                        _selectPriority(),
                        // _selectDemandFile(),

                        // if (Responsive.isMobile(context))
                        // if (Responsive.isMobile(context))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60,),
            confirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _titleInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 24, 0, 0),
          child: Text(
            '标题:    ',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Expanded(child: Obx(() => _titleInputArea()), ),
      ],
    );
  }

  Widget _titleInputArea() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: TextField(
        controller: _logic.titleController,
        maxLength: 255,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          errorText: !_logic.hasInputTitle.value ? '标题不能为空或含有空格' : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 20,
          ),
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  Widget _projectInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 24, 0, 0),
          child: Text(
            '项目名:',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Expanded(child: Obx(() => _projectInputArea()), ),
      ],
    );
  }

  Widget _projectInputArea() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: TextField(
        controller: _logic.projectController,
        maxLength: 25,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          errorText: !_logic.hasInputProject.value ? '项目名不能为空或含有空格' : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 20,
          ),
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectDeadLine(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Text(
                '选择截止日期:',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            SizedBox(width: 20,),
            Obx(()=> _showDatePicker(context, _logic.selectedDeadLine.value),) ,
            Expanded(child: Container())
          ],
        )
      );
  }

  ElevatedButton _showDatePicker(context,title) {
    return ElevatedButton(
      child: Text(title),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
      ),
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          // 初始化选中日期
          firstDate: DateTime.now(),
          // 开始日期
          lastDate: DateTime.now().add(Duration(days: 365)),
          // 结束日期
          // initialEntryMode: DatePickerEntryMode.input,  // 日历弹框样式

          textDirection: TextDirection.ltr,
          // 文字方向

          currentDate: DateTime.now(),
          // 当前日期
          helpText: "hint",
          // 左上方提示
          cancelText: "取消",
          // 取消按钮文案
          confirmText: "确认",
          // 确认按钮文案

          errorFormatText: "格式错误",
          // 格式错误提示
          errorInvalidText: "时间超出范围",
          // 输入不在 first 与 last 之间日期提示

          fieldLabelText: "hint",
          // 输入框上方提示
          fieldHintText: "输入为空",
          // 输入框为空时内部提示

          initialDatePickerMode: DatePickerMode.day,
          // 日期选择模式，默认为天数选择
          useRootNavigator: true,
          // 是否为根导航器
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark(),
              child: child!,
            );
          },
        ).then((value) {
          //这样可以只显示日期
          _logic.selectedDeadLine.value = value.toString().split(' ')[0];
        });
      },
    );
  }

  Widget _selectManager() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '选择负责人:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(width: 42,),
            Obx(()=> _managerSelecter(),) ,
            Expanded(child: Container())
          ],
        )
    );
  }

  Widget _managerSelecter() {
    return  DropdownButton<String>(
      items: _logic.managerItems,
      value: _logic.selectedManager.value,
      selectedItemBuilder: (BuildContext context) {
        return _logic.managerItems;
      },
      iconEnabledColor: Colors.white,
      onChanged: (newValue) {
          _logic.selectedManager.value = newValue.toString();
      },
    );
  }

  Widget _selectPriority() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '选择优先级:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(width: 42,),
            Obx(()=> _prioritySelecter(),) ,
            Expanded(child: Container())
          ],
        )
    );
  }

  Widget _prioritySelecter() {
    return  DropdownButton<String>(
      items: _logic.priorityItems,
      value: _logic.selectedPriority.value,
      selectedItemBuilder: (BuildContext context) {
        return _logic.priorityItems;
      },
      iconEnabledColor: Colors.white,
      onChanged: (newValue) {
        _logic.selectedPriority.value = newValue.toString();
      },
    );
  }
  //
  // Widget _selectDemandFile(){
  //   return Container(
  //       margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
  //       child:  Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             '上传需求文档:',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18),
  //           ),
  //           SizedBox(width: 26,),
  //           Expanded(child: UploadWidget()),
  //           SizedBox(width: 160,)
  //         ],
  //       )
  //   );
  // }

  Widget confirmButton(BuildContext context){
    return FloatingActionButton(
      backgroundColor: Colors.lightBlue,
      child: Icon(Icons.assignment_turned_in_rounded, size: 28,),
      onPressed: () {
        _logic.createDemand(context);
      },
    );
  }
}
