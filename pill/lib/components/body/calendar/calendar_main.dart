// import 'package:flutter/material.dart';
// import 'package:pill/model/personal_pill_info.dart';
// import 'package:pill/utility/box_decoration.dart';
// import 'package:pill/utility/input_decoration.dart';
// import 'package:pill/utility/palette.dart';
// import 'package:pill/utility/textify.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:http/http.dart' as http;

// // Example holidays
// final Map<DateTime, List> _holidays = {
//   DateTime(2021, 1, 1): ['New Year\'s Day'],
// };
// final _currentDate =
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   CalendarController _calendarController;
//   TextEditingController _pillNameController;
//   List _selectedEvents;
//   List<PersonalPillInfo> _pillInfo;


//   // 여기서 index 자리에 있는 걸,, 가져와서 get 함수 쓸 수 있는 거임. 그러니까 index.js 에서 만들어준 route.get 이런 함수를 쓸 수 있는 거다.
//   // 거기서 만들고 저장하고, 이런거 하면 될 것 같음. get으로 가져오고, post로 보내주니까 그거 잘 활용해서.. 
//   // fetchData() async {
//   //   final response = await http.get('http://127.0.0.1:3000/index');

//   //   if (response.statusCode == 200) {
//   //     return JsonArray.fromJson(jsonDecode(response.body));
//   //   } else {
//   //     throw Exception('FAILED TO FETCH');
//   //   }
//   // }

//   // Map<DateTime, Map<DateTime, List>> _events;
//   Map<DateTime, List> _events;
//   DateTime _selectedDay;
// //이벤트에. 날짜 추가..
//   //  final difference = date2.difference(birthday).inDays;
//   var difference;

//   @override
//   void initState() {
//     super.initState();
//     _calendarController = CalendarController();
//     _pillNameController = TextEditingController();

//     _pillInfo = List<PersonalPillInfo>();
//     // TODO: initialize
//     PersonalPillInfo pilldetail = new PersonalPillInfo(
//         '타이레놀',
//         DateTime(2021, 1, 21),
//         DateTime(2021, 1, 23),
//         '9:00',
//         '13:00',
//         '17:00',
//         true,
//         true,
//         true);
//     _pillInfo.add(pilldetail);
//     _events = {
//       _pillInfo[0].startDate: [_pillInfo[0].pillName],
//     };

//     _selectedEvents = _events[_currentDate] ?? [];
//     _calendarController = CalendarController();
//     _selectedDay = _currentDate;

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _calendarController.dispose();
//     super.dispose();
//   }

//   void _onDaySelected(DateTime day, List events, List holidays) {
//     print('CALLBACK: _onDaySelected');
//     setState(() {
//       _selectedDay = DateTime(day.year, day.month, day.day);
//       _selectedEvents = events;
//     });
//   }

//   void _onVisibleDaysChanged(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onVisibleDaysChanged');
//   }

//   void _onCalendarCreated(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onCalendarCreated');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               _buildTableCalendar(),
//               // _buildTableCalendarWithBuilders(),
//               const SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   makeTitleWithColor(
//                       normalStart: "복용하는",
//                       emphasize: "약",
//                       normalEnd: "",
//                       color: colorThemeGreen),
//                   IconButton(
//                       icon: Image.asset('assets/icons/add-outline.png'),
//                       iconSize: 20,
//                       onPressed: () {
//                         addPillDetail(context);
//                         _pillNameController.text = "";
//                       })
//                 ],
//               ),
//               Expanded(child: _buildEventList()),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }

//   // Simple TableCalendar configuration (using Styles)
//   Widget _buildTableCalendar() {
//     return TableCalendar(
//       locale: 'ko_KO',
//       calendarController: _calendarController,
//       events: _events,
//       holidays: _holidays,
//       startingDayOfWeek: StartingDayOfWeek.sunday,
//       calendarStyle: CalendarStyle(
//         selectedColor: colorThemeGreen,
//         todayColor: Colors.lightGreen,
//         markersColor: Colors.brown[700],
//         outsideDaysVisible: false,
//       ),
//       headerStyle: HeaderStyle(
//         formatButtonTextStyle:
//             TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//         formatButtonDecoration: BoxDecoration(
//           color: colorThemeGreen,
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//       ),
//       onDaySelected: _onDaySelected,
//       onVisibleDaysChanged: _onVisibleDaysChanged,
//       onCalendarCreated: _onCalendarCreated,
//     );
//   }

//   Widget _buildEventList() {
//     return ListView(
//       children: _selectedEvents
//           .map((pillName) => Container(
//                 decoration: boxDecorationNoShadow(),
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                 child: ListTile(
//                   title: Text(pillName.toString()),
//                   onTap: () => showPillDetail(context, pillName),
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   void addPillDetail(BuildContext context) {
//     PersonalPillInfo pilldetail = new PersonalPillInfo(
//         '타이레놀',
//         DateTime(2021, 1, 21),
//         DateTime(2021, 1, 21),
//         '9:00',
//         '13:00',
//         '17:00',
//         false,
//         false,
//         false);
//     var index = _pillInfo.length;
//     _pillInfo.add(pilldetail);
 
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         context: context,
//         builder: (ctx) {
//           return StatefulBuilder(  
//               builder: (BuildContext context, StateSetter setState) {
//             return Container(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           makeTitleWithColor(
//                               normalStart: "",
//                               emphasize: "약 ",
//                               normalEnd: "알림 설정",
//                               color: colorThemeGreen),
//                           FlatButton(
//                               onPressed: () {
//                                 difference = _pillInfo[index]
//                                     .endDate
//                                     .difference(_pillInfo[index].startDate)
//                                     .inDays;
//                                 for (int i = 0; i <= difference; i++) {
//                                   if (_events[DateTime(
//                                           _pillInfo[index].startDate.year,
//                                           _pillInfo[index].startDate.month,
//                                           _pillInfo[index].startDate.day +
//                                               i)] ==
//                                       null) {
//                                     _events.putIfAbsent(
//                                         DateTime(
//                                             _pillInfo[index].startDate.year,
//                                             _pillInfo[index].startDate.month,
//                                             _pillInfo[index].startDate.day + i),
//                                         () =>
//                                             [_pillNameController.text.trim()]);
//                                   } else {
//                                     _events.update(
//                                         DateTime(
//                                             _pillInfo[index].startDate.year,
//                                             _pillInfo[index].startDate.month,
//                                             _pillInfo[index].startDate.day + i),
//                                         (value) =>
//                                             value +
//                                             [_pillNameController.text.trim()]);
//                                   }
//                                 }

//                                 this.setState(() {
//                                   this._pillInfo[index].pillName =
//                                       _pillNameController.text.trim();
//                                   this._selectedEvents =
//                                       _events[_selectedDay] ?? [];
//                                   this._events = _events;
//                                 });
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text("저장")),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 child: TextFormField(
//                                   controller: _pillNameController,
//                                   decoration: inputDecoration("약 이름을 입력하세요."),
//                                 ),
//                                 margin: EdgeInsets.only(
//                                     left: MediaQuery.of(context).size.width *
//                                         0.02),
//                               )),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text("시작: "),
//                           FlatButton(
//                               onPressed: () {
//                                 DatePicker.showDatePicker(context,
//                                     showTitleActions: true,
//                                     minTime: DateTime.now(),
//                                     onChanged: (date) {}, onConfirm: (date) {
//                                   setState(() {
//                                     this._pillInfo[index].startDate = DateTime(
//                                         date.year, date.month, date.day);
//                                   });
//                                 },
//                                     currentTime: DateTime.now(),
//                                     locale: LocaleType.ko);
//                               },
//                               child: Text(
//                                 "${_pillInfo[index].startDate.year.toString()}년 ${_pillInfo[index].startDate.month.toString()}월 ${_pillInfo[index].startDate.day.toString()}일",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                           Text("종료: "),
//                           FlatButton(
//                               onPressed: () {
//                                 DatePicker.showDatePicker(context,
//                                     showTitleActions: true,
//                                     minTime: DateTime.now(),
//                                     onChanged: (date) {}, onConfirm: (date) {
//                                   setState(() {
//                                     this._pillInfo[index].endDate = DateTime(
//                                         date.year, date.month, date.day);
//                                   });
//                                 },
//                                     currentTime: DateTime.now(),
//                                     locale: LocaleType.ko);
//                               },
//                               child: Text(
//                                 "${_pillInfo[index].endDate.year.toString()}년 ${_pillInfo[index].endDate.month.toString()}월 ${_pillInfo[index].endDate.day.toString()}일",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         flex: 7,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: Text(
//                                   "복용 시간",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("아침"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isMorningTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .morningTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].morningTime,
//                                               style: _pillInfo[index]
//                                                       .isMorningTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value:
//                                               _pillInfo[index].isMorningTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isMorningTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("점심"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isAfternoonTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .afternoonTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].afternoonTime,
//                                               style: _pillInfo[index]
//                                                       .isAfternoonTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value: _pillInfo[index]
//                                               .isAfternoonTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isAfternoonTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("저녁"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isEveningTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .eveningTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].eveningTime,
//                                               style: _pillInfo[index]
//                                                       .isEveningTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value:
//                                               _pillInfo[index].isEveningTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isEveningTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         )),
//                   ],
//                 ));
//           });
//         });
//   }

//   void showPillDetail(BuildContext context, String pillName) {
//     var index = _pillInfo.length - 1;
//     for (int i = 0; i < _pillInfo.length; i++) {
//       if (pillName == _pillInfo[i].pillName) {
//         index = i;
//       }
//     }
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         context: context,
//         builder: (ctx) {
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//             return Container(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           makeTitleWithColor(
//                               normalStart: "",
//                               emphasize: "약 ",
//                               normalEnd: "알림 설정",
//                               color: colorThemeGreen),
//                           FlatButton(
//                               onPressed: () {
//                                 difference = _pillInfo[index]
//                                     .endDate
//                                     .difference(_pillInfo[index].startDate)
//                                     .inDays;
//                                 for (int i = 0; i <= difference; i++) {
//                                   if (_events[DateTime(
//                                           _pillInfo[index].startDate.year,
//                                           _pillInfo[index].startDate.month,
//                                           _pillInfo[index].startDate.day +
//                                               i)] ==
//                                       null) {
//                                     _events.putIfAbsent(
//                                         DateTime(
//                                             _pillInfo[index].startDate.year,
//                                             _pillInfo[index].startDate.month,
//                                             _pillInfo[index].startDate.day + i),
//                                         () => [pillName]);
//                                   } else {
//                                     _events.update(
//                                         DateTime(
//                                             _pillInfo[index].startDate.year,
//                                             _pillInfo[index].startDate.month,
//                                             _pillInfo[index].startDate.day + i),
//                                         (value) => value + [pillName]);
//                                   }
//                                 }
//                                 this.setState(() {
//                                   this._events = _events;
//                                 });
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text("완료")),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         pillName,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       margin: EdgeInsets.all(20),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: colorEEE),
//                                         color: colorThemeGreen,
//                                       ),
//                                     )),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // 복용 기간 설정
//                     Expanded(
//                       flex: 3,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text("시작: "),
//                           FlatButton(
//                               onPressed: () {
//                                 DatePicker.showDatePicker(context,
//                                     showTitleActions: true,
//                                     minTime: DateTime.now(),
//                                     onChanged: (date) {}, onConfirm: (date) {
//                                   setState(() {
//                                     _pillInfo[index].startDate = DateTime(
//                                         date.year, date.month, date.day);
//                                   });
//                                 },
//                                     currentTime: DateTime.now(),
//                                     locale: LocaleType.ko);
//                               },
//                               child: Text(
//                                 "${_pillInfo[index].startDate.year.toString()}년 ${_pillInfo[index].startDate.month.toString()}월 ${_pillInfo[index].startDate.day.toString()}일",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                           Text("종료: "),
//                           FlatButton(
//                               onPressed: () {
//                                 DatePicker.showDatePicker(context,
//                                     showTitleActions: true,
//                                     minTime: DateTime.now(),
//                                     onChanged: (date) {}, onConfirm: (date) {
//                                   setState(() {
//                                     _pillInfo[index].endDate = DateTime(
//                                         date.year, date.month, date.day);
//                                   });
//                                 },
//                                     currentTime: DateTime.now(),
//                                     locale: LocaleType.ko);
//                               },
//                               child: Text(
//                                 "${_pillInfo[index].endDate.year.toString()}년 ${_pillInfo[index].endDate.month.toString()}월 ${_pillInfo[index].endDate.day.toString()}일",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                         ],
//                       ),
//                     ),
//                     // 복용 시간 설정
//                     Expanded(
//                         flex: 7,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: Text(
//                                   "복용 시간",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("아침"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isMorningTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .morningTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].morningTime,
//                                               style: _pillInfo[index]
//                                                       .isMorningTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value:
//                                               _pillInfo[index].isMorningTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isMorningTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("점심"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isAfternoonTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .afternoonTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].afternoonTime,
//                                               style: _pillInfo[index]
//                                                       .isAfternoonTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value: _pillInfo[index]
//                                               .isAfternoonTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isAfternoonTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Expanded(
//                                 flex: 5,
//                                 child: Row(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text("저녁"),
//                                         FlatButton(
//                                             onPressed: () {
//                                               // TODO: 원래 있는 거 수정한다면 length가 아니라 index로
//                                               if (_pillInfo[index]
//                                                   .isEveningTimeSet) {
//                                                 DatePicker.showTime12hPicker(
//                                                     context,
//                                                     showTitleActions: true,
//                                                     onChanged: (date) {},
//                                                     onConfirm: (date) {
//                                                   setState(() {
//                                                     _pillInfo[index]
//                                                             .eveningTime =
//                                                         "${date.hour}:${date.minute}";
//                                                   });
//                                                 }, currentTime: DateTime.now());
//                                               }
//                                             },
//                                             child: Text(
//                                               _pillInfo[index].eveningTime,
//                                               style: _pillInfo[index]
//                                                       .isEveningTimeSet
//                                                   ? TextStyle(
//                                                       color: Colors.black)
//                                                   : TextStyle(
//                                                       color: Colors.grey),
//                                             )),
//                                         FlutterSwitch(
//                                           value:
//                                               _pillInfo[index].isEveningTimeSet,
//                                           onToggle: (val) {
//                                             setState(() {
//                                               _pillInfo[index]
//                                                   .isEveningTimeSet = val;
//                                             });
//                                           },
//                                           activeColor: colorThemeGreen,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         )),
//                   ],
//                 ));
//           });
//         });
//   }
// }