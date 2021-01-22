import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/utility/textify.dart';

class PersonalHealthInfoPage extends StatefulWidget {
  @override
  _PersonalHealthInfoPageState createState() => _PersonalHealthInfoPageState();
}

class _PersonalHealthInfoPageState extends State<PersonalHealthInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader(makeAppTitle("나의 건강 정보 관리")),
      body: Center(),
    );
  }
}
