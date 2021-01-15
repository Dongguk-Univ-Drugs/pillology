import 'package:flutter/material.dart';
import 'package:pill/utility/palette.dart';

Text makeBoldTitle(String title) {
  return Text(
    title,
    style: TextStyle(color: color777, fontWeight: FontWeight.bold, fontSize: 12.0),
  );
}
Text makeBoldTitleWithSize(String title, double size, TextAlign textAlign) {
  return Text(
    title,
    style: TextStyle(color: color777, fontWeight: FontWeight.bold, fontSize: size),
    textAlign: textAlign,
  );
}

Text makeSemiTitle(String title) {
  return Text(
    title,
    style: TextStyle(color: color777, fontWeight: FontWeight.w600, fontSize: 12.0),
  );
}

RichText makeTitleWithColor({String normalStart, String emphasize, String normalEnd, Color color}) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: normalStart + " ", style: TextStyle(color: colorTitle, fontSize: 16.0, fontWeight: FontWeight.w800)),
        TextSpan(text: emphasize, style: TextStyle(color: color, fontSize: 18.0, fontWeight: FontWeight.w900)),
        TextSpan(text: " " + normalEnd, style: TextStyle(color: colorTitle, fontSize: 16.0, fontWeight: FontWeight.w800)),
      ]
    ),
  );
}

Text makeContent(String content) {
  return Text(
    content,
    style: TextStyle(color: color777, fontSize: 11.0),
  );
}