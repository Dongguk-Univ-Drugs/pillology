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
  final String date;
  final String category;
  final int height;

  Data({this.title, this.url, this.category, this.date, this.height});

  factory Data.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Data(
        title: parsedJson['title'],
        url: parsedJson['url'],
        category: parsedJson['category'],
        date: parsedJson['date'],
        height: parsedJson['height'] != null ? parsedJson['height'] : 6400
    );
  }
}
