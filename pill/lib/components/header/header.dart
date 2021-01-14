import 'package:flutter/material.dart';

AppBar customHeader(final headerTitle) {
  return AppBar(
    title: headerTitle.runtimeType != (String).runtimeType ? headerTitle : Text(headerTitle),
    elevation: 1.0,
  );
}

