import 'package:camera/camera.dart';
import 'package:pill/model/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//header
import 'components/header/header.dart';
// pages
import 'components/body/home/home_main.dart';
import 'components/body/maps/map_main.dart';
import 'components/body/calendar/calendar_main.dart';
import 'components/body/personal/personal_main.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PhotoSearchImageStore storage;
  initializeDateFormatting().then((_) => runApp(App()));
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int currentPageIndex = 0;

  List<Map<String, dynamic>> routePage = [
    {
      "pageIndex": 0,
      "title": Image(
        image: AssetImage('assets/icons/logo.png'),
        width: 200.0,
      ),
      "screen": HomeScreen()
    },
    {"pageIndex": 1, "title": "지도", "screen": Text("MAP SCREEN")},
    {"pageIndex": 2, "title": "캘린더", "screen": CalendarPage()},
    {"pageIndex": 3, "title": "나의약", "screen": Text("MYINFO SCREEN")}
  ];

  changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PhotoSearchImageStore>(
              create: (context) => PhotoSearchImageStore())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '이건뭐약',
            theme: ThemeData(primaryColor: Colors.white),
            home: Scaffold(
              appBar: customHeader(routePage[currentPageIndex]['title']),
              body: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: routePage[currentPageIndex]['screen'],
                  )),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentPageIndex,
                onTap: (int index) => changePage(index),
                selectedItemColor: Colors.black,
                items: [
                  BottomNavigationBarItem(
                      label: "홈",
                      icon: ImageIcon(
                          AssetImage('assets/icons/home-outline-black.png'),
                          size: 25),
                      activeIcon: ImageIcon(AssetImage('assets/icons/home.png'),
                          size: 25)),
                  BottomNavigationBarItem(
                      label: "지도",
                      icon: ImageIcon(
                          AssetImage('assets/icons/map-outline.png'),
                          size: 25),
                      activeIcon: ImageIcon(AssetImage('assets/icons/map.png'),
                          size: 25)),
                  BottomNavigationBarItem(
                      label: "캘린더",
                      icon: ImageIcon(
                          AssetImage('assets/icons/calendar-outline.png'),
                          size: 25),
                      activeIcon: ImageIcon(
                          AssetImage('assets/icons/calendar.png'),
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
            )));
  }
}
