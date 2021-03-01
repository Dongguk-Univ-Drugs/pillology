import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class PersonalHealthInfoPage extends StatefulWidget {
  @override
  _PersonalHealthInfoPageState createState() => _PersonalHealthInfoPageState();
}

class _PersonalHealthInfoPageState extends State<PersonalHealthInfoPage> {
  List _personalDiseaseList;
  List _personalAllergyList;
  @override
  void initState() {
    super.initState();
    _personalDiseaseList = ['아토피', '천식'];
    _personalAllergyList = ['계란', '땅콩', '갑각류'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader(makeAppTitle("나의 건강 정보 관리")),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                    "해당 정보는 약사와의 빠른 상담을 위한 것으로,\n앱 내 다른 기능 사용과 연관이 없습니다.",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            makeBoldTitle(
                                title: '질병', size: 18.0, color: Colors.black),
                            IconButton(
                                icon:
                                    Image.asset('assets/icons/add-outline.png'),
                                iconSize: 20,
                                onPressed: () {})
                          ],
                        )),
                    Expanded(flex: 6, child: _diseaseList())
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            makeBoldTitle(
                                title: '알레르기', size: 18.0, color: Colors.black),
                            IconButton(
                                icon:
                                    Image.asset('assets/icons/add-outline.png'),
                                iconSize: 20,
                                onPressed: () {})
                          ],
                        )),
                    Expanded(flex: 6, child: _allergyList())
                  ],
                ),
              ),
              Expanded(flex: 2, child: SizedBox())
            ],
          )),
    );
  }

  Widget _diseaseList() {
    return ListView(
      children: _personalDiseaseList
          .map((diseaseName) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(diseaseName.toString()),
                ),
              ))
          .toList(),
    );
  }

  Widget _allergyList() {
    return ListView(
      children: _personalAllergyList
          .map((allergyName) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(allergyName.toString()),
                ),
              ))
          .toList(),
    );
  }
}
