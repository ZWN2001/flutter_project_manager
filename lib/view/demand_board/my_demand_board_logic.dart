import 'package:admin/controllers/api.dart';
import 'package:get/get.dart';

class MyDemandBoardLogic extends GetxController {
  List allDoingDemands = [];

  @override
  void onInit() {
    super.onInit();
    getAllDoingDemandList();
  }

  Future<void> getAllDoingDemandList() async {
    // await DemandAPI().getDoingDemandnList().then((value){
    //   allDoingDemands = value;
    // });
  }
}

class MyDemandBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyDemandBoardLogic());
  }
}