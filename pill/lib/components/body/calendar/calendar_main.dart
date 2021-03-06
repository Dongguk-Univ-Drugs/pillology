import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pill/components/body/calendar/calendar_db.dart';
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
var _currentDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  TextEditingController _pillNameController;
  List _selectedEvents;
  List<PersonalPillInfo> _pillInfo;
  Map<DateTime, List> _events;
  DateTime _selectedDay;
  CalendarDatabase calendarDatabase = new CalendarDatabase();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _pillNameController = TextEditingController();
    _pillInfo = List<PersonalPillInfo>();
    _events = {};
    _selectedEvents = _events[_currentDate] ?? [];
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
      future: calendarDatabase.getData(),
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
          for (int index = _pillInfo.length;
              index < snapshot.data.length;
              index++) {
            _pillInfo.add(snapshot.data[index]);
            DateTime dateTime =
                DateTime.parse(snapshot.data[index].startDate).toLocal();
            var difference = DateTime.parse(_pillInfo[index].endDate)
                .difference(DateTime.parse(_pillInfo[index].startDate))
                .inDays;

            for (int i = 0; i <= difference; i++) {
              if (_events[DateTime(
                      dateTime.year, dateTime.month, dateTime.day + i)] ==
                  null) {
                _events.putIfAbsent(
                    DateTime(dateTime.year, dateTime.month, dateTime.day + i),
                    () => [snapshot.data[index].pillname]);
              } else {
                _events.update(
                    DateTime(dateTime.year, dateTime.month, dateTime.day + i),
                    (value) => value + [snapshot.data[index].pillname]);
              }
            }
            _selectedEvents = _events[_currentDate] ?? [];
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
                              _pillNameController.text = "";
                              addPillDetail(context);
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
                  onTap: () {
                    _pillNameController.text = "";
                    showPillDetail(context, pillName);
                  },
                ),
              ))
          .toList(),
    );
  }

  void addPillDetail(BuildContext context) {
    var difference;
    Map<String, dynamic> pillinfo = {
      "_id": "",
      "pillname": "테스트1",
      "startDate": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString(),
      "endDate": DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString(),
      "morningTime": "9:00",
      "afternoonTime": "13:00",
      "eveningTime": "18:00",
      "isMorningTimeSet": "true",
      "isAfternoonTimeSet": "true",
      "isEveningTimeSet": "true",
    };

    _pillInfo.add(PersonalPillInfo.fromJson(pillinfo));
    var index = _pillInfo.length - 1;
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
                                calendarDatabase
                                    .saveData(_pillInfo[index].toJson());
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
                                  // TODO: 약 이름이 빈칸이면 추가되지 않도록 해야한다.
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
                                "${DateTime.parse(_pillInfo[index].startDate).toLocal().year}년 ${DateTime.parse(_pillInfo[index].startDate).toLocal().month}월 ${DateTime.parse(_pillInfo[index].startDate).toLocal().day}일",
                                style: TextStyle(color: Colors.black),
                              )),
                          Text("종료: "),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    this._pillInfo[index].endDate = DateTime(
                                            date.year, date.month, date.day)
                                        .toString();
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.ko);
                              },
                              child: Text(
                                "${DateTime.parse(_pillInfo[index].endDate).toLocal().year}년 ${DateTime.parse(_pillInfo[index].endDate).toLocal().month}월 ${DateTime.parse(_pillInfo[index].endDate).toLocal().day}일",
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

  void showPillDetail(BuildContext context, String pillname) {
    var difference;
    var index;
    for (int i = 0; i < _pillInfo.length; i++) {
      if (pillname == _pillInfo[i].pillname) {
        index = i;
      }
    }
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

                                // _events에서 삭제하고 추가
                                _events.forEach((key, value) {
                                  for (int i = 0; i < value.length; i++) {
                                    if (value[i] == pillname) {
                                      value.removeAt(i);
                                    }
                                  }
                                });
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
                                  this._events = _events;
                                  this._selectedEvents =
                                      _events[_selectedDay] ?? [];
                                });

                                // 추가한 데이터 저장
                                calendarDatabase.editPillInfo(_pillInfo[index]);
                                Navigator.of(context).pop();
                              },
                              child: Text("완료")),
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
                                        decoration: inputDecorationColor(
                                            pillname, Colors.white),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0),
                                      ),
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: colorEEE),
                                        color: colorThemeGreen,
                                      ),
                                    )),
                              ],
                            ),
                          ),
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
                                "${DateTime.parse(_pillInfo[index].startDate).toLocal().year}년 ${DateTime.parse(_pillInfo[index].startDate).toLocal().month}월 ${DateTime.parse(_pillInfo[index].startDate).toLocal().day}일",
                                style: TextStyle(color: Colors.black),
                              )),
                          Text("종료: "),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    this._pillInfo[index].endDate = DateTime(
                                            date.year, date.month, date.day)
                                        .toString();
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.ko);
                              },
                              child: Text(
                                "${DateTime.parse(_pillInfo[index].endDate).toLocal().year}년 ${DateTime.parse(_pillInfo[index].endDate).toLocal().month}월 ${DateTime.parse(_pillInfo[index].endDate).toLocal().day}일",
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
