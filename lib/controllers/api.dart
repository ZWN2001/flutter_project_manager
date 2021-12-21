//参照i山大格式
import 'dart:html' as html;
import 'package:admin/utils/sharedpreference_util.dart';
import 'package:dio/dio.dart' ;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  static String _uploadDemandFileUrlPOST = 'http://localhost:8081/demand/upload';
  static String _downloadDemandFileUrlPOST = '/demand/download';
  static String _changeDemandStatusUrlPOST = '/demand/';
  static String _sendEmailUrlPOST = '/demand/email';

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
        return result;
      }
      return [];
    } on DioError {
      print(DioError);
      return [];
    }
  }

  Future<List<Map>> getDoneDemandnList() async {
    try {
      Response response = await Connection.dio().post(
          _doneDemandUrlPOST,
          options: Options(headers: {'token': Connection.getToken()}));
      if(response.data['code'] == 0){
        List<dynamic> data = response.data['data'];
        List<Map> result = [];
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

  void sendDemandFile(int id){
    try {
        html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
        uploadInput.multiple = false;
        uploadInput.click();
        uploadInput.onChange.listen((e) async {
          final files = uploadInput.files;
          _sendFormData(files![0], id);
          //flutter不支持dart:io
          // FormData formdata = FormData.fromMap({
          //   "file": await MultipartFile.fromFile(files![0].relativePath!, filename: files[0].name)
          // });
          // await Connection.dio().post(
          //     _uploadDemandFileUrlPOST,
          //     options: Options(headers:{'token':Connection.getToken()}),
          //     queryParameters: {
          //       'denamd_id': id,
          //     },
          //   data: formdata
          // ).then((value){
          //   if(value.data['code'] == 0){
          //     Fluttertoast.showToast(
          //       msg: "success",
          //       toastLength: Toast.LENGTH_LONG,
          //       gravity: ToastGravity.BOTTOM,
          //       // backgroundColor: Colors.redAccent,
          //     );
          //   }
          // });
        });
    }on Error{
    }
  }

  _sendFormData(final html.File file,int id) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    final html.FormData formData = html.FormData()
      ..appendBlob('uploadFile', file)
      ..append('demand_id', '$id');

    Fluttertoast.showToast(
      msg: "success",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
    );
    // handleRequest(html.HttpRequest httpRequest) {
    //   switch (httpRequest.status) {
    //     case 200:
    //       return;
    //     default:
    //       break;
    //   }
    // }
    //
    // html.HttpRequest.request(
    //   _uploadDemandFileUrlPOST,
    //   method: 'POST',
    //   requestHeaders: {'token': Connection.getToken()!},
    //   sendData: formData,
    // ).then((httpRequest) {
    //   handleRequest(httpRequest);
    // }).catchError((e) {
    //   print(e.toString());
    // });
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
        var data = response.data['data'];
        if(data == null){
          return '';
        }
        return data;
      }
      return '';
    } on DioError {
      print(DioError);
      return '';
    }
  }

  Future<int> uploadDemandAddres(int id,String address,String commit) async {
    try {
      Response response = await Connection.dio().post(
        _uploadDemandAddressUrlPOST,
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': id,
          'address': address,
          'commit': commit,
        },
      );
      return response.data['code'];
    } on DioError {
      print(DioError);
      return -1;
    }
  }
  Future<int> sendEmail({required String to, required String subject, required String text}) async {
    try {
      Response response = await Connection.dio().post(
        _sendEmailUrlPOST,
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'to':to,
          'subject':subject,
          'text':text
        },
      );
      return response.data['code'];
    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //技术接受需求
  Future<int> managerAcceptDemandUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from1to2',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      //给产品发邮件
      sendEmail(
        to:cer,
        subject: '技术接受了你的需求',
        text: '你的需求已被接受\n'+
          '$doer接受了你的需求，需求ID为：$demandID\n'+
          '留言如下：\n'+ (commit.isEmpty?'无':commit)
      );
      print('managerAcceptDemandUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //技术拒绝需求
  Future<int> managerRejectDemandUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from1to3',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      //给产品发邮件
      sendEmail(
          to:cer,
          subject: '技术拒绝了你的需求',
          text: '你的需求已被拒绝\n'+
              '$doer拒绝了你的需求，需求ID为：$demandID\n'+
              '留言如下：\n'+ (commit.isEmpty?'无':commit)
      );
      print('managerRejectDemandUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //技术完成需求
  Future<int> managerFinishDemandUrlPOST(int demandID, String cer, String doer, String commit,String address) async {
    try {
      int n = 0;
      //给产品发邮件
      sendEmail(
          to:cer,
          subject: '技术完成了你的需求',
          text: '$doer完成了你的需求，需求ID为：$demandID\n'+
              '留言如下：\n'+ (commit.isEmpty?'无':commit)+
              '\n项目地址为：$address'
      ).then((value) => n = value);
      return n;

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //产品不通过技术的完成结果
  Future<int> createrRejectResultUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from2to4',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      //给技术发邮件
      sendEmail(
          to: doer,
          subject: '产品没有通过你的提交',
          text: '你的提交已被退回\n'+
              '$doer拒绝了你的提交，需求ID为：$demandID\n'+
              '留言如下：\n'+ (commit.isEmpty?'无':commit)
      );
      print('createrRejectResultUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //产品通过技术的完成结果，项目完成
  Future<int> createrAcceptResultUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from2to5',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      //给产品发邮件
      sendEmail(
          to: doer,
          subject: '技术接受了你的提交结果',
          text: '你的提交已被接受\n'+
              '$doer接受了你的提交结果，需求ID为：$demandID\n'+
              '留言如下：\n'+ (commit.isEmpty?'无':commit)
      );
      print('createrAcceptResultUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //从执行中到超时
  Future<int> timeOutFromDoingUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from2to6',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      sendEmail(
          to: cer,
          subject: '你的需求已超时',
          text: '你的需求已超时，需求ID为：$demandID\n'
      );
      sendEmail(
          to: doer,
          subject: '你的需求已超时',
          text: '你的需求已超时，需求ID为：$demandID\n'
      );
      print('timeOutFromDoingUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //从未通过到接受
  Future<int> createrAcceptedFromRejectedUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from4to5',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      //给产品发邮件
      sendEmail(
          to: doer,
          subject: '技术接受了你的提交结果',
          text: '你的提交已被接受\n'+
              '$doer接受了你的提交结果，需求ID为：$demandID\n'+
              '留言如下：\n'+ (commit.isEmpty?'无':commit)
      );
      print('createrAcceptedFromRejectedUrlPOST');
      print(response);
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
    }
  }

  //从未通过到超时
  Future<int> timeOutFromCreaterRejectedUrlPOST(int demandID, String cer, String doer, String commit) async {
    try {
      Response response = await Connection.dio().post(
        _changeDemandStatusUrlPOST+'from4to6',
        options: Options(headers: {'token': Connection.getToken()}),
        queryParameters: {
          'demand_id': demandID,
          'commit': commit,
        },
      );
      sendEmail(
          to: cer,
          subject: '你的需求已超时',
          text: '你的需求已超时，需求ID为：$demandID\n'
      );
      sendEmail(
          to: doer,
          subject: '你的需求已超时',
          text: '你的需求已超时，需求ID为：$demandID\n'
      );
      return response.data['code'];

    } on DioError {
      print(DioError);
      return -1;
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