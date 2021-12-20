import 'package:flutter/material.dart';

class BasicCard extends StatefulWidget {

  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final Function() onTap;

  BasicCard({
    this.shape,
    this.margin,
    required this.child,
    required this.onTap
  });

  @override
  _BasicCardState createState() =>_BasicCardState();
}
class _BasicCardState extends State<BasicCard>{
  Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: Container(
          child:Card(
            color: cardColor,
            shape:widget.shape==null ? RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))):widget.shape, //设置圆角
            // elevation: basicCardLogic.elevation.value,
            margin: widget.margin,
            child: widget.child,
          ),
        ),
        onHover: (value){
          setState(() {
            cardColor = value ? Colors.white54 : Colors.white;
          });
      },
    );
  }
}