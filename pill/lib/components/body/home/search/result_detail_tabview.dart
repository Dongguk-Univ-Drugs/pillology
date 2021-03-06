import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_detail_bottom_sheet.dart';
import 'package:pill/model/search/text_search_result.dart';
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

// 약품 검색 상세 결과 - 정보
Container tabInformation(BuildContext context,
    {final ParsedSearchResult data}) {
  ScrollController _controller = new ScrollController();
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
          // 약품명 : ↓↓↓ list
          child: ListView(
            controller: _controller,
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data.txt != null
                  ? tabInformationSubItem(
                      title: '약품명', content: data.txt.itemName)
                  : SizedBox(),
              data.dur != null
                  ? tabInformationSubItem(
                      title: '주성분', content: data.dur.mainIngr)
                  : SizedBox(),
              data.durPrd != null
                  ? tabInformationSubItem(
                      title: '함량', content: data.durPrd.materialName)
                  : SizedBox(),
              data.dur != null
                  ? tabInformationSubItem(
                      title: '전문/일반',
                      content: data.dur.etcOtcCode == '01' ? '전문' : '일반')
                  : SizedBox(),
              data.dur != null
                  ? tabInformationSubItem(
                      title: '식약처분류', content: data.dur.className)
                  : SizedBox(),
              data.dur != null
                  ? tabInformationSubItem(
                      title: '품목기준코드', content: data.dur.itemSeq)
                  : SizedBox(),
              data.txt != null
                  ? tabInformationSubItem(
                      title: '투여경로', content: data.txt.useMethodQesitm)
                  : SizedBox(),
              data.durPrd != null
                  ? tabInformationSubItem(
                      title: '보험정보', content: data.durPrd.ediCode)
                  : SizedBox(),
            ],
          ),
        )
      ],
    ),
  );
}

// bottom Modal Sheet
_showBottomSheetTabNotion(BuildContext context, final ParsedSearchResult data) {
  showModalBottomSheet(
      backgroundColor: Color(0x00000000),
      context: context,
      builder: (_) => zoomInTabNotion(context, data),
      isScrollControlled: true);
}

_showBottomSheetTabDURInfo(
    BuildContext context, final ParsedSearchResult data) {
  showModalBottomSheet(
      backgroundColor: Color(0x00000000),
      context: context,
      builder: (_) => zoomInTabDUR(context, data),
      isScrollControlled: true);
}

// 약품 검색 상세 결과 - 주의 사항
Container tabNotion(BuildContext context, {final ParsedSearchResult data}) {
  ScrollController _controller = new ScrollController();

  int totalLength = data.txt.atpnQesitm.length +
      data.txt.intrcQesitm.length +
      data.txt.seQesitm.length +
      data.txt.depositMethodQesitm.length +
      data.txt.atpnWarnQesitm.length;
  print(totalLength.toString());

  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 8,
                    child: makeBoldTitle(
                        title: '상세 정보', size: 16.0, color: Colors.black)),
                blankBox(flex: 1),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 0,
                            bottom: MediaQuery.of(context).size.width * 0.08),
                      ),
                      child: Icon(Icons.zoom_in_rounded,
                          size: 24, color: colorThemeGreen),
                      onPressed: () => _showBottomSheetTabNotion(context, data),
                    ))
              ],
            )),
        // blankBox(flex: 1),
        Expanded(
            flex: 8,
            child: ListView(controller: _controller, children: [
              data.txt != null
                  ? tabInformationSubItem(
                      title: '주의사항', content: data.txt.atpnQesitm)
                  : SizedBox(),
              data.txt != null
                  ? tabInformationSubItem(
                      title: '상호작용', content: data.txt.intrcQesitm)
                  : SizedBox(),
              data.txt != null
                  ? tabInformationSubItem(
                      title: '부작용', content: data.txt.seQesitm)
                  : SizedBox(),
              data.txt != null
                  ? tabInformationSubItem(
                      title: '보관법', content: data.txt.depositMethodQesitm)
                  : SizedBox(),
              data.txt != null
                  ? tabInformationSubItem(
                      title: '주의사항 경고', content: data.txt.atpnWarnQesitm)
                  : SizedBox(),
              data.dur != null
                  ? tabInformationSubItem(title: '비고', content: data.dur.remark)
                  : SizedBox()
            ]))
      ],
    ),
  );
}

// 약품 검색 상세 결과 - 복용법
Container tabUsage(BuildContext context, {final ParsedSearchResult data}) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  data.txt != null
                      ? tabInformationSubItem(
                          title: '사용법', content: data.txt.useMethodQesitm)
                      : SizedBox(),
                  data.durPrd != null
                      ? tabInformationSubItem(
                          title: '유효기간', content: data.durPrd.validTerm)
                      : SizedBox()
                ],
              ),
            )
          ]));
}

// 약품 검색 상세 결과 - 효능/성능
Container tabEfcy(BuildContext context, {final ParsedSearchResult data}) {
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
                  data.txt != null
                      ? tabInformationSubItem(
                          title: '효능', content: data.txt.efcyQesitm)
                      : SizedBox(),
                ],
              ),
            )
          ]));
}

// 약품 검색 상세 결과 - DUR 정보
Container tabDURInformation(BuildContext context,
    {final ParsedSearchResult data}) {
  ScrollController _controller = new ScrollController();

  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    decoration: boxDecorationNoShadow(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 8,
                    child: makeBoldTitle(
                        title: '상세 정보', size: 16.0, color: Colors.black)),
                blankBox(flex: 1),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: 0,
                            bottom: MediaQuery.of(context).size.width * 0.08),
                      ),
                      child: Icon(Icons.zoom_in_rounded,
                          size: 22, color: colorThemeGreen),
                      onPressed: () =>
                          _showBottomSheetTabDURInfo(context, data),
                    ))
              ],
            )),
        Expanded(
            flex: 8,
            child: ListView(controller: _controller, shrinkWrap: true,
                // child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      data.dur != null
                          ? tabInformationSubItem(
                              title: 'DUR 일련번호', content: data.dur.durSeq)
                          : SizedBox(),
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '단일 / 복합', content: data.dur.mix)
                          : SizedBox(),
                      data.dur != null
                          ? tabInformationSubItem(
                              title: 'DUR 성분명',
                              content: data.dur.ingrEngName != null
                                  ? data.dur.ingrKorName +
                                      " (${data.dur.ingrEngName})"
                                  : data.dur.ingrKorName)
                          : SizedBox(),
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '금기 내용', content: data.dur.prohbtContent)
                          : SizedBox()
                    ],
                  )),
                  Divider(
                    color: colorAAA,
                  ),
                  // 병용금기 내용 ===============================================
                  SizedBox(
                    height: 10.0,
                  ),
                  makeBoldTitle(
                      title: data.dur != null ? data.dur.typeName : 'DUR 유형',
                      size: 16.0,
                      color: colorThemeGreen),
                  SizedBox(
                    height: 8.0,
                  ),
                  // 병용금기 관련 내용
                  Container(
                      // padding: EdgeInsets.only(
                      //     left:
                      //         MediaQuery.of(context).size.width * 0.025),
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 병용금기 DUR 번호 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 DUR 번호',
                              content: data.dur.mixtureDurSeq)
                          : SizedBox(),
                      // 병용금기 DUR 성분명 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 DUR 성분명',
                              content: data.dur.mixtureIngrKorName)
                          : SizedBox(),
                      // 병용금기 품목 기준 코드 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 품목 기준 코드',
                              content: data.dur.mixtureItemSeq)
                          : SizedBox(),
                      // 병용금기 품목명 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 품목명',
                              content: data.dur.mixtureItemName)
                          //: '정보가 없습니다.',
                          : SizedBox(),
                      // 병용금기 DUR 번호 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 제형',
                              content: data.dur.mixtureFormName)
                          : SizedBox(),
                      // 병용금기 전문 / 일반 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 전문 / 일반',
                              content: data.dur.mixtureEtcOtcName)
                          : SizedBox(),
                      // 병용금기 약효분류 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 약효 분류',
                              content: data.dur.mixtureClassName)
                          : SizedBox(),
                      // 병용금기 주성분 --------------------------
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 주성분',
                              content: data.dur.mixtureMainIngr)
                          : SizedBox(),
                      // 병용금기 성상
                      data.dur != null
                          ? tabInformationSubItem(
                              title: '병용금기 성상', content: data.dur.mixtureChart)
                          : SizedBox()
                    ],
                  ))
                ]))
        //)
      ],
    ),
  );
}
