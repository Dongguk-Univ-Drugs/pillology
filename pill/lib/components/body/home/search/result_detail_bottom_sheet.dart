import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_detail_tabview.dart';
import 'package:pill/model/search/text_search_result.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

Widget zoomInTabNotion(BuildContext context, final ParsedSearchResult data) {
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
                                  child: data.txt.itemImage == null
                                      ? Image.asset(
                                          'assets/icons/pill.png',
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        )
                                      : Image.network(data.txt.itemImage,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300))),
                          data.txt.atpnQesitm != null
                              ? tabInformationSubItem(
                                  title: '주의사항',
                                  content: data.txt.atpnQesitm,
                                  size: 14.0)
                              : SizedBox(),
                          data.txt.intrcQesitm != null
                              ? tabInformationSubItem(
                                  title: '상호작용',
                                  content: data.txt.intrcQesitm,
                                  size: 14.0)
                              : SizedBox(),
                          data.txt.seQesitm != null
                              ? tabInformationSubItem(
                                  title: '부작용',
                                  content: data.txt.seQesitm,
                                  size: 14.0)
                              : SizedBox(),
                          data.txt.depositMethodQesitm != null
                              ? tabInformationSubItem(
                                  title: '보관법',
                                  content: data.txt.depositMethodQesitm,
                                  size: 14.0)
                              : SizedBox(),
                          data.txt.atpnWarnQesitm != null
                              ? tabInformationSubItem(
                                  title: '주의사항 경고',
                                  content: data.txt.atpnWarnQesitm,
                                  size: 14.0)
                              : SizedBox(),
                        ],
                      )
                    : makeBoldTitle(title: '정보가 없습니다.'),
              ))
        ],
      ));
}

Widget zoomInTabDUR(BuildContext context, final ParsedSearchResult data) {
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
                child: data.dur != null
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
                                  child: data.txt.itemImage == null
                                      ? Image.asset(
                                          'assets/icons/pill.png',
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        )
                                      : Image.network(data.txt.itemImage,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300))),
                          data.dur.durSeq != null
                              ? tabInformationSubItem(
                                  title: 'DUR 일련번호',
                                  content: data.dur.durSeq,
                                  size: 14.0)
                              : SizedBox(),
                          data.dur.mix != null
                              ? tabInformationSubItem(
                                  title: '단일 / 복합',
                                  content: data.dur.mix,
                                  size: 14.0)
                              : SizedBox(),
                          data.dur.ingrKorName != null
                              ? tabInformationSubItem(
                                  title: 'DUR 성분명',
                                  content: data.dur.ingrKorName,
                                  size: 14.0)
                              : SizedBox(),
                          data.dur.prohbtContent != null
                              ? tabInformationSubItem(
                                  title: '금기 내용',
                                  content: data.dur.prohbtContent,
                                  size: 14.0)
                              : SizedBox(),
                          data.dur.mixIngr != null
                              ? tabInformationSubItem(
                                  title: '복합체',
                                  content: data.dur.mixIngr,
                                  size: 14.0)
                              : SizedBox(),

                          // 병용금기 관련 내용
                          data.dur.typeName == '병용금기'
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      makeBoldTitle(
                                          title: data.dur.typeName,
                                          size: 16.0,
                                          color: colorThemeGreen),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      data.dur.mixtureDurSeq != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 DUR 번호',
                                              content: data.dur.mixtureDurSeq,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureIngrKorName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 DUR 성분명',
                                              content:
                                                  data.dur.mixtureIngrKorName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureItemName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 품목 기준 코드',
                                              content: data.dur.mixtureItemName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureItemName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 품목명',
                                              content: data.dur.mixtureItemName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureFormName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 제형',
                                              content: data.dur.mixtureFormName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureEtcOtcName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 전문 / 일반',
                                              content:
                                                  data.dur.mixtureEtcOtcName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureClassName != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 약효 분류',
                                              content:
                                                  data.dur.mixtureClassName,
                                              size: 14.0)
                                          : SizedBox(),
                                      data.dur.mixtureMainIngr != null
                                          ? tabInformationSubItem(
                                              title: '병용금기 주성분',
                                              content: data.dur.mixtureMainIngr,
                                              size: 14.0)
                                          : SizedBox(),
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
