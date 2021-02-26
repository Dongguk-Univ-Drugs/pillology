import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// components
import 'package:pill/components/body/home/search/result_detail_tabview.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/model/search/dur_search_result.dart';
// models
import 'package:pill/model/search/text_search_result.dart';
// utility
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class ResultDetail extends StatefulWidget {
  final TextSearchResult details;

  ResultDetail({this.details});

  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();
  TabController tabController;

  TextSearchResult _result;

  // text search
  var _serviceKey = env['SERVICE_KEY'];
  // DUR 성분
  Future<dynamic> _durResult;

  // api call function
  Future<http.Response> apiCall(String api) {
    return http.get("http://apis.data.go.kr/1470000/DURPrdlstInfoService/" +
        api +
        "?ServiceKey=" +
        _serviceKey +
        "&itemName=" +
        _result.itemName +
        "&pageNo=1&numOfRows=3&type=json");
  }

  Future<dynamic> fetchDURResult() async {
    // 병용금기
    String usjntAPI = 'getUsjntTabooInfoList';
    // 특정 연령 금기
    String spcifyagAPI = 'getSpcifyAgrdeTabooInfoList';
    // 임부 금기
    String prgntAPI = 'getPwnmTabooInfoList';
    // 용량 주의
    String cpctyAPI = 'getCpctyAtentInfoList';
    // 투여 기간 주의
    String mdlatAPI = 'getMdctnPdAtentInfoList';
    // 노인 주의
    String oldmanAPI = 'getOdsnAtentInfoList';
    // 효능군 중복 조회
    String efcyDulAPI = 'getEfcyDplctInfoList';
    // 서방정 분할 주의 정보조회
    String seodivAPI = 'getSeobangjeongPartitnAtentInfoList';
    // ★ DUR 품목 조회 → 모델이 다름...
    String durinfoAPI = 'getDurPrdlstInfoList';

    return await Future.wait([apiCall(usjntAPI), apiCall(durinfoAPI)])
        .then((List res) {
      var usjntJson = json.decode(res[0].body)['body'];
      var durinfoJson = json.decode(res[1].body)['body'];

      if (usjntJson['items'] == null) print('병용금기 X');
      if (durinfoJson['items'] == null) print('DUR 품목조회 X');
      // if (usjntJson['items'] != null && durinfoJson['items'] != null) {
      //   var result = [usjntJson, durinfoJson];
      //   return result;
      // } else
      //   return throw Exception('no items List !');
      var result = [usjntJson, durinfoJson];
      return result;
    }).catchError((err) => throw Exception(err));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _result = widget.details;
      tabController = TabController(vsync: this, length: 5);
    });
    _durResult = fetchDURResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader("약품 검색 상세 결과"),
      body: FutureBuilder(
        future: _durResult,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: makeBoldTitleWithSize(
                  '찾을 수 없습니다. 🧐', 16.0, TextAlign.center),
            );
          } else if (!snapshot.hasData) {
            return loadingPage(context);
          } else {
            var totalList = snapshot.data;
            // total data
            TotalDurSearchResult _total;
            TotalDurSearchResult _durInfoTotal;
            // get list
            List<DurSearchResult> _list;
            List<DurPrdSearchResult> _listDUR;
            // set one result
            DurSearchResult _item;
            DurPrdSearchResult _itemPrd;

            if (totalList[0]['items'] != null) {
              _total = TotalDurSearchResult.fromJson(totalList[0], 0);
              _list = List.from(_total.items);
              _item = _list[0]; // latest !
            }

            if (totalList[1]['items'] != null) {
              _durInfoTotal = TotalDurSearchResult.fromJson(totalList[1], 1);
              _listDUR = List.from(_durInfoTotal.items);
              _itemPrd = _listDUR[0];
            }

            // into One Object
            ParsedSearchResult psd = new ParsedSearchResult(
                txt: _result, dur: _item, durPrd: _itemPrd);

            return SingleChildScrollView(
              controller: _controller,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025,
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        // title : name, product, images -> row
                        flex: 2,
                        child: resultTitle(context,
                            name: _result.itemName,
                            engName: _result.itemEngName,
                            manufacturer: _result.entpName,
                            imagePath: _result.itemImage)),
                    Expanded(
                        // only text : desc1, name(colored Bold), desc2
                        flex: 1,
                        child: resultAlert(context)),
                    Expanded(
                        // tab view : 5 tabs required
                        flex: 7,
                        child: resultTabView(context, tabController, res: psd)),
                    Expanded(
                        // bookmark button
                        flex: 1,
                        child: resultBookmark(context)),
                  ],
                ),
              ),
            );
          }
        },
      ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              makeTitleWithColor(
                  emphasize: name != null ? name : '알악이름이오는곳00mg',
                  color: colorThemeGreen,
                  empSize: name.length > 30 ? 12.0 : 14.0),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              blankBox(flex: 3),
              Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: imagePath == null
                        ? Image.asset(
                            'assets/icons/pill.png',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          )
                        : Image.network(imagePath,
                            fit: BoxFit.cover, width: 200, height: 200),
                  )),
              blankBox(flex: 3)
            ],
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
      vertical: MediaQuery.of(context).size.width * 0.02,
    ),
    alignment: Alignment.center,
    decoration: boxDecorationNoShadow(),
    margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.width * 0.05),
    // child: makeTitleWithColor(
    //     normalStart: bewareDrug != null ? '검색하신 약은' : '로그인 / 회원가입 을 해주세요 !\n',
    //     emphasize: bewareDrug != null ? bewareDrug : '병명\n',
    //     normalEnd: bewareDrug != null ? '와 병용 투여시 주의해주세요 !' : '텍스트2',
    //     color: colorThemeGreen,
    //     textAlign: TextAlign.center)
    child: Text(
      '준 비 중',
      style: TextStyle(fontSize: 14.0),
    ),
  );
}

// 결과화면 탭 뷰
Widget resultTabView(BuildContext context, TabController tabController,
    {ParsedSearchResult res}) {
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
          blankBox(flex: 1),
          Expanded(
              flex: 9,
              child: TabBarView(
                controller: tabController,
                children: [
                  tabInformation(context, data: res),
                  tabEfcy(context, data: res),
                  tabUsage(context, data: res),
                  tabNotion(context, data: res),
                  tabDURInformation(context, data: res),
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
