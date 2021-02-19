import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_detail_tabview.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

Widget zoomInTabNotion(BuildContext context, final data, {String imagePath}) {
  ScrollController _controller = new ScrollController();

  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_down_rounded,
                  size: 30, color: colorAAA),
            ),
          ),
          Expanded(
              flex: 9,
              child: SingleChildScrollView(
                controller: _controller,
                child: data != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: imagePath == null
                                      ? Image.asset(
                                          'assets/icons/pill.png',
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        )
                                      : Image.network(imagePath,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300))),
                          tabInformationSubItem(
                              title: '주의사항',
                              content:
                                  data != null ? data.atpnQesitm : 'notice',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '상호작용',
                              content:
                                  data != null ? data.intrcQesitm : 'interact',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '부작용',
                              content:
                                  data != null ? data.seQesitm : 'sideeffect',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '보관법',
                              content: data != null
                                  ? data.depositMethodQesitm
                                  : 'deposit',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '주의사항 경고',
                              content: data != null
                                  ? data.atpnWarnQesitm
                                  : 'warning',
                              size: 14.0),
                        ],
                      )
                    : makeBoldTitle(title: '정보가 없습니다.'),
              ))
        ],
      ));
}

Widget zoomInTabDUR(BuildContext context, final durData, {String imagePath}) {
  ScrollController _controller = new ScrollController();

  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_down_rounded,
                  size: 30, color: colorAAA),
            ),
          ),
          Expanded(
              flex: 9,
              child: SingleChildScrollView(
                controller: _controller,
                child: durData != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: imagePath == null
                                      ? Image.asset(
                                          'assets/icons/pill.png',
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        )
                                      : Image.network(imagePath,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300))),
                          tabInformationSubItem(
                              title: 'DUR 일련번호',
                              content: durData != null
                                  ? durData.durSeq
                                  : '정보가 없습니다.',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '단일 / 복합',
                              content:
                                  durData != null ? durData.mix : '정보가 없습니다.',
                              size: 14.0),
                          tabInformationSubItem(
                              title: 'DUR 성분명',
                              content: durData != null
                                  ? durData.ingrKorName
                                  : '정보가 없습니다.',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '금기 내용',
                              content: durData != null
                                  ? durData.prohbtContent
                                  : '정보가 없습니다.',
                              size: 14.0),
                          tabInformationSubItem(
                              title: '복합체',
                              content: durData != null
                                  ? durData.mixIngr
                                  : '정보가 없습니다.',
                              size: 14.0),
                          SizedBox(
                            height: 10.0,
                          ),
                          makeBoldTitle(
                              title:
                                  durData != null ? durData.typeName : 'DUR 유형',
                              size: 16.0,
                              color: colorThemeGreen),
                          SizedBox(
                            height: 8.0,
                          ),
                          // 병용금기 관련 내용
                          durData.typeName == '병용금기'
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      tabInformationSubItem(
                                          title: '병용금기 DUR 번호',
                                          content: durData != null
                                              ? durData.mixtureDurSeq
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 DUR 성분명',
                                          content: durData != null
                                              ? durData.mixtureIngrKorName
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 품목 기준 코드',
                                          content: durData != null
                                              ? durData.mixtureItemSeq
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 품목명',
                                          content: durData != null
                                              ? durData.mixtureItemName
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 제형',
                                          content: durData != null
                                              ? durData.mixtureFormName
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 전문 / 일반',
                                          content: durData != null
                                              ? durData.mixtureEtcOtcName
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 약효 분류',
                                          content: durData != null
                                              ? durData.mixtureClassName
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                      tabInformationSubItem(
                                          title: '병용금기 주성분',
                                          content: durData != null
                                              ? durData.mixtureMainIngr
                                              : '정보가 없습니다.',
                                          size: 14.0),
                                    ],
                                  ))
                              : SizedBox(),
                        ],
                      )
                    : makeBoldTitle(title: '정보가 없습니다.'),
              ))
        ],
      ));
}
