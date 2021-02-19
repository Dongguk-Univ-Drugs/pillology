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
