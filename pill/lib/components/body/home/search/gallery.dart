import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/utility/textify.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  ScrollController _controller = new ScrollController();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader('사진 선택하기'),
      // body: FutureBuilder(
      //   future: getImage(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(child: makeBoldTitle(title: "갤러리로 접근할 수 없습니다 😢", size: 16.0));
      //     } else if (!snapshot.hasData) {
      //       return Center(child: loadingPage(context));
      //     } else {
      //       return SingleChildScrollView(
      //           controller: _controller,
      //           child: Center(
      //             child: _image == null
      //                 ? Text('No image selected.')
      //                 : Image.file(_image),
      //           ));
      //     }
      //   },
      // )
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}
