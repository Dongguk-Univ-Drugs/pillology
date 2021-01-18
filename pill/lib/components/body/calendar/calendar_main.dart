import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

DateTime _currentDate = new DateTime.now();
DateTime _confirmedMorningTime = new DateTime.now();
DateTime _confirmedAfternoonTime = new DateTime.now();
DateTime _confirmedEveningTime = new DateTime.now();
EventList<Event> _markedDateMap;
bool _isMorningTimeSet = false;
bool _isAfternoonTimeSet = false;
bool _isEveningTimeSet = false;

//TODO: change list
final List<String> pillName = <String>['타이레놀', '아스피린', '몰라요'];

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();

    _confirmedMorningTime = DateTime.now();
    _confirmedAfternoonTime = DateTime.now();
    _confirmedEveningTime = DateTime.now();

    _isMorningTimeSet = false;
    _isAfternoonTimeSet = false;
    _isEveningTimeSet = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Expanded(
          flex: 2,
          child: calendar(context),
        ),
        Expanded(
          flex: 1,
          child: pillList(context),
        ),
      ],
    ));
  }
}

Container calendar(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015),
    decoration: boxDecorationNoShadow(),
    child: CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        // this.setState(() => _currentDate = date);
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      //      weekDays: null, /// for pass null when you do not want to render weekDays
      //      headerText: Container( /// Example for rendering custom header
      //        child: Text('Custom Header'),
      //      ),
      customDayBuilder: (
        /// you can provide your own build function to make custom day containers
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        /// This way you can build custom containers for specific days only, leaving rest as default.

        // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
        // if (day.day == 15) {
        //   return Center(
        //     child: Icon(Icons.local_airport),
        //   );
        // } else {
        //   return null;
        // }
      },
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: false,

      /// null for not rendering any border, true for circular border, false for rectangular border
    ),
  );
}

Container pillList(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015),
    decoration: boxDecorationNoShadow(),
    child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              makeTitleWithColor(
                  normalStart: "복용하는",
                  emphasize: "약",
                  normalEnd: "",
                  color: colorThemeGreen),
              ImageIcon(AssetImage('assets/icons/settings-outline.png'),
                  size: 20, color: Colors.black87),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
              height: 2.0,
            )),
        Expanded(
          flex: 6,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: pillName.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: boxDecorationNoShadow(),
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.001),
                  child: FlatButton(
                    child: Text(pillName[index]),
                    onPressed: () => showPillDetail(context, pillName[index]),
                  ),
                );
              }),
        )
      ],
    ),
  );
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
                                                  _confirmedMorningTime = date;
                                                });
                                              }, locale: LocaleType.ko);
                                            }
                                          },
                                          child: Text(
                                            '${_confirmedMorningTime.hour.toString()}:${_confirmedMorningTime.minute.toString()}',
                                            style: _isMorningTimeSet
                                                ? TextStyle(color: Colors.black)
                                                : TextStyle(color: Colors.grey),
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
                                                ? TextStyle(color: Colors.black)
                                                : TextStyle(color: Colors.grey),
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
                                                  _confirmedEveningTime = date;
                                                });
                                              }, locale: LocaleType.ko);
                                            }
                                          },
                                          child: Text(
                                            '${_confirmedEveningTime.hour.toString()}:${_confirmedEveningTime.minute.toString()}',
                                            style: _isEveningTimeSet
                                                ? TextStyle(color: Colors.black)
                                                : TextStyle(color: Colors.grey),
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
