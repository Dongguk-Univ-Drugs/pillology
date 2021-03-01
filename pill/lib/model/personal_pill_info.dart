import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PersonalPillInfo {
  @JsonKey(name: "_id")
  String id;
  String pillname = '';
  String startDate;
  String endDate;
  String morningTime;
  String afternoonTime;
  String eveningTime;
  String isMorningTimeSet;
  String isAfternoonTimeSet;
  String isEveningTimeSet;

  PersonalPillInfo(
      {this.id,
      this.pillname,
      this.startDate,
      this.endDate,
      this.morningTime,
      this.afternoonTime,
      this.eveningTime,
      this.isMorningTimeSet,
      this.isAfternoonTimeSet,
      this.isEveningTimeSet});

  factory PersonalPillInfo.fromJson(Map<String, dynamic> pillMap) {
    return PersonalPillInfo(
      id: pillMap['_id'],
      pillname: pillMap['pillname'],
      startDate: pillMap['startDate'],
      endDate: pillMap['endDate'],
      morningTime: pillMap['morningTime'],
      afternoonTime: pillMap['afternoonTime'],
      eveningTime: pillMap['eveningTime'],
      isMorningTimeSet: pillMap['isMorningTimeSet'],
      isAfternoonTimeSet: pillMap['isAfternoonTimeSet'],
      isEveningTimeSet: pillMap['isEveningTimeSet'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'pillname': pillname,
        'startDate': startDate,
        'endDate': endDate,
        'morningTime': morningTime,
        'afternoonTime': afternoonTime,
        'eveningTime': eveningTime,
        'isMorningTimeSet': isMorningTimeSet,
        'isAfternoonTimeSet': isAfternoonTimeSet,
        'isEveningTimeSet': isEveningTimeSet,
      };
}
