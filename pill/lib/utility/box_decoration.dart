import 'package:flutter/material.dart';
import 'package:pill/utility/palette.dart';

BoxShadow boxShadow01() {
  return BoxShadow(
      color: Colors.black.withOpacity(0.16),
      offset: Offset(0.0, 1.0),
      blurRadius: 3.0);
}

BoxDecoration boxDecorationMain() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: colorEEE),
      boxShadow: [boxShadow01()]);
}
