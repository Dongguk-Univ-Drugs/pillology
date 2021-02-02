class TextSearchResult {
  final String entpName; // 제조회사 이름
  final String itemName; // 의약품 이름
  final String itemEngName; // 의약품 영어 이름
  final String itemSeq; // 품목기준코드
  final String efcyQesitm; // 효능
  final String useMethodQesitm; // 사용법
  final String atpnWarnQesitm; // 주의사항 경고
  final String atpnQesitm; // 주의사항
  final String intrcQesitm; // 상호작용
  final String seQesitm; // 부작용
  final String depositMethodQesitm; // 보관법
  final String openDe; // 공개일자
  final String updateDe; // 수정일자
  final String itemImage; // 낱알이미지

  TextSearchResult(
      {this.entpName,
      this.itemName,
      this.itemEngName,
      this.itemSeq,
      this.efcyQesitm,
      this.useMethodQesitm,
      this.atpnWarnQesitm,
      this.atpnQesitm,
      this.intrcQesitm,
      this.seQesitm,
      this.depositMethodQesitm,
      this.openDe,
      this.updateDe,
      this.itemImage});

  factory TextSearchResult.fromJson(Map<String, dynamic> parsedJson) {

    String _itemName = parsedJson['itemName'].toString();

    String _korName, _engName;
    if(_itemName.contains('(수출명:')) {
      // parse : KOR
      _korName = _itemName.substring(0,_itemName.indexOf('(수출명:'));
      // parse : ENG
      _engName = _itemName.substring(_itemName.indexOf('(수출명:'), _itemName.length);
    } else {
      _korName = _itemName;
      _engName = "";
    }
    return TextSearchResult(
        entpName: parsedJson['entpName'],
        itemName: _korName,
        itemEngName: _engName,
        efcyQesitm: parsedJson['efcyQesitm'],
        useMethodQesitm: parsedJson['useMethodQesitm'],
        atpnWarnQesitm: parsedJson['atpnWarnQesitm'],
        atpnQesitm: parsedJson['atpnQesitm'],
        intrcQesitm: parsedJson['intrcQesitm'],
        seQesitm: parsedJson['seQesitm'],
        depositMethodQesitm: parsedJson['depositMethodQesitm'],
        openDe: parsedJson['openDe'],
        updateDe: parsedJson['updateDe'],
        itemImage: parsedJson['itemImage']);
  }
}

class Response {
  final Map<dynamic, dynamic> header;
  final Map<dynamic, dynamic> body;

  Response({this.body, this.header});

  factory Response.fromJson(Map<dynamic, dynamic> json) {
    return Response(header: json['header'], body: json['body']);
  }
}

class ResponseHeader {
  final String resultCode; // 결과코드
  final String resultMsg; // 결과메세지

  ResponseHeader({this.resultCode, this.resultMsg});

  factory ResponseHeader.fromJson(Map<dynamic, dynamic> json) {
    return ResponseHeader(
        resultCode: json['resultCode'], resultMsg: json['resultMsg']);
  }
}

class ResponseBody {
  final int numOfRows; // 한 페이지 결과 수
  final int pageNo; // 페이지 번호
  final int totalCount; // 전체 결과 수
  final List<TextSearchResult> items;

  ResponseBody({this.items, this.numOfRows, this.pageNo, this.totalCount});

  factory ResponseBody.fromJson(Map<dynamic, dynamic> json) {

    var itemList = json['items'] as List;
    List<TextSearchResult> _itemList = itemList.map((element) => TextSearchResult.fromJson(element)).toList();

    return ResponseBody(
        numOfRows: json['numOfRows'],
        pageNo: json['pageNo'],
        totalCount: json['totalCount'],
        items: _itemList);
  }
}
