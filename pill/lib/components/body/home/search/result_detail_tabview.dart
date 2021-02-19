import 'package:flutter/material.dart';
import 'package:pill/model/text_search_result.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

Row tabInformationSubItem({String title, String content}) {
  return Row(
      // 약품명 : 가나모티에스알정15mg
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: makeSemiTitle(
                title: title == null ? '입력X' : title, color: color333)),
        Expanded(
            flex: 7,
            child: makeSemiTitle(
                title: content == null ? '정보가 없습니다.' : content,
                color: color777)),
      ]);
}

Container tabInformation(BuildContext context, {final data}) {
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
              tabInformationSubItem(title: '성분/함량', content: '준비중'),
              tabInformationSubItem(title: '전문/일반', content: '준비중'),
              tabInformationSubItem(title: '식약처분류', content: '준비중'),
              tabInformationSubItem(
                  title: '품목기준코드',
                  content: data != null ? data.itemSeq : 'code'),
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

// 약품 검색 상세 결과 - 주의 사항
Container tabNotion(BuildContext context, {final data}) {
  ScrollController _controller = new ScrollController();

  // print(data.atpnQesitm.runtimeType.toString() + " \t" + data.atpnQesitm.length.toString());

  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: SingleChildScrollView(
        controller: _controller,
        child: Container(
            width: MediaQuery.of(context).size.width,
            // height: data.atpnQesitm.length +
            //             data.intrcQesitm.length +
            //             data.seQesitm.length +
            //             data.depositMethodQesitm.length +
            //             data.atpnWarnQesitm.length >
            //         1200
            //     ? MediaQuery.of(context).size.height * 1.5
            //     : MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height * 1.2,
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
                  flex: 11,
                  child: Column(
                    // 약품명 : ↓↓↓ list
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tabInformationSubItem(
                          title: '주의사항',
                          content: data != null ? data.atpnQesitm : 'notice'),
                      tabInformationSubItem(
                          title: '상호작용',
                          content:
                              data != null ? data.intrcQesitm : 'interact'),
                      tabInformationSubItem(
                          title: '부작용',
                          content: data != null ? data.seQesitm : 'sideeffect'),
                      tabInformationSubItem(
                          title: '보관법',
                          content: data != null
                              ? data.depositMethodQesitm
                              : 'deposit'),
                      tabInformationSubItem(
                          title: '주의사항 경고',
                          content:
                              data != null ? data.atpnWarnQesitm : 'warning'),
                    ],
                  ),
                )
              ],
            ))),
  );
}

// 약품 검색 상세 결과 - 복용법
Container tabUsage(BuildContext context, {final data}) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      title: '효능',
                      content: data != null ? data.efcyQesitm : 'name'),
                ],
              ),
            )
          ]));
}
