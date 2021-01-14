import 'package:flutter/material.dart';
// palette
import './palette.dart';

InputDecoration inputDecoration(final hintText) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colorAAA)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colorAAA)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colorAAA)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red[400])),
      contentPadding: EdgeInsets.fromLTRB(15.0, 2.0, 5.0, 2.0),
      hintText: hintText,
      hintStyle: TextStyle(color: colorAAA, fontWeight: FontWeight.w600, fontSize: 13.0)
  );
}
