import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pill/utility/palette.dart';

BoxShadow boxShadow01() {
  return BoxShadow(
      color: Colors.black.withOpacity(0.16),
      offset: Offset(0,0.3),
      blurRadius: 3.0);
}

BoxDecoration boxDecorationMain() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: colorEEE),
      boxShadow: [boxShadow01()]);
}

BoxDecoration boxDecorationNoShadow() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: colorEEE),
  );
}

DottedBorder dottedBorderContainer(final childWidget) {
  return DottedBorder(
    borderType: BorderType.RRect,
    color: colorEEE,
    radius: Radius.circular(20.0),
    dashPattern: [12,6],
    strokeWidth: 3.0,
    child: Center(child: childWidget),
  );
}

Expanded blankBox({int flex}) {
  return Expanded(flex:flex == null ? 1 : flex, child:SizedBox());
}