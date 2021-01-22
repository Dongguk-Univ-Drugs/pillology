import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/utility/textify.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final title, url, height;

  WebViewScreen({this.title, this.url, this.height});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _controller = ScrollController();
  double _height;
  var _showAppbar = false;

  void showAppbar() {
    print('clicked !');
    setState(() {
      _showAppbar = !_showAppbar;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _height = widget.height;
    });
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> _calculation = Future<String>.delayed(
      Duration(seconds: 3),
      () => 'Data Loaded',
    );

    return Scaffold(
        appBar: _showAppbar
            ? customHeader(makeAppTitle(widget.title, size: 12.0))
            : null,
        body: FutureBuilder(
          future: _calculation,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return makeAppTitle('관리자에게 문의해주세요.');
            } else if (!snapshot.hasData) {
              return Center(child: loadingPage(context));
            } else {
              return Scrollbar(
                  controller: _controller,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                      controller: _controller,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: _height != null
                              ? MediaQuery.of(context).size.height < _height
                                  ? _height
                                  : MediaQuery.of(context).size.height
                              : MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              WebView(
                                initialUrl: widget.url,
                                javascriptMode: JavascriptMode.unrestricted,
                              ),
                              GestureDetector(
                                onTap: () => showAppbar(),
                              )
                            ],
                          ))));
            }
          },
        ));
  }
}
