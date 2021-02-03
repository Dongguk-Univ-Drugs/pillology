import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pill/model/personal_pill_info.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/input_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2021, 1, 1): ['New Year\'s Day'],
};
final _currentDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

Future<PersonalPillInfo> getData() async {
  final response = await http.get('http://localhost:27017/user');

  if (response.statusCode == 200) {
    final userMap = json.decode(response.body);
    return PersonalPillInfo.fromJson(userMap[0]);
  } else {}
}

Future<PersonalPillInfo> saveData(Map pillinfo) async {
  // Map data = {'pillname': pillname, };
  var jsonResponse = null;
  var response =
      await http.post("http://localhost:27017/user/pilldb", body: pillinfo);

  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } else {
    print('Response body: ${response.body}');
  }
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  TextEditingController _pillNameController;
  List _selectedEvents;
  List<PersonalPillInfo> _pillInfo;
  // Map<DateTime, List> _events;
  // DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _pillNameController = TextEditingController();
    _pillInfo = List<PersonalPillInfo>();

    // 이 부분을 그냥 getData 해서 추가하도록 하자.
    // // TODO: initialize
    // PersonalPillInfo pilldetail = new PersonalPillInfo(
    //     '타이레놀',
    //     DateTime(2021, 1, 21),
    //     DateTime(2021, 1, 23),
    //     '9:00',
    //     '13:00',
    //     '17:00',
    //     true,
    //     true,
    //     true);
    // _pillInfo.add(pilldetail);
    // _events = {
    //   _pillInfo[0].startDate: [_pillInfo[0].pillName],
    // };

    // _selectedEvents = _events[_currentDate] ?? [];
    // _calendarController = CalendarController();
    // _selectedDay = _currentDate;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  // void _onDaySelected(DateTime day, List events, List holidays) {
  //   print('CALLBACK: _onDaySelected');
  //   setState(() {
  //     _selectedDay = DateTime(day.year, day.month, day.day);
  //     _selectedEvents = events;
  //   });
  // }

  // void _onVisibleDaysChanged(
  //     DateTime first, DateTime last, CalendarFormat format) {
  //   print('CALLBACK: _onVisibleDaysChanged');
  // }

  // void _onCalendarCreated(
  //     DateTime first, DateTime last, CalendarFormat format) {
  //   print('CALLBACK: _onCalendarCreated');
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 변수에 저장할 필요없이 Text 위젯에 바로 전달해도 된다.
              // userId는 int 자료형을 갖기 때문에 문자열 변환이 필요하다.
              final pillname = snapshot.data.pillname;
              Map pillinfo = {
                "pillname": "테스트1",
                "startDate": "2021-1-20",
                "endDate": "2021-1-25",
                "morningTime": "9:00",
                "afternoonTime": "13:00",
                "eveningTime": "18:00",
                "isMorningTimeSet": "true",
                "isAfternoonTimeSet": "true",
                "isEveningTimeSet": "true",
              };
              saveData(pillinfo);
              return Column(
                children: <Widget>[
                  Center(child: Text(pillname)),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
// "pillname": "테스트1",
// "startDate": "2021-1-20",
// "endDate": "2021-1-25",
// "morningTime": "9:00",
// "eveningTime": "18:00",
// "isMorningTimeSet": true,
// "isAfternoonTimeSet": true,
// "isEveningTimeSet": true,
