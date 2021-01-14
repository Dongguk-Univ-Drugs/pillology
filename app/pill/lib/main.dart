import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int pageIndex = 0;

  changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '이건뭐약',
        home: Scaffold(
          body: Center(
            child: pages(pageIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            onTap: (int index) => changePage(index),
            items: [
              BottomNavigationBarItem(
                  label: "홈",
                  icon:
                      ImageIcon(AssetImage('images/icons/home.png'), size: 25)),
              BottomNavigationBarItem(
                  label: "지도",
                  icon:
                      ImageIcon(AssetImage('images/icons/map.png'), size: 25)),
              BottomNavigationBarItem(
                  label: "캘린더",
                  icon: ImageIcon(AssetImage('images/icons/calendar.png'),
                      size: 25)),
              BottomNavigationBarItem(
                  label: "나의 약",
                  icon: ImageIcon(AssetImage('images/icons/person.png'),
                      size: 25))
            ],
          ),
        ));
  }

  pages(int index) {
    switch(index) {
      case 0:
        return Text("HOME SCREEN");
      case 1:
        return Text("MAP SCREEN");
      case 2:
        return Text("CALENDAR SCREEN");
      case 3:
        return Text("PERSON SCREEN");
    }
  }
}
