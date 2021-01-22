class JsonArray {
  final List<Data> result;

  JsonArray({this.result});

  factory JsonArray.fromJson(var parsedJson) {
    var itemList = parsedJson as List;
    List<Data> resultList = itemList.map((e) => Data.fromJson(e)).toList();

    return JsonArray(result: resultList);
  }
}

class Data {
  final String title;
  final String url;

  Data({this.title, this.url});

  factory Data.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Data(title: parsedJson['title'], url: parsedJson['url']);
  }
}
