import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:pill/model/text_search_result.dart';

class UseAPISearch extends StatefulWidget {
  final String entpName, itemName;

  UseAPISearch({this.entpName, this.itemName});

  @override
  _UseAPISearchState createState() => _UseAPISearchState();
}

class _UseAPISearchState extends State<UseAPISearch> {
  var url =
      'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList?';
  var _serviceKey =
      'xCmiTrdFK8b1d4tNOWt%2Fjs%2BYo7TQcd%2BJqb3KxAib7iDWO%2B3aGkevwya5zHvIv%2FJ6pyrjjHGwSbjOR%2FnTQ%2B5zfA%3D%3D';

  /*
      serviceKey  : 인증키, 공공데이터포럼에서 받은 인증키
      pageNo      : 페이지 번호
      numOfRows   : 한 페이지 결과 수
      entpName    : 업체명, ex) 한미약품
      itemName    : 제품명
      itemSeq     : 품목기준코드
      type        : xml(default) / json
  */

  Future<TextSearchResult> futureResult;

  Future<TextSearchResult> fetchTextSearchResult() async {
    String _getURL = url + 'serviceKey=' + _serviceKey + widget.entpName != null
        ? 'entpName=' + widget.entpName
        : '' + widget.itemName != null
            ? 'itemName=' + widget.itemName
            : '';

    final response = await http.get(_getURL);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return TextSearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load text search result');
    }
  }

  @override
  void initState() {
    super.initState();
    futureResult = fetchTextSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
