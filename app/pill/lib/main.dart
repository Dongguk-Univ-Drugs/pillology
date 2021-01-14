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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '이건뭐약',
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
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
}
