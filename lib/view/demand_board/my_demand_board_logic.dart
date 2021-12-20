import 'package:admin/controllers/api.dart';
import 'package:admin/utils/file_downloader.dart';
import 'package:admin/view/archived_demand_board/archived_demand_board_logic.dart';
import 'package:admin/view/log/log_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyDemandBoardLogic extends GetxController {
  final logController = Get.put(LogController());
  final archivedDemandBoardLogic = Get.put(ArchivedDemandBoardLogic());
  RxList<Map> allDoingDemands = [{}].obs;
  String demandFileUrl = '';

  @override
  void onInit() {
    super.onInit();
    getAllDoingDemandList();
  }

  void getAllDoingDemandList()  {
     DemandAPI().getDoingDemandnList().then((value){
      allDoingDemands.value = value;
    });
  }

  void refresh(){
    getAllDoingDemandList();
    logController.getAllLogs();
    archivedDemandBoardLogic.getAllDoneDemandList();
  }

  void getDemandFile(int id)  {
    DemandAPI().getDemandFile(id).then((value){
      demandFileUrl = value;
      if(demandFileUrl.isNotEmpty){
        int n = FileDownloadUtil.downloadFile(demandFileUrl);
        if(n == -1){
          Fluttertoast.showToast(
            msg: "下载失败",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent,
          );
        }
      }else{
        Fluttertoast.showToast(
          msg: "暂无需求文档",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );
      }

    });
  }

  String translateStatus(int n){
    switch (n){
      case 1:return '已创建\n待技术接受';
      case 2:return '执行中\n待产品验收';
      case 3:return '已拒绝';
      case 4:return '未通过\n待技术返工';
      case 5:return '已完成';
      case 6: return '已超时';
    }
    return 'error';
  }
  String translateStatusOneLine(int n){
    switch (n){
      case 1:return '已创建,待技术接受';
      case 2:return '执行中,待产品验收';
      case 3:return '已拒绝';
      case 4:return '未通过,待技术返工';
      case 5:return '已完成';
      case 6: return '已超时';
    }
    return 'error';
  }
  String translatePriority(int n){
    switch (n){
      case 0:return '低';
      case 1:return '中';
      case 2:return '高';
    }
    return 'error';
  }
}

class MyDemandBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyDemandBoardLogic());
  }
}