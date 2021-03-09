import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pill/components/body/home/story/web_view.dart';
// components
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
// model and utility
import 'package:pill/model/response_data.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  var data;

  fetchData() async {
    final response = await http.get('http://127.0.0.1:3000/images');

    if (response.statusCode == 200) {
      return JsonArray.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('FAILED TO FETCH');
    }
  }

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader(makeAppTitle('약 이야기')),
      body: Center(
        child: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('404 - NOT FOUND');
            } else if (!snapshot.hasData) {
              return loadingPage(context);
            } else {
              JsonArray data = snapshot.data;
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      return rowItems(
                          context: context,
                          title: data.result[index].title != null
                              ? data.result[index].title
                              : 'not found',
                          date: data.result[index].date != null
                              ? data.result[index].date
                              : 'not found',
                          category: data.result[index].category != null
                              ? data.result[index].category
                              : 'not found',
                          url: data.result[index].url != null
                              ? data.result[index].url
                              : 'not found',
                          height: data.result[index].height != null
                              ? data.result[index].height
                              : 6400  // TODO : 안 먹히는 거 같음>...
                          );
                    },
                  ));
            }
          },
        ),
      ),
    );
  }
}

Widget rowItems(
    {BuildContext context,
    String title,
    String date,
    String category,
    String url,
    int height}) {
  return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(title: title, url: url))),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.025,
            horizontal: MediaQuery.of(context).size.width * 0.05),
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.025,
            horizontal: MediaQuery.of(context).size.width * 0.05),
        decoration: boxDecorationNoShadow(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 8,
                          child: makeBoldTitle(
                              title : title,
                              size : MediaQuery.of(context).size.width * 0.033,
                              color: color333)),
                      blankBox(flex: 1),
                      Expanded(
                          flex: 1,
                          child: ImageIcon(
                              AssetImage(
                                  'assets/icons/chevron-forward-outline.png'),
                              size: 24))
                    ])),
            blankBox(flex: 1),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: makeSemiTitle(title: category)),
                  blankBox(flex: 3),
                  Expanded(flex: 3, child: makeSemiTitle(title: date, textAlign: TextAlign.end))
                ],
              ),
            )
          ],
        ),
      ));
}
