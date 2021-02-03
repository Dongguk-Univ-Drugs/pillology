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

Future<List<PersonalPillInfo>> getData() async {
  final response = await http.get('http://localhost:27017/user');
  if (response.statusCode == 200) {
    final userMap = json.decode(response.body);
    List<PersonalPillInfo> result = [];
    for (int i = 0; i < userMap.length; i++) {
      result.add(PersonalPillInfo.fromJson(userMap[i]));
    }
    return result;
  } else {}
}

Future<PersonalPillInfo> saveData(Map pillinfo) async {
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
  Map<DateTime, List> _events;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _pillNameController = TextEditingController();
    _pillInfo = List<PersonalPillInfo>();
    _events = {};

    _selectedEvents = _events[_currentDate] ?? [];
    _calendarController = CalendarController();
    _selectedDay = _currentDate;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else if (snapshot.hasError) {
          return CircularProgressIndicator();
          // return Text('${snapshot.error}');
        } else {
          for (int index = 0; index < snapshot.data.length; index++) {
            _pillInfo.add(snapshot.data[index]);
            DateTime dateTime = DateTime.parse(snapshot.data[index].startDate);
            if (_events[dateTime] == null) {
              _events.putIfAbsent(
                  dateTime, () => [snapshot.data[index].pillname]);
            } else {
              _events.update(
                  dateTime, (value) => value + [snapshot.data[index].pillname]);
            }
          }
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _buildTableCalendar(),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        makeTitleWithColor(
                            normalStart: "복용하는",
                            emphasize: "약",
                            normalEnd: "",
                            color: colorThemeGreen),
                        IconButton(
                            icon: Image.asset('assets/icons/add-outline.png'),
                            iconSize: 20,
                            onPressed: () {
                              addPillDetail(context);
                              _pillNameController.text = "";
                            })
                      ],
                    ),
                    Expanded(child: _buildEventList()),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedDay = DateTime(day.year, day.month, day.day);
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'ko_KO',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: colorThemeGreen,
        todayColor: Colors.lightGreen,
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: colorThemeGreen,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((pillName) => Container(
                decoration: boxDecorationNoShadow(),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(pillName.toString()),
                  // onTap: () => showPillDetail(context, pillName),
                ),
              ))
          .toList(),
    );
  }

  void addPillDetail(BuildContext context) {
    var difference;
    Map<String, dynamic> pillinfo = {
      "pillname": "테스트1",
      "startDate": DateTime.now().toString(),
      "endDate": DateTime.now().toString(),
      "morningTime": "9:00",
      "afternoonTime": "13:00",
      "eveningTime": "18:00",
      "isMorningTimeSet": "true",
      "isAfternoonTimeSet": "true",
      "isEveningTimeSet": "true",
    };

    _pillInfo.add(PersonalPillInfo.fromJson(pillinfo));
    var index = _pillInfo.length - 1;

    // PersonalPillInfo에 다 저장하고, event에 업데이트 하고, save 하면 될 거 같음.
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          makeTitleWithColor(
                              normalStart: "",
                              emphasize: "약 ",
                              normalEnd: "알림 설정",
                              color: colorThemeGreen),
                          FlatButton(
                              onPressed: () {
                                // 달력에 표시
                                difference =
                                    DateTime.parse(_pillInfo[index].endDate)
                                        .difference(DateTime.parse(
                                            _pillInfo[index].startDate))
                                        .inDays;

                                for (int i = 0; i <= difference; i++) {
                                  DateTime dateTime = DateTime.parse(
                                      _pillInfo[index].startDate);
                                  if (_events[DateTime(dateTime.year,
                                          dateTime.month, dateTime.day + i)] ==
                                      null) {
                                    _events.putIfAbsent(
                                        DateTime(dateTime.year, dateTime.month,
                                            dateTime.day + i),
                                        () =>
                                            [_pillNameController.text.trim()]);
                                  } else {
                                    _events.update(
                                        DateTime(dateTime.year, dateTime.month,
                                            dateTime.day + i),
                                        (value) =>
                                            value +
                                            [_pillNameController.text.trim()]);
                                  }
                                }

                                this.setState(() {
                                  this._pillInfo[index].pillname =
                                      _pillNameController.text.trim();
                                  this._selectedEvents =
                                      _events[_selectedDay] ?? [];
                                  this._events = _events;
                                });
                                // 추가한 데이터 저장
                                saveData(_pillInfo[index].toJson());
                                Navigator.of(context).pop();
                              },
                              child: Text("저장")),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  controller: _pillNameController,
                                  decoration: inputDecoration("약 이름을 입력하세요."),
                                ),
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                              )),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("시작: "),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    this._pillInfo[index].startDate = DateTime(
                                            date.year, date.month, date.day)
                                        .toString();
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.ko);
                              },
                              child: Text(
                                "${DateTime.parse(_pillInfo[index].startDate).year}년 ${DateTime.parse(_pillInfo[index].startDate).month}월 ${DateTime.parse(_pillInfo[index].startDate).day}일",
                                style: TextStyle(color: Colors.black),
                              )),
                          Text("종료: "),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    this._pillInfo[index].startDate = DateTime(
                                            date.year, date.month, date.day)
                                        .toString();
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.ko);
                              },
                              child: Text(
                                "${DateTime.parse(_pillInfo[index].endDate).year}년 ${DateTime.parse(_pillInfo[index].endDate).month}월 ${DateTime.parse(_pillInfo[index].endDate).day}일",
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "복용 시간",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("아침"),
                                        FlatButton(
                                            onPressed: () {
                                              if (_pillInfo[index]
                                                      .isMorningTimeSet ==
                                                  'true') {
                                                DatePicker.showTime12hPicker(
                                                    context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _pillInfo[index]
                                                            .morningTime =
                                                        "${date.hour}:${date.minute}";
                                                  });
                                                }, currentTime: DateTime.now());
                                              }
                                            },
                                            child: Text(
                                              _pillInfo[index].morningTime,
                                              style: _pillInfo[index]
                                                          .isMorningTimeSet ==
                                                      'true'
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _pillInfo[index]
                                                      .isMorningTimeSet ==
                                                  "true"
                                              ? true
                                              : false,
                                          onToggle: (val) {
                                            setState(() {
                                              _pillInfo[index]
                                                  .isMorningTimeSet = "$val";
                                            });
                                          },
                                          activeColor: colorThemeGreen,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("점심"),
                                        FlatButton(
                                            onPressed: () {
                                              if (_pillInfo[index]
                                                      .isAfternoonTimeSet ==
                                                  'true') {
                                                DatePicker.showTime12hPicker(
                                                    context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _pillInfo[index]
                                                            .afternoonTime =
                                                        "${date.hour}:${date.minute}";
                                                  });
                                                }, currentTime: DateTime.now());
                                              }
                                            },
                                            child: Text(
                                              _pillInfo[index].afternoonTime,
                                              style: _pillInfo[index]
                                                          .isAfternoonTimeSet ==
                                                      'true'
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _pillInfo[index]
                                                      .isAfternoonTimeSet ==
                                                  "true"
                                              ? true
                                              : false,
                                          onToggle: (val) {
                                            setState(() {
                                              _pillInfo[index]
                                                  .isAfternoonTimeSet = "$val";
                                            });
                                          },
                                          activeColor: colorThemeGreen,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("저녁"),
                                        FlatButton(
                                            onPressed: () {
                                              if (_pillInfo[index]
                                                      .isEveningTimeSet ==
                                                  'true') {
                                                DatePicker.showTime12hPicker(
                                                    context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _pillInfo[index]
                                                            .eveningTime =
                                                        "${date.hour}:${date.minute}";
                                                  });
                                                }, currentTime: DateTime.now());
                                              }
                                            },
                                            child: Text(
                                              _pillInfo[index].eveningTime,
                                              style: _pillInfo[index]
                                                          .isEveningTimeSet ==
                                                      'true'
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _pillInfo[index]
                                                      .isEveningTimeSet ==
                                                  "true"
                                              ? true
                                              : false,
                                          onToggle: (val) {
                                            setState(() {
                                              _pillInfo[index]
                                                  .isEveningTimeSet = "$val";
                                            });
                                          },
                                          activeColor: colorThemeGreen,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ],
                ));
          });
        });
  }
}
/*
  // 데이터 추가
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
  */

//이렇게 저장하면 될 듯.
// saveData(_pillInfo[index].toJson());