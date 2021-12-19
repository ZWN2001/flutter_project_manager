
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class ColorUtil{
  static Color getColorByStatus(int n){
    switch (n){
      case 1 : return Colors.blue;//已创建
      case 2 : return Colors.deepPurpleAccent;//执行中
      case 3 : return Colors.orange;//已拒绝
      case 4 : return Colors.amberAccent;//未通过
      case 5 : return Colors.green;//已完成
      case 6 : return Colors.red;//已超时
    }
    return Colors.white;
  }

  static Color getColorByPriority(int priority){
    switch (priority){
      case 0 : return Colors.grey;
      case 1 : return Colors.green;
      case 2 : return Colors.red;
    }
    return Colors.white;
  }
}