import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: SearchBar(),
                ),
                Expanded(
                  flex: 2,
                  child: searchTabs(),
                ),
                Expanded(flex: 3, child: drugStory()),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 5.0,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: emergency(),
                )
              ],
            )));
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
          child: TextFormField(
            controller: searchController,
            decoration: inputDecoration("검색하려는 약품명을 입력해주세요."),
          ),
        ),
        Expanded(
            flex: 2,
            child: ImageButton(
              height: 30,
              width: 30,
              children: [Image.asset('assets/icons/search-grey.png', color: color777,)],
              pressedImage: Image.asset(
                  'assets/icons/search-grey.png', color: colorThemeGreen,), // TODO: 다른 색 아이콘으로 변경하기 !
              unpressedImage: Image.asset('assets/icons/search-grey.png', color: color777,),
              onTap: () => print("search pressed"),
            ))
      ],
    );
  }
}

Row searchTabs() {
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: colorEEE))),
                  child: ImageIcon(
                    AssetImage('assets/icons/camera-outline.png'),
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: () => print("camera search !")),
              SizedBox(height: 5.0),
              makeSemiTitle("사진으로 검색하기")
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: colorEEE))),
                  child: ImageIcon(AssetImage('assets/icons/text-outline.png'),
                      size: 30, color: Colors.black87),
                  onPressed: () => print("text search !")),
              SizedBox(
                height: 5.0,
              ),
              makeSemiTitle("텍스트로 검색하기")
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
                  onPressed: () => print("barcode search !")),
              SizedBox(
                height: 5.0,
              ),
              makeSemiTitle("바코드로 검색하기")
            ],
          ))
    ],
  );
}

GestureDetector drugStory() {
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
                        normalStart: "오늘의",
                        emphasize: "약",
                        normalEnd: "이야기",
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

Container emergency() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
                  normalEnd: "방법",
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
              TextButton(
                onPressed: () => print("emergency1"),
                child: makeSemiTitle("상황별 응급처치"),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: colorEEE))),
              ),
              TextButton(
                onPressed: () => print("emergency2"),
                child: makeSemiTitle("독극물 응급처치"),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: colorEEE))),
              )
            ],
          ),
        )
      ],
    ),
  );
}
