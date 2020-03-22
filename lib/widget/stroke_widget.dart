import 'package:flutter/material.dart';

///圆角框  widget
///2020年03月23日07:17:33
///xfhy

class StrokeWidget extends StatelessWidget {
  final Color color;
  final Widget childWidget;
  final EdgeInsets edgeInsets;
  final double strokeWidth;
  final double strokeRadius;

  StrokeWidget(
      {this.color = Colors.black,
      @required this.childWidget,
      this.edgeInsets =
          const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
      this.strokeWidth = 1.0,
      this.strokeRadius = 5.0,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets,
      //修饰  背景,边框啥的
      decoration: BoxDecoration(
        border: Border.all(color: color, width: strokeWidth),
        borderRadius: BorderRadius.circular(strokeRadius),
      ),
      child: childWidget,
    );
  }
}
