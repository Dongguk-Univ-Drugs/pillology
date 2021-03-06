// parsed Data
import 'package:pill/model/search/dur_search_result.dart';

class ParsedSearchResult {
  final TextSearchResult txt;
  final DurSearchResult dur;
  final DurPrdSearchResult durPrd;

  ParsedSearchResult({this.dur, this.durPrd, this.txt});
}

class TextSearchResult {
  final String entpName; // 제조회사 이름
  final String itemName; // 의약품 이름
  final String itemEngName; // 의약품 영어이름
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
    String name = parsedJson['itemName'];
    String _korName, _engName;
    if (name.contains("(수출명:")) {
      // kor name
      _korName = name.substring(0, name.indexOf("(수출명:"));
      // eng name
      _engName = name.substring(name.indexOf("(수출명:") + 5, name.length - 1);
    } else {
      _korName = name;
      _engName = '';
    }

    // replace pattern <p>---</p>
    // things to replace list
    var _xmlList = [
      'useMethodQesitm',
      'atpnQesitm',
      'atpnWarnQesitm',
      'intrcQesitm',
      'seQesitm',
      'depositMethodQesitm',
      'efcyQesitm'
    ];

    var _inJson = {
      '_useMethodQesitm': '',
      '_atpnQesitm': '',
      '_atpnWarnQesitm': '',
      '_intrcQesitm': '',
      '_seQesitm': '',
      '_depositMethodQesitm': '',
      'efcyQesitm': ''
    };

    // replaceAll(new RegExp(r"[(<p>)(</p>)]"), '');
    // on index
    for (String item in _xmlList) {
      if (parsedJson[item] is String) {
        String temp = parsedJson[item];
        _inJson["_" + item] = temp.replaceAll(new RegExp(r"<p>"), '');
        _inJson["_" + item] =
            _inJson["_" + item].replaceAll(new RegExp(r"</p>"), '\n\n');
      } else {
        _inJson["_" + item] = parsedJson[item];
      }
    }

    return TextSearchResult(
        entpName: parsedJson['entpName'],
        itemName: _korName,
        itemEngName: _engName,
        efcyQesitm: _inJson['_efcyQesitm'],
        useMethodQesitm: _inJson['_useMethodQesitm'],
        atpnWarnQesitm: _inJson['_atpnWarnQesitm'],
        atpnQesitm: _inJson['_atpnQesitm'],
        intrcQesitm: _inJson['_intrcQesitm'],
        seQesitm: _inJson['_seQesitm'],
        depositMethodQesitm: _inJson['_depositMethodQesitm'],
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
    var _itemList = [];
    // list parsing
    if (itemList != null) {
      itemList.asMap().forEach((index, value) {
        if (index + 1 < itemList.length) {
          if (value['itemName'] != itemList[index + 1]['itemName'])
            _itemList.add(value);
        }
      });
    } else
      print('itemList as Map not working');

    List<TextSearchResult> parsedList =
        _itemList.map((element) => TextSearchResult.fromJson(element)).toList();

    return ResponseBody(
        numOfRows: json['numOfRows'],
        pageNo: json['pageNo'],
        totalCount: json['totalCount'],
        items: parsedList);
  }
}
