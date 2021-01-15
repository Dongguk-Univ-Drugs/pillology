import 'package:flutter/material.dart';

AppBar customHeader(final headerTitle) {
  return AppBar(
    title: headerTitle is String ? Text(headerTitle) : headerTitle,
    elevation: 1.0,
  );
}

