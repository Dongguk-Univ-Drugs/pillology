import 'package:flutter/material.dart';

Widget zoomInTabNotion(BuildContext context, final data) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.9,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    padding: EdgeInsets.all(20.0),
    child: SizedBox(),
  );
}
