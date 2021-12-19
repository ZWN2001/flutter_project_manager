//参照i山大格式

import 'package:admin/utils/sharedpreference_util.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connection {
  static Dio _instance =  Dio();
  static SharedPreferences _s = SharedPreferenceUtil.instance;

  static Dio dio() {
      _instance.options.baseUrl = 'http://localhost:8081/';
    return _instance;
  }

  static String? getToken(){
    return _s.getString('token');
  }
}

class UserAPI{
  static String _technicianUrlPOST = 'user/technician';

  Future<List<String>> getTechnicianList() async {
    try {
      Response response = await Connection.dio().post(
          _technicianUrlPOST,
          options: Options(headers: {'token': Connection.getToken()}));
      if(response.data['code'] == 0){
        List<dynamic> data = response.data['data'];
        List<String> result = [];
        data.forEach((element) {
          result.add(element);
        });
        return result;
      }
      return [];
    } on DioError {
      print(DioError);
      return [];
    }
  }

}

class DemandAPI{
  static String _createDemandUrlPOST = '/demand/create';
  static String _doingDemandUrlPOST = '/demand/doing';
  static String _doneDemandUrlPOST = '/demand/done';
  static String _uploadDemandAddressUrlPOST = '/demand/github';
  static String _uploadDemandFileUrlPOST = '/demand/upload';
  static String _downloadDemandFileUrlPOST = '/demand/download';
  static String _changeDemandStatusUrlPOST = '/demand/';

  Future<int> createDemand(String title, String project, String ddl,
      String doer, int priority) async {
    try {
      Response response = await Connection.dio().post(
        _createDemandUrlPOST,
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'title': title,
          'project': project,
          'ddl': ddl,
          'doer' : doer,
          'priority' : priority
        },
      );
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  Future<List<Map>> getDoingDemandnList() async {
    try {
      Response response = await Connection.dio().post(
          _doingDemandUrlPOST,
          options: Options(headers: {'token': Connection.getToken()}));
      if(response.data['code'] == 0){

        List<dynamic> data = response.data['data'];
        List<Map> result = [];
        data.forEach((element) {
          result.add(element);
        });
        print('getDoingDemandnList');
        print(response);
        return result;
      }
      return [];
    } on DioError {
      print(DioError);
      return [];
    }
  }

  Future<String> getDemandFile(int demandID) async {
    try {
      Response response = await Connection.dio().post(
        _downloadDemandFileUrlPOST,
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
        },
      );
      if(response.data['code'] == 0){
        String data = response.data['data'];
        return data;
      }
      return '';
    } on DioError {
      print(DioError);
      return '';
    }
  }
}

class LogAPI{
  static String _getProjectLogUrlPOST = '/log/demand';

  Future<List<Map>> getDemandLog(int id) async {
    try {
      Response response = await Connection.dio().post(
          _getProjectLogUrlPOST,
          options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': id,
        },
      );
      if(response.data['code'] == 0){
        var data = response.data['data'];
        List<Map> result = [];
        data.forEach((element) {
          result.add(element);
        });
        print(id);
        print(response);
        return result;
      }
      return [];
    } on DioError {
      print(DioError);
      return [];
    }
  }
}