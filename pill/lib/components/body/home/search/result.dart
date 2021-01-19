import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/result_tabview.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customHeader("약품 검색 결과"),
        // body: FutureBuilder(
        //   //  future: , // TODO: data fetch !!!
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(
        //         child: makeBoldTitleWithSize(
        //             '찾을 수 없습니다. 🧐', 16.0, TextAlign.center),
        //       );
        //     } else if (!snapshot.hasData) {
        //       return loadingPage(context);
        //     } else {
        //       return SingleChildScrollView(
        //         controller: _controller,
        //         child: SizedBox(),
        //       );
        //     }
        //   },
        // )
        body: SingleChildScrollView(
          controller: _controller,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                    // title : name, product, images -> row
                    flex: 1,
                    child: resultTitle(context)),
                Expanded(
                    // only text : desc1, name(colored Bold), desc2
                    flex: 2,
                    child: resultAlert(context)),
                Expanded(
                    // tab view : 5 tabs required
                    flex: 5,
                    child: resultTabView(context, tabController)),
                Expanded(
                    // bookmark button
                    flex: 1,
                    child: resultBookmark(context)),
              ],
            ),
          ),
        ));
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
                boxDecorationNoShadow(color: colorThemeGreen, border: 1)
              ),
              //indicatorPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: colorAAA,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
              labelPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.005),
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
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
