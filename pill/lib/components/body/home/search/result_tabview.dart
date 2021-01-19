import 'package:flutter/material.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

Row tabInformationSubItem({String title, String content}) {
  return Row(
      // 약품명 : 가나모티에스알정15mg
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 3,
            child: makeSemiTitle(
                title: title == null ? '입력X' : title, color: color333)),
        Expanded(
            flex: 7,
            child: makeSemiTitle(
                title: content == null ? '----입력X----' : content,
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
              tabInformationSubItem(title : '약품명', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : '성분/함량', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : '전문/일반', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : '식약처분류', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : 'ATC코드', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : '투여경로', content: '가나모티에스알정15mg'),
              tabInformationSubItem(title : '보험정보', content: '가나모티에스알정15mg'),
            ],
          ),
        )
      ],
    ),
  );
}
