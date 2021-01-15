import 'package:flutter/material.dart';
//header
import 'components/header/header.dart';
// pages
import 'components/body/home/home_main.dart';
import 'components/body/maps/map_main.dart';
import 'components/body/calendar/calendar_main.dart';
import 'components/body/personal/personal_main.dart';

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
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          appBar: customHeader(Image(
            image: AssetImage('assets/icons/logo.png'),
            width: 200.0,
          )),
          body: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: pages(pageIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            onTap: (int index) => changePage(index),
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  label: "홈",
                  icon: ImageIcon(
                      AssetImage('assets/icons/home-outline-black.png'),
                      size: 25),
                  activeIcon:
                      ImageIcon(AssetImage('assets/icons/home.png'), size: 25)),
              BottomNavigationBarItem(
                  label: "지도",
                  icon: ImageIcon(AssetImage('assets/icons/map-outline.png'),
                      size: 25),
                  activeIcon:
                      ImageIcon(AssetImage('assets/icons/map.png'), size: 25)),
              BottomNavigationBarItem(
                  label: "캘린더",
                  icon: ImageIcon(
                      AssetImage('assets/icons/calendar-outline.png'),
                      size: 25),
                  activeIcon: ImageIcon(AssetImage('assets/icons/calendar.png'),
                      size: 25)),
              BottomNavigationBarItem(
                  label: "나의 약",
                  icon: ImageIcon(AssetImage('assets/icons/person.png'),
                      size: 25),
                  activeIcon: ImageIcon(
                      AssetImage('assets/icons/person-outline.png'),
                      size: 25))
            ],
          ),
        ));
  }

  pages(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return Text("MAP SCREEN");
      case 2:
        return Text("CALENDAR SCREEN");
      case 3:
        return Text("PERSON SCREEN");
    }
  }
}
