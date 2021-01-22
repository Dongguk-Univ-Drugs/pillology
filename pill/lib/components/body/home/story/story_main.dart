import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/utility/textify.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {

  Future<http.Response> fetchData() {
    return http.get('https://localhost/index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHeader(makeAppTitle('약 이야기')),
      body: Center(
        child: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasError) {
              return Text('404 - NOT FOUND');
            } else if(!snapshot.hasData) {
              return loadingPage(context);
            } else {
              print(snapshot.data);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('fetched!'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}