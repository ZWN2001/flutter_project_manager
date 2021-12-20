import 'package:admin/controllers/api.dart';
import 'package:admin/utils/dialog.dart';
import 'package:admin/view/demand_board/my_demand_board_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddDemandLogic extends GetxController {
  final logic = Get.put(MyDemandBoardLogic());

  RxBool hasInputTitle = true.obs;
  final TextEditingController titleController = TextEditingController();
  RxBool hasInputProject = true.obs;
  final TextEditingController projectController = TextEditingController();
  RxString selectedDeadLine = '未选择截止日期'.obs;

  List<String> _managerList = [];
  List<DropdownMenuItem<String>> managerItems = [];
  RxString selectedManager = "".obs;

  List<String> _priorityList = [
    "低",
    "中",
    "高",
  ];
  List<DropdownMenuItem<String>> priorityItems = [];
  RxString selectedPriority = "".obs;
  @override
  void onInit() {
    super.onInit();
    getManagerList().then((value) {
      if(_managerList.isEmpty){
        _managerList[0] = '无可选人员';
        selectedManager.value = '无可选人员';
      }else{
        selectedManager.value = _managerList[0];
      }
      _initManagerItems();
    });
    selectedPriority.value = _priorityList[0];

    _initPriorityItems();
  }

  Future<void> getManagerList() async {
    await UserAPI().getTechnicianList().then((value) {
      _managerList = value;
    });
  }

  void _initManagerItems() {
    managerItems =
        _managerList.map<DropdownMenuItem<String>>((String managerName) {
          return DropdownMenuItem(
            value: managerName,
            child: Text(
              managerName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        }).toList();
  }

  void _initPriorityItems() {
    priorityItems =
        _priorityList.map<DropdownMenuItem<String>>((String priority) {
          return DropdownMenuItem(
            value: priority,
            child: Text(
              priority,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        }).toList();
  }

  Future<void> createDemand(BuildContext context) async {
    String title = titleController.text;
    String project = projectController.text;
    int priority = 0;
    if(title.isEmpty||title.contains(' ')||
        project.isEmpty||project.contains(' ')||
        selectedDeadLine.value == '未选择截止日期'){
      if(title.isEmpty||title.contains(' ')){
        hasInputTitle.value = false;
      }else{
        hasInputTitle.value = true;
      }
      if(project.isEmpty||project.contains(' ')){
        hasInputProject.value = false;
      }else{
        hasInputProject.value = true;
      }
      if(selectedDeadLine.value == '未选择截止日期'){
        Fluttertoast.showToast(
          msg: "未选择截止日期",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
        );
      }
    }else{
      await DialogUtil.showConfirmDialog(
          context: context,
          child: Text(
            '确认创建需求',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          title:'确认'
      ).then((value) async {

        if(value!=null&&value){
          switch (selectedPriority.value){
            case '低': priority = 0;break;
            case '中': priority = 1;break;
            case '高': priority = 2;break;
          }

           await DemandAPI().createDemand(title, project, selectedDeadLine.value,
               selectedManager.value, priority).then((value) {
             if(value == 0){
               logic.getAllDoingDemandList();
               Fluttertoast.showToast(
                 msg: "创建成功",
                 toastLength: Toast.LENGTH_LONG,
                 gravity: ToastGravity.BOTTOM,
                 backgroundColor: Colors.green,
               );

               hasInputTitle.value = true;
               hasInputProject.value = true;
               titleController.text = '';
               projectController.text = '';
               selectedDeadLine.value = '未选择截止日期';
               selectedManager.value = _managerList[0];
               selectedPriority.value = _priorityList[0];

             }else{
               Fluttertoast.showToast(
                 msg: "创建失败",
                 toastLength: Toast.LENGTH_LONG,
                 gravity: ToastGravity.BOTTOM,
                 backgroundColor: Colors.redAccent,
               );
             }

           });
        }
      });
    }





  }
}
class AddDemandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDemandLogic());
  }
}
