import 'package:flutter/material.dart';

Widget loadingPage(BuildContext context) {
  return Center(
    child: Image(
        image: AssetImage('assets/gifs/loading.gif'),
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2),
  );
}
