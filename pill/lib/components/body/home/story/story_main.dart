import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/model/response_data.dart';
import 'package:pill/utility/textify.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  var data;

  fetchData() async {
    final response = await http.get('http://127.0.0.1:3000/index');

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
              return ListView.builder(
                itemCount: data.result.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(data.result[index].title);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
