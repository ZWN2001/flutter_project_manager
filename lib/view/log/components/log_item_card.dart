import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogItemCard extends StatelessWidget {
  final String senderName;
  final String commitContent;
  final String time;
  final String projectName;

  LogItemCard(
      {Key? key,
      required this.senderName,
      required this.commitContent,
      required this.projectName,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 16, right: 16),
      constraints: BoxConstraints(
        minHeight: 50,
        // maxHeight: 180,
        minWidth: 600,
        maxWidth: 600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: new Border.all(color: Colors.white54, width: 0.5),
        gradient: LinearGradient(
          colors: [
            Color(0xff292b49),
            Color(0xFF161B24),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        // color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      senderName.substring(0, 1),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(senderName, style: TextStyle(fontSize: 18)),
                    Text(time,
                        style: TextStyle(fontSize: 12, color: Colors.white54)),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  projectName,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50, top: 8),
            // color: Colors.white12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 80),
                  child: Text(
                    commitContent,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
