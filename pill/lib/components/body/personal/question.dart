import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/utility/textify.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customHeader(makeAppTitle("문의하기")),
        body: Center(
          child: Text("문의하기"),
        ));
  }
}
