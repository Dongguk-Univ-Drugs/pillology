import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/text/text_data.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/input_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class TextSearch extends StatefulWidget {
  @override
  _TextSearchState createState() => _TextSearchState();
}

class _TextSearchState extends State<TextSearch> {
  final _scrollController = ScrollController();
  final pillNameController = TextEditingController();

  // 선택사항 - 의약품 정보 -> total
  var textInfoJson = <String, String>{
    "성분명": "",
    "회사명": "",
    "제품코드": "",
    "복지부분류": "",
    "구분": ""
  };
  var optionTextOpen = true;

  // 선택사항 - 모양 정보 -> total
  var shapeInfoJson = <String, dynamic>{
    '식별표시앞': '',
    '식별표시뒤': '',
    '제형': '',
    '모양': '',
    '색상': ''
  };
  var optionShapeOpen = true;

  int _slidingVal = 0;

  @override
  void initState() {
    super.initState();
  }

  void openOptions(int index) {
    if (index == 0) {
      setState(() {
        optionTextOpen = !optionTextOpen;
      });
    } else {
      setState(() {
        optionShapeOpen = !optionShapeOpen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customHeader(makeAppTitle("텍스트로 검색하기")),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // blankBox(flex: 1),
                      // 제품명 -> 필수사항
                      Expanded(
                          flex: 1,
                          child: inputFormRowItem(
                              '제품명',
                              TextFormField(
                                controller: pillNameController,
                                decoration:
                                    inputDecoration('한글 또는 영문 제품명을 입력해주세요.'),
                              ))),

                      // > 선택사항 - 의약품 정보
                      // 성분명
                      // 제조회사명
                      // 제품코드
                      // 복지부분류 - 100 ~ 800
                      // 구분 : 전체, 전문, 일반
                      Expanded(
                        flex: !optionTextOpen ? 1 : 6,
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              curve: Curves.fastOutSlowIn,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: !optionTextOpen
                                  ? MediaQuery.of(context).size.width * 0.08
                                  : MediaQuery.of(context).size.height * 0.3,
                              duration: Duration(milliseconds: 500),
                              top: !optionTextOpen
                                  ? MediaQuery.of(context).size.width * 0.08
                                  : MediaQuery.of(context).size.width * 0.12,
                              child: optionalInfoTextContent(context),
                            ),
                            Positioned(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                top: 0.0,
                                child: optionalInfoText(context)),
                          ],
                        ),
                      ),
                      // !optionTextOpen
                      //     ? SizedBox()
                      //     : Expanded(
                      //         flex: 3, child: optionalInfoTextContent(context)),
                      // > 선택사항 - 약품 모형 정보
                      // 식별표시 앞
                      // 식별표시 뒤
                      // 제형 : 정제, 경질캡슐, 연질캡슐
                      // 모양 : 11개
                      // 색상 : 16가지
                      // 마크 : 픽토그램
                      Expanded(
                        flex: !optionShapeOpen ? 1 : 6,
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              curve: Curves.fastOutSlowIn,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: !optionShapeOpen
                                  ? MediaQuery.of(context).size.width * 0.08
                                  : MediaQuery.of(context).size.height * 0.3,
                              duration: Duration(milliseconds: 500),
                              top: !optionShapeOpen
                                  ? MediaQuery.of(context).size.width * 0.08
                                  : MediaQuery.of(context).size.width * 0.12,
                              child: optionalInfoShapeContent(context),
                            ),
                            Positioned(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                top: 0.0,
                                child: optionalInfoShape(context)),
                          ],
                        ),
                      ),
                      // 검색하기

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: colorThemeGreen),
                        child: makeBoldTitle(
                            title: '검색하기', size: 18.0, color: Colors.white),
                        onPressed: () => print(textInfoJson.toString() +
                            '\n' +
                            shapeInfoJson.toString()),
                      ),
                      blankBox(flex: 1)
                    ])),
          ),
        ));
  }

  Widget optionalInfoText(BuildContext context) {
    return GestureDetector(
        onTap: () => openOptions(0),
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.05),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.025),
            decoration: boxDecorationNoShadow(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 7,
                    child:
                        makeSemiTitle(title: '선택사항 - 의약품 정보', color: color333)),
                blankBox(flex: 2),
                Expanded(
                    flex: 1,
                    child: ImageIcon(AssetImage(!optionTextOpen
                        ? 'assets/icons/chevron-forward-outline.png'
                        : 'assets/icons/chevron-down-outline.png')))
              ],
            )));
  }

  Widget optionalInfoTextContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.025),
      decoration: boxDecorationNoShadow(color: colorEEE),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: textInfoJson.keys.toList().length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (textInfoJson.keys.elementAt(index) == '복지부분류') {
            return inputFormRowItem(
                textInfoJson.keys.elementAt(index),
                TextButton(
                  onPressed: () => _showPicker(
                      context, textInfoJson, index, textInfoSubDropDownItem),
                  child: textInfoJson[textInfoJson.keys.elementAt(index)]
                              .length ==
                          0
                      ? makeSemiTitle(title: '선택하기')
                      : makeSemiTitle(
                          title:
                              textInfoJson[textInfoJson.keys.elementAt(index)]),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      primary: colorThemeGreen),
                ));
          } else if (textInfoJson.keys.elementAt(index) == '구분') {
            return inputFormRowItem(
                textInfoJson.keys.elementAt(index),
                TextButton(
                  onPressed: () => _showPicker(
                      context, textInfoJson, index, textInfoSubDropDownItem2),
                  child: textInfoJson[textInfoJson.keys.elementAt(index)]
                              .length ==
                          0
                      ? makeSemiTitle(title: '선택하기')
                      : makeSemiTitle(
                          title:
                              textInfoJson[textInfoJson.keys.elementAt(index)]),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      primary: colorThemeGreen),
                ));
          } else {
            return inputFormRowItem(
                textInfoJson.keys.elementAt(index),
                TextFormField(
                  decoration: inputDecoration(
                      textInfoJson.keys.elementAt(index) + " 를 입력해주세요."),
                  onChanged: (value) {
                    setState(() {
                      textInfoJson[textInfoJson.keys
                          .elementAt(index)
                          .toString()] = value;
                    });
                  },
                ));
          }
        },
      ),
    );
  }

  Widget optionalInfoShape(BuildContext context) {
    return GestureDetector(
        onTap: () => openOptions(1),
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.05),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.025),
            decoration: boxDecorationNoShadow(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 7,
                    child:
                        makeSemiTitle(title: '선택사항 - 모형 정보', color: color333)),
                blankBox(flex: 2),
                Expanded(
                    flex: 1,
                    child: ImageIcon(AssetImage(!optionShapeOpen
                        ? 'assets/icons/chevron-forward-outline.png'
                        : 'assets/icons/chevron-down-outline.png')))
              ],
            )));
  }

  Widget optionalInfoShapeContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.025),
      decoration: boxDecorationNoShadow(color: colorEEE),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: shapeInfoJson.keys.toList().length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (shapeInfoJson.keys.elementAt(index) == '색상') {
            return inputFormRowItem(
                shapeInfoJson.keys.elementAt(index),
                TextButton(
                  onPressed: () => _showBottomSheetColorPicker(context),
                  child: makeSemiTitle(
                      title: 'RGB ' +
                          shapeInfoJson[shapeInfoJson.keys.elementAt(index)]),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      primary: colorThemeGreen),
                ));
          } else if (shapeInfoJson.keys.elementAt(index) == '제형') {
            return inputFormRowItem(
                shapeInfoJson.keys.elementAt(index),
                CupertinoSlidingSegmentedControl(
                    children: {
                      0: makeSemiTitle(title: '정제'),
                      1: makeSemiTitle(title: '경질캡슐'),
                      2: makeSemiTitle(title: '연질캡슐')
                    },
                    groupValue: _slidingVal,
                    onValueChanged: (value) {
                      setState(() {
                        shapeInfoJson[shapeInfoJson.keys.elementAt(index)] =
                            shapeInfoSubSlidingSegmentedData[value];
                        _slidingVal = value;
                      });
                    }));
          } else if (shapeInfoJson.keys.elementAt(index) == '모양') {
            return inputFormRowItem(
                shapeInfoJson.keys.elementAt(index),
                TextButton(
                  onPressed: () => _showBottomSheetShapePicker(context),
                  child: makeSemiTitle(
                      title: shapeInfoJson[shapeInfoJson.keys.elementAt(index)]
                                  .length ==
                              0
                          ? '선택하기'
                          : shapeInfoJson[shapeInfoJson.keys.elementAt(index)]),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      primary: colorThemeGreen),
                ));
          } else {
            return inputFormRowItem(
                shapeInfoJson.keys.elementAt(index),
                TextFormField(
                  decoration: inputDecoration(
                      shapeInfoJson.keys.elementAt(index) + " 를 입력해주세요."),
                  onChanged: (value) {
                    setState(() {
                      shapeInfoJson[shapeInfoJson.keys.elementAt(index)] =
                          value;
                    });
                  },
                ));
          }
        },
      ),
    );
  }

  _showPicker(BuildContext context, Map<String, String> data, int index,
      final itemData) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: inputFromDropDown(data, index, itemData),
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: inputFromDropDown(data, index, itemData),
              ));
    }
  }

  _showBottomSheetColorPicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0x00000000),
        context: context,
        builder: optionalInfoShapeContentColorPicker);
  }

  _showBottomSheetShapePicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0x00000000),
        context: context,
        builder: optionalInfoShapeContentShapePicker);
  }

  Widget optionalInfoShapeContentColorPicker(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          makeBoldTitle(title: '색상 고르기', size: 16.0, color: color333),
          SizedBox(
            height: 20.0,
          ),
          GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: shapeInfoSubDropDownItemColor.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          shapeInfoJson['색상'] =
                              (shapeInfoSubDropDownItemColor[index]['name']);
                        });
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: makeSemiTitle(
                            title: shapeInfoSubDropDownItemColor[index]['name'],
                            size: MediaQuery.of(context).size.width * 0.035,
                            color: shapeInfoSubDropDownItemColor[index]
                                            ['name'] ==
                                        '하양'
                                ? color777
                                : Colors.white,
                            textAlign: TextAlign.center),
                      ),
                      backgroundColor: shapeInfoSubDropDownItemColor[index]
                          ['color'],
                      elevation: 1.0,
                      heroTag: null,
                    ),
                    Offstage(
                      offstage: index != shapeInfoJson['색상'],
                      child: Text("Color Name"),
                    ),
                  ],
                ),
              );
            },
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  Widget optionalInfoShapeContentShapePicker(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          makeBoldTitle(title: '모양 고르기', size: 16.0, color: color333),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: shapeInfoSubDropDownItemShape.keys.toList().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  children: <Widget>[
                    new FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          shapeInfoJson['모양'] = shapeInfoSubDropDownItemShape
                              .keys
                              .elementAt(index);
                        });
                        Navigator.pop(context);
                      },
                      // child: Icon(Icons.done,
                      //     color: shapeInfoSubDropDownItemShape.keys
                      //                 .elementAt(index) ==
                      //             shapeInfoJson['모양']
                      //         ? colorThemeGreen
                      //         : Colors.white,
                      //     size: 24),
                      child:
                          shapeInfoSubDropDownItemShape.values.elementAt(index),
                      backgroundColor: color777,
                      elevation: 1.0,
                      heroTag: null,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    makeSemiTitle(
                        title:
                            shapeInfoSubDropDownItemShape.keys.elementAt(index))
                  ],
                ),
              );
            },
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  CupertinoPicker inputFromDropDown(
      Map<String, String> data, int index, final itemData) {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 30,
      scrollController: FixedExtentScrollController(initialItem: 1),
      children: itemData,
      onSelectedItemChanged: (value) {
        setState(() {
          data[data.keys.elementAt(index)] = itemData[value].data;
        });
      },
    );
  }
}

Row inputFormRowItem(String title, Widget textFormField) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
          flex: textFormField.runtimeType is DropdownButton ? 4 : 3,
          child: makeSemiTitle(title: title, color: color333, size: 14.0)),
      Expanded(
          flex: textFormField.runtimeType is DropdownButton ? 6 : 7,
          child: textFormField)
    ],
  );
}
