import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:pill/utility/box_decoration.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';

DateTime _currentDate = new DateTime.now();
EventList<Event> _markedDateMap;
//TODO: change list
final List<String> pillName = <String>['타이레놀', '아스피린', '몰라요'];

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
        if (day.day == 15) {
          return Center(
            child: Icon(Icons.local_airport),
          );
        } else {
          return null;
        }
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
                  height: 50,
                  color: Colors.white,
                  child: ElevatedButton(
                    child: Text(pillName[index]),
                    onPressed: () => showPillDetail(context, pillName[index]),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        alignment: Alignment.centerLeft),
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
      context: context,
      builder: (ctx) {
        return Container(
            decoration: boxDecorationNoShadow(),
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
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(pillName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: colorEEE),
                              color: colorThemeGreen,
                            ),
                          )),
                      
                    ],
                  ),
                )
              ],
            ));
      });
}
