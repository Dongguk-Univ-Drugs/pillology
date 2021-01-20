import 'package:flutter/material.dart';
import 'package:pill/components/body/home/search/barcode/barcode_main.dart';
import 'package:pill/components/body/home/search/photo/photo_main.dart';
import 'package:pill/components/body/home/search/text/text_main.dart';
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            controller: mainScrollController,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SearchBar(),
                    ),
                    Expanded(
                      flex: 2,
                      child: searchTabs(context),
                    ),
                    Expanded(flex: 3, child: drugStory(context)),
                    Expanded(
                      flex: 3,
                      child: emergency(context),
                    ),
                  ],
                ))));
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              onTap: () => print("search pressed"),
            ))
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

GestureDetector drugStory(BuildContext context) {
  return GestureDetector(
      onTap: () => print("drugs clicked"),
      child: Container(
          decoration: boxDecorationNoShadow(),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    makeTitleWithColor(
                        normalStart: "오늘의 ",
                        emphasize: "약",
                        normalEnd: " 이야기",
                        color: colorThemeGreen),
                    ImageIcon(
                        AssetImage('assets/icons/chevron-forward-outline.png'),
                        size: 20,
                        color: Colors.black87),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 5.0,
                  )),
              Expanded(
                flex: 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: Image.asset('assets/icons/pill.png'),
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: colorEEE)),
                        )),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          makeTitleWithColor(
                              normalStart: "",
                              emphasize: "카페인",
                              normalEnd: "",
                              color: colorThemeGreen),
                          makeContent(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "),
                        ],
                      ),
                    )
                  ],
                ),
              )
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
