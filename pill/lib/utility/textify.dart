import 'package:flutter/material.dart';
import 'package:pill/utility/palette.dart';

Text makeBoldTitle({String title, double size, Color color}) {
  return Text(
    title,
    style: TextStyle(
        color: color == null ? color777 : color,
        fontWeight: FontWeight.bold,
        fontSize: size == null ? 12.0 : size),
  );
}

Text makeBoldTitleWithSize(String title, double size, TextAlign textAlign) {
  return Text(
    title,
    style:
        TextStyle(color: color777, fontWeight: FontWeight.bold, fontSize: size),
    textAlign: textAlign,
  );
}

Text makeSemiTitle(
    {String title, TextAlign textAlign, Color color, double size}) {
  return Text(
    title,
    style: TextStyle(
        color: color == null ? color777 : color,
        fontWeight: FontWeight.w600,
        fontSize: size == null ? 12.0 : size),
    textAlign: textAlign == null ? TextAlign.start : textAlign,
  );
}

RichText makeTitleWithColor(
    {String normalStart, String emphasize, String normalEnd, Color color}) {
  return RichText(
    text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: normalStart + " ",
          style: TextStyle(
              color: colorTitle, fontSize: 16.0, fontWeight: FontWeight.w800)),
      TextSpan(
          text: emphasize,
          style: TextStyle(
              color: color, fontSize: 18.0, fontWeight: FontWeight.w900)),
      TextSpan(
          text: " " + normalEnd,
          style: TextStyle(
              color: colorTitle, fontSize: 16.0, fontWeight: FontWeight.w800)),
    ]),
  );
}

Text makeContent(String content) {
  return Text(
    content,
    style: TextStyle(color: color777, fontSize: 11.0),
  );
}

Text makeAppTitle(String title) {
  return Text(
    title,
    style: TextStyle(color: Colors.black, fontSize: 17.0, fontFamily: 'Gimpo'),
  );
}
