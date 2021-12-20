import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil{
  static void showCommonDialog({required BuildContext context,
    required Widget child, required String title}){
    showDialog(
      context: context,
      builder: (context) {
        return  SimpleDialog(
          title: Text(title),
          children:[
            GestureDetector(
              child:  SingleChildScrollView(
                child: child,
              ) ,
              onTap: ()=> Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  static Future<bool?> showConfirmDialog({required BuildContext context,
    required Widget child, required String title}){
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return  AlertDialog(
          title: Text(title),
          content: GestureDetector(
            child:  SingleChildScrollView(
              child: child,
            ) ,
            onTap: ()=> Navigator.pop(context),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(false), // 关闭对话框
            ),
            TextButton(
              child: Text(
                  "确认",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}