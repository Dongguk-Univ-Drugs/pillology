class PersonalPillInfo {
  String pillName = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String morningTime;
  String afternoonTime;
  String eveningTime;
  bool isMorningTimeSet = false;
  bool isAfternoonTimeSet = false;
  bool isEveningTimeSet = false;
  PersonalPillInfo(String pillName, DateTime startDate, DateTime endDate, String morningTime, String afternoonTime, String eveningTime,
      bool isMorningTimeSet, bool isAfternoonTimeSet, bool isEveningTimeSet) {
    this.pillName = pillName;
    this.startDate = startDate;
    this.endDate = endDate;
    this.morningTime = morningTime;
    this.afternoonTime = afternoonTime;
    this.eveningTime = eveningTime;
    this.isMorningTimeSet = isMorningTimeSet;
    this.isAfternoonTimeSet = isAfternoonTimeSet;
    this.isEveningTimeSet = isEveningTimeSet;
  }
}
