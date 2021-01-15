import 'package:flutter/material.dart';
import 'package:pill/utility/textify.dart';

AppBar customHeader(final headerTitle) {
  return AppBar(
    title: headerTitle is String ? makeAppTitle(headerTitle) : headerTitle,
    elevation: 1.0,
  );
}

