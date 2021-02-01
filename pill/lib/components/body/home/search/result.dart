// packages
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// components
import 'package:pill/components/body/home/search/result_tabview.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
// utility
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
// model
import 'package:pill/model/text_search_result.dart';

class SearchResult extends StatefulWidget {
  final String entpName, itemName;

  SearchResult({this.entpName, this.itemName});

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();
  TabController tabController;

  // text search
  var url =
      'http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList?';
  var _serviceKey =
      'xCmiTrdFK8b1d4tNOWt%2Fjs%2BYo7TQcd%2BJqb3KxAib7iDWO%2B3aGkevwya5zHvIv%2FJ6pyrjjHGwSbjOR%2FnTQ%2B5zfA%3D%3D';
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

  Future<dynamic> futureResult;

  Future<dynamic> fetchTextSearchResult() async {
    String _getURL = url + 'serviceKey=' + _serviceKey + _entpName != null
        ? 'entpName=' + _entpName
        : '' + _itemName != null
            ? 'itemName=' + _itemName
            : '' + '&type=json';

    final response = await http.get(
        "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList?serviceKey=" +
            _serviceKey +
            "&trustEntpName=한미약품(주)&pageNo=1&startPage=1&numOfRows=3&type=json");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // print(json.decode(response.body));
      // print(json.decode(response.body)['body']['items']);
      // Response _re = Response.fromJson(json.decode(response.body));
      // ResponseBody _bd = ResponseBody.fromJson(_re.body);
      return json.decode(response.body);
      // return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load text search result');
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    _itemName = widget.itemName;
    _entpName = widget.entpName;
    futureResult = fetchTextSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customHeader("약품 검색 결과"),
        body: FutureBuilder(
          future: futureResult, // TODO: data fetch !!!
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: makeBoldTitleWithSize(
                    '찾을 수 없습니다. 🧐', 16.0, TextAlign.center),
              );
            } else if (!snapshot.hasData) {
              return loadingPage(context);
            } else {
              Response _response =
                  Response.fromJson(Map<String, dynamic>.from(snapshot.data));
              // Response _response =
              //     Response.fromJson(json.decode(snapshot.data));
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: boxDecorationNoShadow(),
                            child: Text(_items[index].itemName),
                          );
                        },
                      )));
            }
          },
        )
        // body: SingleChildScrollView(
        //   controller: _controller,
        //   child: SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         Expanded(
        //           flex: 1,
        //           child: SizedBox(),
        //         ),
        //         Expanded(
        //             // title : name, product, images -> row
        //             flex: 1,
        //             child: resultTitle(context)),
        //         Expanded(
        //             // only text : desc1, name(colored Bold), desc2
        //             flex: 2,
        //             child: resultAlert(context)),
        //         Expanded(
        //             // tab view : 5 tabs required
        //             flex: 5,
        //             child: resultTabView(context, tabController)),
        //         Expanded(
        //             // bookmark button
        //             flex: 1,
        //             child: resultBookmark(context)),
        //       ],
        //     ),
        //   ),
        // )
        );
  }
}

// 결과화면 제목란
Widget resultTitle(BuildContext context,
    {String name, String engName, String manufacturer, String imagePath}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.05,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              makeTitleWithColor(
                  emphasize: name != null ? name : '알악이름이오는곳00mg',
                  color: colorThemeGreen),
              makeSemiTitle(
                  title: engName != null ? engName : '알약영어이름 00mg',
                  color: color777,
                  size: 14.0),
              makeSemiTitle(
                  title: manufacturer != null ? manufacturer : '제조업체',
                  color: colorAAA,
                  size: 12.0)
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath == null ? 'assets/icons/pill.png' : imagePath,
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
        )
      ],
    ),
  );
}

// 결과화면 사용자별 알림
Widget resultAlert(BuildContext context, {String bewareDrug}) {
  return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.04,
      ),
      alignment: Alignment.center,
      decoration: boxDecorationNoShadow(),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.05),
      child: makeTitleWithColor(
          normalStart: bewareDrug != null ? '검색하신 약은' : '로그인 / 회원가입 을 해주세요 !\n',
          emphasize: bewareDrug != null ? bewareDrug : '병명\n',
          normalEnd: bewareDrug != null ? '와 병용 투여시 주의해주세요 !' : '텍스트2',
          color: colorThemeGreen,
          textAlign: TextAlign.center));
}

// 결과화면 탭 뷰
Widget resultTabView(BuildContext context, TabController tabController,
    {final data}) {
  return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TabBar(
              controller: tabController,
              // indicator: UnderlineTabIndicator(
              //   borderSide: BorderSide(color: colorThemeGreen, width: MediaQuery.of(context).size.width * 0.05, style: BorderStyle.solid)
              // ),
              indicator: ShapeDecoration.fromBoxDecoration(
                  boxDecorationNoShadow(color: colorThemeGreen, border: 1)),
              //indicatorPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: colorAAA,
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
              labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.005),
              labelColor: Colors.white,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
              indicatorColor: colorThemeGreen,
              tabs: [
                Tab(text: "정보"),
                Tab(text: "효능/성능"),
                Tab(text: "복용법"),
                Tab(text: "주의사항"),
                Tab(text: "DUR")
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
              flex: 8,
              child: TabBarView(
                controller: tabController,
                children: [
                  tabInformation(context),
                  tabInformation(context),
                  tabInformation(context),
                  tabInformation(context),
                  tabInformation(context),
                ],
              ))
        ],
      ));
}

// 북마크하기 버튼
Widget resultBookmark(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 5.0,
      ),
      Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: colorThemeGreen),
            child:
                makeBoldTitle(title: '북마크하기', size: 18.0, color: Colors.white),
            onPressed: () => print('북마크하기'),
          ))
    ],
  );
}
