import 'package:admin/controllers/api.dart';
import 'package:get/get.dart';

class ArchivedDemandBoardLogic extends GetxController {
  RxList<Map> allDoneDemands = [{}].obs;
  // List allDemandsTimeLine = [];
  String demandFileUrl = '';

  @override
  void onInit() {
    super.onInit();
    getAllDoneDemandList();
  }

  void getAllDoneDemandList()  {
    DemandAPI().getDoneDemandnList().then((value){
      allDoneDemands.value = value;
    });
  }

}

class ArchivedDemandBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArchivedDemandBoardLogic());
  }
}