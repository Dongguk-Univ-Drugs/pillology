class PersonalPillInfo {
  String pillname = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String morningTime;
  String afternoonTime;
  String eveningTime;
  bool isMorningTimeSet = false;
  bool isAfternoonTimeSet = false;
  bool isEveningTimeSet = false;
  
  // PersonalPillInfo(String pillName, DateTime startDate, DateTime endDate, String morningTime, String afternoonTime, String eveningTime,
  //     bool isMorningTimeSet, bool isAfternoonTimeSet, bool isEveningTimeSet) {
  //   this.pillName = pillName;
  //   this.startDate = startDate;
  //   this.endDate = endDate;
  //   this.morningTime = morningTime;
  //   this.afternoonTime = afternoonTime;
  //   this.eveningTime = eveningTime;
  //   this.isMorningTimeSet = isMorningTimeSet;
  //   this.isAfternoonTimeSet = isAfternoonTimeSet;
  //   this.isEveningTimeSet = isEveningTimeSet;
  // }

    PersonalPillInfo({this.pillname, this.startDate, this.endDate, this.morningTime, this.afternoonTime, this.eveningTime,
            this.isMorningTimeSet, this.isAfternoonTimeSet, this.isEveningTimeSet});
    factory PersonalPillInfo.fromJson(Map<String, dynamic> pillMap) {
        return PersonalPillInfo(
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
}
