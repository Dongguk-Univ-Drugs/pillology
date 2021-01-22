import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill/components/body/personal/personal_health_info.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {}

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: personalDetail(context),
                ),
                Expanded(
                  flex: 5,
                  child: bookmark(context),
                ),
              ],
            )));
  }

  Row personalDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: buildBottomSheet,
                  backgroundColor: Color(0x00000000));
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: colorThemeGreen,
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("김약국"),
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonalHealthInfoPage())),
                child: Text("나의 건강 정보 관리",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.008,
                        horizontal: MediaQuery.of(context).size.height * 0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.transparent)),
                    backgroundColor: colorThemeGreen,
                    elevation: 1.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Container bookmark(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          children: [Expanded(child: Text("북마크"))],
        ));
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
                        onPressed: () {
                          _imgFromCamera();
                          Navigator.of(context).pop();
                        },
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
                        onPressed: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        },
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
