import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pill/model/personal_pill_info.dart';

class CalendarDatabase {
  // get pill data
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

  // add new pill data
  Future<PersonalPillInfo> saveData(Map pillinfo) async {
    var jsonResponse = null;
    var response =
        await http.post("http://localhost:27017/user/pilldb", body: pillinfo);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      print('Response body: ${response.body}');
    }
  }

  // edit pill data
  void editPillInfo(PersonalPillInfo pillinfo) async {
    String myUrl =
        "http://localhost:27017/user/pilldb/601b9b30e763c78789064316";

    http.put(myUrl, body: pillinfo.toJson()).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
    
  }
}
