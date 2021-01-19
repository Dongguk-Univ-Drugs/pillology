import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/input_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2021, 1, 1): ['New Year\'s Day'],
};
final _currentDate =
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

  // Map<DateTime, Map<DateTime, List>> _events;
  Map<DateTime, List> _events;
  DateTime _selectedDay;
  DateTime _confirmedMorningTime;
  DateTime _confirmedAfternoonTime;
  DateTime _confirmedEveningTime;
  bool _isMorningTimeSet;
  bool _isAfternoonTimeSet;
  bool _isEveningTimeSet;
  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
    _pillNameController = TextEditingController();
    _confirmedMorningTime = DateTime.now();
    _confirmedAfternoonTime = DateTime.now();
    _confirmedEveningTime = DateTime.now();

    _isMorningTimeSet = false;
    _isAfternoonTimeSet = false;
    _isEveningTimeSet = false;
    _events = {
      _currentDate: ['타이레놀', '아스피린'],
    };
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildTableCalendar(),
              // _buildTableCalendarWithBuilders(),
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
                    icon: Image.asset('assets/icons/settings-outline.png'),
                    iconSize: 20,
                    onPressed: () {addPillDetail(context);
                    _pillNameController.text = "";}
                  )
                ],
              ),
              Expanded(child: _buildEventList()),
            ],
          ),
        ),
      ],
    ));
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
                  onTap: () => showPillDetail(context, pillName),
                ),
              ))
          .toList(),
    );
  }

  void addPillDetail(BuildContext context) {
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
                              emphasize: "약",
                              normalEnd: "알림 설정",
                              color: colorThemeGreen),
                          FlatButton(
                              onPressed: () {
                                if (_events[_selectedDay] == null) {
                                  _events.putIfAbsent(_selectedDay,
                                      () => [_pillNameController.text.trim()]);
                                } else {
                                  _events.update(
                                      _selectedDay,
                                      (value) =>
                                          value +
                                          [_pillNameController.text.trim()]);
                                }
                                this.setState(() {
                                  this._selectedEvents =
                                      _events[_selectedDay] ?? [];
                                  this._events = _events;
                                });
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
                                              if (_isMorningTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedMorningTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedMorningTime.hour.toString()}:${_confirmedMorningTime.minute.toString()}',
                                              style: _isMorningTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isMorningTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isMorningTimeSet = val;
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
                                              if (_isAfternoonTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedAfternoonTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedAfternoonTime.hour.toString()}:${_confirmedAfternoonTime.minute.toString()}',
                                              style: _isAfternoonTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isAfternoonTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isAfternoonTimeSet = val;
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
                                              if (_isEveningTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedEveningTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedEveningTime.hour.toString()}:${_confirmedEveningTime.minute.toString()}',
                                              style: _isEveningTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isEveningTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isEveningTimeSet = val;
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

  void showPillDetail(BuildContext context, String pillName) {
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
                              emphasize: "약",
                              normalEnd: "알림 설정",
                              color: colorThemeGreen),
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
                                child: Text(
                                  pillName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: colorEEE),
                                  color: colorThemeGreen,
                                ),
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
                                              if (_isMorningTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedMorningTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedMorningTime.hour.toString()}:${_confirmedMorningTime.minute.toString()}',
                                              style: _isMorningTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isMorningTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isMorningTimeSet = val;
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
                                              if (_isAfternoonTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedAfternoonTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedAfternoonTime.hour.toString()}:${_confirmedAfternoonTime.minute.toString()}',
                                              style: _isAfternoonTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isAfternoonTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isAfternoonTimeSet = val;
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
                                              if (_isEveningTimeSet) {
                                                DatePicker.showDateTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  setState(() {
                                                    _confirmedEveningTime =
                                                        date;
                                                  });
                                                }, locale: LocaleType.ko);
                                              }
                                            },
                                            child: Text(
                                              '${_confirmedEveningTime.hour.toString()}:${_confirmedEveningTime.minute.toString()}',
                                              style: _isEveningTimeSet
                                                  ? TextStyle(
                                                      color: Colors.black)
                                                  : TextStyle(
                                                      color: Colors.grey),
                                            )),
                                        FlutterSwitch(
                                          value: _isEveningTimeSet,
                                          onToggle: (val) {
                                            setState(() {
                                              _isEveningTimeSet = val;
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
