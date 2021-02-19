import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// components
import 'package:pill/components/body/home/search/result_detail_tabview.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
// models
import 'package:pill/model/text_search_result.dart';
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
  // TODO : env 처리하기
  // text search
  var _serviceKey =
      'xCmiTrdFK8b1d4tNOWt%2Fjs%2BYo7TQcd%2BJqb3KxAib7iDWO%2B3aGkevwya5zHvIv%2FJ6pyrjjHGwSbjOR%2FnTQ%2B5zfA%3D%3D';
  // DUR 성분
  Future<dynamic> _durResult;
  Future<dynamic> fetchDURResult() async {
    // API 명칭 : DUR 성분정보
    // 범용금기
    final usjntRes = await http.get(
        "http://apis.data.go.kr/1470000/DURPrdlstInfoService/getUsjntTabooInfoList?ServiceKey=" +
            _serviceKey +
            _result.itemName +
            "&pageNo=1&numOfRows=3&type=json");

    if (usjntRes.statusCode == 200) {
      print(usjntRes.body);
    }
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
            return SingleChildScrollView(
              controller: _controller,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025,
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        flex: 2,
                        child: resultAlert(context)),
                    Expanded(
                        // tab view : 5 tabs required
                        flex: 5,
                        child: resultTabView(context, tabController,
                            data: _result)),
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
    {TextSearchResult data}) {
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
                  tabInformation(context, data: data),
                  tabEfcy(context, data: data),
                  tabUsage(context, data: data),
                  tabNotion(context, data: data),
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
