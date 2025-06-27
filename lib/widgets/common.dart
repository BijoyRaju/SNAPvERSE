import 'package:flutter/material.dart';

Widget customText(
  String text,
  double fontSize, {
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
