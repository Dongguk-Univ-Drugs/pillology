// packages
import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_detail.dart';
// components
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
// utility
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/textify.dart';
// model
import 'package:pill/model/text_search_result.dart';

class SearchResult extends StatefulWidget {
  final String entpName, itemName;

  SearchResult({this.entpName, this.itemName});

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  final _controller = ScrollController();

  // text search
  var _serviceKey = env['SERVICE_KEY'];
  var _entpName;
  var _itemName;
  /*
      serviceKey  : 인증키, 공공데이터포럼에서 받은 인증키
      pageNo      : 페이지 번호
      numOfRows   : 한 페이지 결과 수
      entpName    : 업체명, ex) 한미약품
      itemName    : 제품명
      itemSeq     : 품목기준코드
      type        : xml(default) / json
  */

  // e약은요
  Future<dynamic> _eDrugResult;
  
  Future<dynamic> fetchTextSearchResult() async {
    print(_entpName + "\t" + _itemName);
    
    // API 명칭 : e약은요 
    final response = await http.get(
        "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList?serviceKey=" +
            _serviceKey +
            _itemName +
            _entpName +
            "&pageNo=1&startPage=1&numOfRows=10&type=json");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return json.decode(response.body);
      // return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load text search result');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _itemName = widget.itemName != null ? "&itemName=" + widget.itemName : "";
      _entpName =
          widget.entpName != null ? "&trustEntpName=" + widget.entpName : "";
    });
    _eDrugResult = fetchTextSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customHeader("약품 검색 결과"),
        body: FutureBuilder(
          future: _eDrugResult, // TODO: data fetch !!!
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: makeBoldTitleWithSize(
                    '찾을 수 없습니다. 🧐', 16.0, TextAlign.center),
              );
            } else if (!snapshot.hasData) {
              return loadingPage(context);
            } else {

              // API 요청 (1): e약은요
              Response _response =
                  Response.fromJson(Map<String, dynamic>.from(snapshot.data));
              ResponseHeader _responseHeader =
                  ResponseHeader.fromJson(_response.header);
              ResponseBody _responseBody =
                  ResponseBody.fromJson(_response.body);
              List<TextSearchResult> _items = List.from(_responseBody.items);

              return SingleChildScrollView(
                  controller: _controller,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.025),
                          child: _items.length != 0
                              ? ListView.builder(
                                  itemCount: _items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResultDetail(
                                                      details: _items[index],
                                                    ))),
                                        child: Container(
                                          decoration: boxDecorationNoShadow(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025),
                                          margin: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005),
                                          child: makeSemiTitle(
                                              title: _items[index].itemName),
                                        ));
                                  },
                                )
                              : Center(
                                  child: makeBoldTitleWithSize(
                                      '찾을 수 없습니다. 🧐', 16.0, TextAlign.center),
                                ))));
            }
          },
        ));
  }
}
