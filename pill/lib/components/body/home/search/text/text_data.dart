import 'package:flutter/material.dart';
import 'package:pill/utility/palette.dart';

var textInfoSubDropDownItem = <Text>[
  Text('100-신경계감각기관용 의약품'),
  Text('200-개개의 기관계용 의약품'),
  Text('300-대사성 의약품'),
  Text('400-조직세포의 기능용 의약품'),
  Text('600-항병원생물성 의약품'),
  Text('700-치료를 주목적으로 하지않는 의약품'),
  Text('800-마약')
];
var textInfoSubDropDownItem2 = <Text>[
  Text('전체'),
  Text('전문'),
  Text('일반'),
];
var shapeInfoSubDropDownItemColor = [
  {'name': '하양', 'color': Colors.white},
  {'name': '노랑', 'color': Colors.yellow},
  {'name': '주황', 'color': Colors.orange},
  {'name': '분홍', 'color': Colors.pink[200]},
  {'name': '빨강', 'color': Colors.red},
  {'name': '갈색', 'color': Colors.brown},
  {'name': '연두', 'color': Colors.lightGreen},
  {'name': '초록', 'color': Colors.green},
  {'name': '청록', 'color': Colors.cyan[200]},
  {'name': '파랑', 'color': Colors.blue},
  {'name': '남색', 'color': Color.fromRGBO(0, 0, 123, 1.0)},
  {'name': '자주', 'color': Colors.purple},
  {'name': '보라', 'color': Colors.deepPurple},
  {'name': '회색', 'color': Colors.grey},
  {'name': '검정', 'color': Colors.black},
  {'name': '투명', 'color': Colors.transparent}
];
var shapeInfoSubDropDownItemShape = {
  '원형': ImageIcon(AssetImage('assets/shapes/circle.png'), size: 30),
  '원반형': ImageIcon(AssetImage('assets/shapes/disc-shaped.png'), size: 30),
  '육각형': ImageIcon(AssetImage('assets/shapes/hexagon.png'), size: 30),
  '팔각형': ImageIcon(AssetImage('assets/shapes/octagon.png'), size: 30),
  '타원형': ImageIcon(AssetImage('assets/shapes/oval.png'), size: 30),
  '오각형': ImageIcon(AssetImage('assets/shapes/pentagon.png'), size: 30),
  '장방형': ImageIcon(AssetImage('assets/shapes/rectangle.png'), size: 30),
  '마름모형': ImageIcon(AssetImage('assets/shapes/rhombus.png'), size: 30),
  '삼각형': ImageIcon(AssetImage('assets/shapes/triangle.png'), size: 30)
};
var shapeInfoSubSlidingSegmentedData = {0: '정제', 1: '경질캡슐', 2: '연질캡슐'};
