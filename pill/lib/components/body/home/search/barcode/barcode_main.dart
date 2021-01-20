import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pill/components/header/header.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

class BarcodeSearch extends StatefulWidget {
  BarcodeSearch({Key key}) : super(key: key);

  @override
  _BarcodeSearchState createState() => _BarcodeSearchState();
}

class _BarcodeSearchState extends State<BarcodeSearch> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
        바코드 스캔 후 -> 텍스트로 검색
     */
    return Scaffold(
      appBar: customHeader('바코드로 검색하기'),
      body: Center(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <
              Widget>[
            Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: () => scanBarcodeNormal(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: colorThemeGreen,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.1,
                        horizontal: MediaQuery.of(context).size.width * 0.08),
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
                                  'assets/icons/barcode-outline.png'))),
                      blankBox(flex: 1),
                      Expanded(
                          flex: 2,
                          child: makeSemiTitle(
                              title: '바코드 스캔하기',
                              size: MediaQuery.of(context).size.width * 0.04))
                    ],
                  ),
                )),
            blankBox(flex: 1),
            Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: () => scanQR(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: colorThemeGreen,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.1,
                        horizontal: MediaQuery.of(context).size.width * 0.08),
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
                                  'assets/icons/qr-code-outline.png'))),
                      blankBox(flex: 1),
                      Expanded(
                          flex: 2,
                          child: makeSemiTitle(
                              title: 'QR코드 스캔하기',
                              size: MediaQuery.of(context).size.width * 0.04))
                    ],
                  ),
                )),
            blankBox(flex: 1),
            Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: () => startBarcodeScanStream(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: colorThemeGreen,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.1,
                        horizontal: MediaQuery.of(context).size.width * 0.08),
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
                                  'assets/icons/barcode-outline.png'))),
                      blankBox(flex: 1),
                      Expanded(
                          flex: 2,
                          child: makeSemiTitle(
                              title: '바코드 스트림 스캔하기',
                              size: MediaQuery.of(context).size.width * 0.04))
                    ],
                  ),
                )),
            Text('Scan result : $_scanBarcode\n',
                style: TextStyle(fontSize: 20))
          ]),
        ),
      ),
    );
  }
}
