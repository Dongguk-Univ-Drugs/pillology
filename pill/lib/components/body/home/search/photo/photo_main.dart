import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill/components/body/home/search/result.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/model/provider.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/components/body/home/search/photo/camera.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
import 'package:provider/provider.dart';

class PhotoSearch extends StatefulWidget {
  @override
  _PhotoSearchState createState() => _PhotoSearchState();
}

class _PhotoSearchState extends State<PhotoSearch> {
  String defaultImage = 'assets/icons/pill.png';
  bool isFront = true;
  
  final picker = ImagePicker();

  photoOptionModal(BuildContext context, bool pressed) {
    print("before : " +
        isFront.toString() +
        "\t>\tafter : " +
        pressed.toString());
    setState(() {
      isFront = pressed;
    });
    return showModalBottomSheet(
        context: context,
        builder: buildBottomSheet,
        backgroundColor: Color(0x00000000));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PhotoSearchImageStore storage = Provider.of<PhotoSearchImageStore>(context);

    String frontImage =
        storage.storage[0] != 'none' ? storage.storage[0] : defaultImage;
    String backImage =
        storage.storage[1] != 'none' ? storage.storage[1] : defaultImage;

    return Scaffold(
        appBar: customHeader(makeAppTitle("사진으로 검색하기")),
        body: Center(
            child: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: makeSemiTitle(
                          title: "검색할 약품의 사진을 등록해주세요.",
                          size: 18.0,
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              decoration: boxDecorationNoShadow(),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("●",
                                            style: TextStyle(
                                                color: colorThemeGreen,
                                                fontSize: 16.0)),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        makeSemiTitle(
                                            title: "앞 모습 사진",
                                            color: Colors.black87,
                                            size: 16.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 5,
                                    child: dottedBorderContainer(frontImage),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () =>
                                          photoOptionModal(context, true),
                                      child: makeSemiTitle(
                                          title: "등록하기",
                                          size: 14.0,
                                          color: Colors.black87),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: colorThemeGreen,
                                                width: 2.0)),
                                        // backgroundColor: colorThemeGreen,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              decoration: boxDecorationNoShadow(),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("●",
                                            style: TextStyle(
                                                color: colorThemeGreen,
                                                fontSize: 16.0)),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        makeSemiTitle(
                                            title: "뒷 모습 사진",
                                            color: Colors.black87,
                                            size: 16.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 5,
                                    child: dottedBorderContainer(backImage),
                                  ),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () =>
                                          photoOptionModal(context, false),
                                      child: makeSemiTitle(
                                          title: "등록하기",
                                          size: 14.0,
                                          color: Colors.black87),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: colorThemeGreen,
                                                width: 2.0)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult())),
                          style: TextButton.styleFrom(
                              backgroundColor: colorThemeGreen,
                              elevation: 3.0,
                              primary: Colors.blue[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: makeBoldTitle(
                              title: "검사하기", size: 22.0, color: Colors.white)),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ))));
  }

  Future getImage(BuildContext context) async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        Provider.of<PhotoSearchImageStore>(context, listen: false).store(pickedFile.path, isFront ? 0 : 1);
      } else {
        print('No image selected.');
      }
    });

    Navigator.pop(context);
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20))),
        child: Column(
          children: [
            blankBox(flex: 1),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 4,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Camera(isFront: isFront))),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: colorThemeGreen,
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width * 0.1,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.08),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.black12)),
                          // elevation: 16.0, shadowColor: Colors.black45
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 7,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/camera-outline.png'))),
                            blankBox(flex: 1),
                            Expanded(
                                flex: 2,
                                child: makeSemiTitle(
                                    title: '새로 사진 찍기',
                                    size: MediaQuery.of(context).size.width *
                                        0.04))
                          ],
                        ),
                      )),
                  blankBox(flex: 1),
                  Expanded(
                      flex: 4,
                      child: TextButton(
                        onPressed: () => getImage(context),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: colorThemeGreen,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 0.1,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.08),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black12))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 7,
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/images-outline.png'))),
                            blankBox(flex: 1),
                            Expanded(
                                flex: 2,
                                child: makeSemiTitle(
                                    title: '사진 선택하기',
                                    size: MediaQuery.of(context).size.width *
                                        0.04))
                          ],
                        ),
                      )),
                ],
              ),
            ),
            blankBox(flex: 1),
            Expanded(
                flex: 2,
                child: makeBoldTitle(
                    title: "사진을 등록할 방법을 선택해주세요.",
                    color: Colors.black87,
                    size: 16.0))
          ],
        ));
  }
}
