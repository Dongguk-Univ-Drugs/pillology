import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pill/model/personal_pill_info.dart';

class CalendarDatabase {
  // get pill data
  Future<List<PersonalPillInfo>> getData() async {
    final response = await http.get('http://localhost:${env['PORT']}/user');
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
    print(pillinfo);
    var response =
        await http.post("http://localhost:${env['PORT']}/user/pilldb", body: pillinfo);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      print(response.statusCode);
      print('Response body: ${response.body}');
    }
  }

  // edit pill data
  void editPillInfo(PersonalPillInfo pillinfo) async {
    final _id = pillinfo.id;
    String myUrl = "http://localhost:${env['PORT']}/user/pilldb/$_id";

    await http.put(myUrl, body: pillinfo.toJson()).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
}
