import 'package:flutter/material.dart';

import 'package:pill/components/body/home/search/barcode/barcode_main.dart';
import 'package:pill/components/body/home/search/photo/photo_main.dart';
import 'package:pill/components/body/home/search/result_list.dart';
import 'package:pill/components/body/home/search/text/text_main.dart';
import 'package:pill/components/body/home/story/story_main.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/model/text_search.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

// util
import '../../../utility/input_decoration.dart';
// packages
import 'package:imagebutton/imagebutton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController mainScrollController = new ScrollController();

  // text editing controller
  TextEditingController searchController = new TextEditingController();

  // sqlite data
  var fetchedData;

  // optional screen
  bool showHistory = false;

  @override
  void initState() {
    super.initState();
    fetchedData = TextSearchDataProvider().getAllTexts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedData,
        builder: (BuildContext context,
            AsyncSnapshot<List<TextSearchData>> snapshot) {
          if (snapshot.hasData) {
            
            return Center(
                child: SingleChildScrollView(
                    controller: mainScrollController,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.9,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: searchBar(context),
                            ),
                            Expanded(
                              flex: 9,
                              child: Stack(
                                children: [
                                  Positioned(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      top: 0.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: searchTabs(context),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: foodStory(context)),
                                          Expanded(
                                              flex: 3,
                                              child: drugStory(context)),
                                          blankBox(flex: 4)
                                        ],
                                      )),
                                  // ---------------------------------------------------------------------- 검색창
                                  AnimatedPositioned(
                                      curve: Curves.fastOutSlowIn,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: !showHistory
                                          ? 0
                                          : MediaQuery.of(context).size.width *
                                              0.5,
                                      duration: Duration(milliseconds: 500),
                                      top: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 20.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.width,
                                          decoration: boxDecorationNoShadow(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: makeBoldTitle(
                                                    title: '최근 검색어',
                                                    color: color333,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.04),
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    TextSearchData data =
                                                        snapshot.data[snapshot
                                                                .data.length -
                                                            index -
                                                            1];
                                                    DateTime parsedTime =
                                                        DateTime.tryParse(
                                                            data.date);
                                                    int diff;
                                                    if (parsedTime != null) {
                                                      diff = DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                  .day)
                                                          .difference(DateTime(
                                                              parsedTime.year,
                                                              parsedTime.month,
                                                              parsedTime.day))
                                                          .inDays;
                                                    }
                                                    return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 6,
                                                            child: GestureDetector(
                                                              onTap: () => searchController.text = data.name,
                                                              child:   makeSemiTitle(
                                                                    title: data
                                                                        .name),
                                                            )
                                                          ),
                                                          blankBox(flex: 1),
                                                          Expanded(
                                                            flex: 2,
                                                            child: makeSemiTitle(
                                                                title: diff == 0
                                                                    ? '오늘'
                                                                    : diff != null
                                                                        ? diff.toString() + '일전'
                                                                        : 'x',
                                                                textAlign: TextAlign.center),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                TextSearchDataProvider()
                                                                    .deleteText(snapshot
                                                                            .data
                                                                            .length -
                                                                        index);
                                                                setState(() {
                                                                  fetchedData =
                                                                      TextSearchDataProvider()
                                                                          .getAllTexts();
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons.close,
                                                                  size: 20.0,
                                                                  color:
                                                                      colorAAA),
                                                            ),
                                                          )
                                                        ]);
                                                  },
                                                ),
                                              )
                                            ],
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ))));
          } else
            return loadingPage(context);
        });
  }

  Widget searchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 8,
            child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: TextFormField(
                  controller: searchController,
                  decoration: inputDecoration("검색하려는 약품명을 입력해주세요."),
                  onTap: () {
                    setState(() {
                      showHistory = !showHistory;
                      fetchedData = TextSearchDataProvider().getAllTexts();
                    });
                    print(showHistory);
                  },
                ))),
        Expanded(
            flex: 2,
            child: ImageButton(
                mainAxisAlignment: MainAxisAlignment.end,
                height: 30,
                width: 30,
                children: [
                  Image.asset(
                    'assets/icons/search-grey.png',
                    color: color777,
                  )
                ],
                pressedImage: Image.asset(
                  'assets/icons/search-grey.png',
                  color: colorThemeGreen,
                ), // TODO: 다른 색 아이콘으로 변경하기 !
                unpressedImage: Image.asset(
                  'assets/icons/search-grey.png',
                  color: color777,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(
                              itemName: searchController.text))).then((value) {
                    String _mm, _dd;
                    // month
                    if (DateTime.now().month < 10)
                      _mm = '0' + DateTime.now().month.toString();
                    else
                      _mm = DateTime.now().month.toString();

                    // date
                    if (DateTime.now().day < 10)
                      _dd = '0' + DateTime.now().day.toString();
                    else
                      _dd = DateTime.now().day.toString();

                    String _date =
                        DateTime.now().year.toString() + '-' + _mm + '-' + _dd;
                    
                    TextSearchDataProvider().createData(new TextSearchData(
                        name: searchController.text, date: _date));
                  });
                  
                }))
      ],
    );
  }
}

Row searchTabs(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: colorThemeGreen,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: colorEEE))),
                child: ImageIcon(
                  AssetImage('assets/icons/camera-outline.png'),
                  size: 30,
                  color: Colors.black87,
                ),
                // onPressed: () => print("camera search !")),
                // onPressed: () => Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => PhotoSearch()))
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhotoSearch())),
              ),
              SizedBox(height: 5.0),
              makeSemiTitle(title: "사진으로 검색하기")
            ],
          )),
      Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: colorThemeGreen,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: colorEEE))),
                child: ImageIcon(AssetImage('assets/icons/text-outline.png'),
                    size: 30, color: Colors.black87),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TextSearch())),
              ),
              SizedBox(
                height: 5.0,
              ),
              makeSemiTitle(title: "텍스트로 검색하기")
            ],
          )),
      Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: colorThemeGreen,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: colorEEE))),
                  child: ImageIcon(
                    AssetImage('assets/icons/barcode-outline.png'),
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BarcodeSearch()))),
              SizedBox(
                height: 5.0,
              ),
              makeSemiTitle(title: "바코드로 검색하기")
            ],
          ))
    ],
  );
}

GestureDetector foodStory(BuildContext context) {
  return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Story())),
      child: Container(
          decoration: boxDecorationNoShadow(),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              makeTitleWithColor(
                  normalStart: "오늘의 ",
                  emphasize: "식품안전지식",
                  normalEnd: "",
                  color: colorThemeGreen),
              ImageIcon(AssetImage('assets/icons/chevron-forward-outline.png'),
                  size: 20, color: Colors.black87),
            ],
          )));
}

GestureDetector drugStory(BuildContext context) {
  return GestureDetector(
      // onTap: () => Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Story())),
      onTap: () => print('TODO: 오늘 나의 약 점수는?'),
      child: Container(
          decoration: boxDecorationNoShadow(),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              makeTitleWithColor(
                  normalStart: "오늘 ",
                  emphasize: "나의 약 점수는?",
                  normalEnd: "",
                  color: colorThemeGreen),
              ImageIcon(AssetImage('assets/icons/chevron-forward-outline.png'),
                  size: 20, color: Colors.black87),
            ],
          )));
}

Container emergency(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015),
    decoration: boxDecorationNoShadow(),
    child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              makeTitleWithColor(
                  normalStart: "",
                  emphasize: "응급처치",
                  normalEnd: " 방법",
                  color: colorThemeGreen),
              ImageIcon(AssetImage('assets/icons/chevron-forward-outline.png'),
                  size: 20, color: Colors.black87),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 5.0,
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () => print("emergency1"),
                    child: makeBoldTitleWithSize(
                        "상황별\n응급처치", 18.0, TextAlign.center),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal:
                                MediaQuery.of(context).size.height * 0.015),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: colorEEE)),
                        backgroundColor: Colors.white,
                        elevation: 1.0),
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () => print("emergency2"),
                    child: makeBoldTitleWithSize(
                        "독극물\n응급처치", 18.0, TextAlign.center),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal:
                                MediaQuery.of(context).size.height * 0.015),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: colorEEE)),
                        backgroundColor: Colors.white,
                        elevation: 1.0),
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
