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

BoxDecoration boxDecorationNoShadow({Color color, int border}) {
  return BoxDecoration(
    color: color == null ? Colors.white : color,
    borderRadius: BorderRadius.circular(20),
    border: border == 0 || border == null ? Border.all(color: colorEEE) : Border.all(color: Colors.transparent),
  );
}

DottedBorder dottedBorderContainer(final childWidget) {
  return DottedBorder(
    borderType: BorderType.RRect,
    color: childWidget != 'assets/icons/pill.png' ? colorThemeGreen : colorEEE,
    radius: Radius.circular(20.0),
    dashPattern: [12,6],
    strokeWidth: 3.0,
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(childWidget, width: 250, height: 250, fit: BoxFit.cover),
      )
    ),
  );
}

Expanded blankBox({int flex}) {
  return Expanded(flex:flex == null ? 1 : flex, child:SizedBox());
}