import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_detail_bottom_sheet.dart';
import 'package:pill/model/text_search_result.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

Row tabInformationSubItem({String title, String content, double size}) {
  return Row(
      // 약품명 : 가나모티에스알정15mg
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 4,
            child: makeSemiTitle(
                title: title == null ? '입력X' : title,
                color: color333,
                size: size == null ? null : size)),
        Expanded(
            flex: 6,
            child: makeSemiTitle(
                title: content == null ? '정보가 없습니다.' : content,
                color: color777,
                size: size == null ? null : size)),
      ]);
}

Container tabInformation(BuildContext context, {final data, final durData}) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            // 오직 상세정보만
            flex: 2,
            child:
                makeBoldTitle(title: '상세 정보', size: 16.0, color: Colors.black)),
        Expanded(
          // 약품명부터의 리스트 모두
          flex: 8,
          child: Column(
            // 약품명 : ↓↓↓ list
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tabInformationSubItem(
                  title: '약품명', content: data != null ? data.itemName : 'name'),
              tabInformationSubItem(
                  title: '성분/함량',
                  content: durData != null ? durData.mainIngr : 'ingredient'),
              tabInformationSubItem(
                  title: '전문/일반',
                  content: durData != null
                      ? durData.etcOtcCode == '01'
                          ? '전문'
                          : '일반'
                      : 'expert/general'),
              tabInformationSubItem(
                  title: '식약처분류',
                  content:
                      durData != null ? durData.className : 'classification'),
              tabInformationSubItem(
                  title: '품목기준코드',
                  content: durData != null ? durData.itemSeq : 'code'),
              tabInformationSubItem(
                  title: '투여경로',
                  content: data != null ? data.useMethodQesitm : 'how to'),
              tabInformationSubItem(title: '보험정보', content: '준비중'),
            ],
          ),
        )
      ],
    ),
  );
}

// bottom Modal Sheet
_showBottomSheetTabNotion(BuildContext context, final data,
    {String imagePath}) {
  showModalBottomSheet(
      backgroundColor: Color(0x00000000),
      context: context,
      builder: (_) => zoomInTabNotion(context, data, imagePath: imagePath),
      isScrollControlled: true);
}

_showBottomSheetTabDURInfo(BuildContext context, final data,
    {String imagePath}) {
  showModalBottomSheet(
      backgroundColor: Color(0x00000000),
      context: context,
      builder: (_) => zoomInTabDUR(context, data, imagePath: imagePath),
      isScrollControlled: true);
}

// 약품 검색 상세 결과 - 주의 사항
Container tabNotion(BuildContext context, {final data, String imagePath}) {
  ScrollController _controller = new ScrollController();

  int totalLength = data.atpnQesitm.length +
      data.intrcQesitm.length +
      data.seQesitm.length +
      data.depositMethodQesitm.length +
      data.atpnWarnQesitm.length;
  print(totalLength.toString());

  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 8,
                    child: makeBoldTitle(
                        title: '상세 정보', size: 16.0, color: Colors.black)),
                blankBox(flex: 1),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Icon(Icons.zoom_in_rounded,
                          size: 22, color: colorThemeGreen),
                      onPressed: () => _showBottomSheetTabNotion(context, data,
                          imagePath: imagePath),
                    ))
              ],
            )),
        blankBox(flex: 1),
        Expanded(
            flex: 8,
            child: SingleChildScrollView(
                controller: _controller,
                child: Column(children: [
                  tabInformationSubItem(
                      title: '주의사항',
                      content: data != null ? data.atpnQesitm : 'notice'),
                  tabInformationSubItem(
                      title: '상호작용',
                      content: data != null ? data.intrcQesitm : 'interact'),
                  tabInformationSubItem(
                      title: '부작용',
                      content: data != null ? data.seQesitm : 'sideeffect'),
                  tabInformationSubItem(
                      title: '보관법',
                      content:
                          data != null ? data.depositMethodQesitm : 'deposit'),
                  tabInformationSubItem(
                      title: '주의사항 경고',
                      content: data != null ? data.atpnWarnQesitm : 'warning'),
                ])))
      ],
    ),
  );
}

// 약품 검색 상세 결과 - 복용법
Container tabUsage(BuildContext context, {final data}) {
  return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: boxDecorationNoShadow(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                // 오직 상세정보만
                flex: 2,
                child: makeBoldTitle(
                    title: '상세 정보', size: 16.0, color: Colors.black)),
            Expanded(
              // 약품명부터의 리스트 모두
              flex: 8,
              child: Column(
                // 약품명 : ↓↓↓ list
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabInformationSubItem(
                      title: '사용법',
                      content: data != null ? data.useMethodQesitm : 'name'),
                ],
              ),
            )
          ]));
}

// 약품 검색 상세 결과 - 효능/성능
Container tabEfcy(BuildContext context, {final data}) {
  return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: boxDecorationNoShadow(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                // 오직 상세정보만
                flex: 1,
                child: makeBoldTitle(
                    title: '상세 정보', size: 16.0, color: Colors.black)),
            Expanded(
              // 약품명부터의 리스트 모두
              flex: 9,
              child: Column(
                // 약품명 : ↓↓↓ list
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabInformationSubItem(
                      title: '효능',
                      content: data != null ? data.efcyQesitm : 'name'),
                ],
              ),
            )
          ]));
}

// 약품 검색 상세 결과 - DUR 정보
Container tabDURInformation(BuildContext context,
    {final durData, String imagePath}) {
  ScrollController _controller = new ScrollController();

  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 8,
                    child: makeBoldTitle(
                        title: '상세 정보', size: 16.0, color: Colors.black)),
                blankBox(flex: 1),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Icon(Icons.zoom_in_rounded,
                          size: 22, color: colorThemeGreen),
                      onPressed: () => _showBottomSheetTabDURInfo(
                          context, durData,
                          imagePath: imagePath),
                    ))
              ],
            )),
        blankBox(flex: 1),
        Expanded(
            flex: 8,
            child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tabInformationSubItem(
                              title: 'DUR 일련번호',
                              content: durData != null
                                  ? durData.durSeq
                                  : '정보가 없습니다.'),
                          tabInformationSubItem(
                              title: '단일 / 복합',
                              content:
                                  durData != null ? durData.mix : '정보가 없습니다.'),
                          tabInformationSubItem(
                              title: 'DUR 성분명',
                              content: durData != null
                                  ? durData.ingrKorName +
                                      " (${durData.ingrEngName})"
                                  : '정보가 없습니다.'),
                          tabInformationSubItem(
                              title: '금기 내용',
                              content: durData != null
                                  ? durData.prohbtContent
                                  : '정보가 없습니다.')
                        ],
                      )),
                      Divider(color: colorAAA,),
                      // 병용금기 내용 ===============================================
                      SizedBox(
                        height: 10.0,
                      ),
                      makeBoldTitle(
                          title: durData != null ? durData.typeName : 'DUR 유형',
                          size: 16.0,
                          color: colorThemeGreen),
                      SizedBox(
                        height: 8.0,
                      ),
                      // 병용금기 관련 내용
                      durData.typeName == '병용금기'
                          ? Container(
                              // padding: EdgeInsets.only(
                              //     left:
                              //         MediaQuery.of(context).size.width * 0.025),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 병용금기 DUR 번호 --------------------------
                                durData.mixtureDurSeq != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 DUR 번호',
                                        content: durData.mixtureDurSeq)
                                    : SizedBox(),
                                // 병용금기 DUR 성분명 --------------------------
                                durData.mixtureIngrKorName != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 DUR 성분명',
                                        content: durData.mixtureIngrKorName)
                                    : SizedBox(),
                                // 병용금기 품목 기준 코드 --------------------------
                                durData.mixtureItemSeq != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 품목 기준 코드',
                                        content: durData.mixtureItemSeq)
                                    : SizedBox(),
                                // 병용금기 품목명 --------------------------
                                durData.mixtureItemName != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 품목명',
                                        content: durData.mixtureItemName)
                                    //: '정보가 없습니다.',
                                    : SizedBox(),
                                // 병용금기 DUR 번호 --------------------------
                                durData.mixtureFormName != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 제형',
                                        content: durData.mixtureFormName)
                                    : SizedBox(),
                                // 병용금기 전문 / 일반 --------------------------
                                durData.mixtureEtcOtcName != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 전문 / 일반',
                                        content: durData.mixtureEtcOtcName)
                                    : SizedBox(),
                                // 병용금기 약효분류 --------------------------
                                durData.mixtureClassName != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 약효 분류',
                                        content: durData.mixtureClassName)
                                    : SizedBox(),
                                // 병용금기 주성분 --------------------------
                                durData.mixtureMainIngr != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 주성분',
                                        content: durData.mixtureMainIngr)
                                    : SizedBox(),
                                // 병용금기 성상
                                durData.mixtureChart != null
                                    ? tabInformationSubItem(
                                        title: '병용금기 성상',
                                        content: durData.mixtureChart)
                                    : SizedBox()
                              ],
                            ))
                          : SizedBox(),
                    ])))
      ],
    ),
  );
}
