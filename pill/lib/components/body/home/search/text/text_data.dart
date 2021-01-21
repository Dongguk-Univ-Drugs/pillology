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
var shapeInfoSubDropDownItemColor = <Color>[
  Colors.green,
  Colors.red,
  Colors.greenAccent,
  Colors.cyan,
  Colors.purple,
  Colors.yellow,
  Colors.blue,
  Colors.black,
  Colors.brown,
  Colors.orange,
  Colors.teal,
  Colors.purpleAccent,
  Colors.blueGrey,
  Colors.tealAccent,
  Colors.deepOrangeAccent,
  Colors.lightBlueAccent
];
var shapeInfoSubDropDownItemShape = {
  '원형' : ImageIcon(AssetImage('assets/shapes/circle.png'), size: 30),
  '원반형' : ImageIcon(AssetImage('assets/shapes/disc-shaped.png'), size: 30),
  '육각형' : ImageIcon(AssetImage('assets/shapes/hexagon.png'), size: 30),
  '팔각형' : ImageIcon(AssetImage('assets/shapes/octagon.png'), size: 30),
  '타원형' : ImageIcon(AssetImage('assets/shapes/oval.png'), size: 30),
  '오각형' : ImageIcon(AssetImage('assets/shapes/pentagon.png'), size: 30),
  '장방형' : ImageIcon(AssetImage('assets/shapes/rectangle.png'), size: 30),
  '마름모형' : ImageIcon(AssetImage('assets/shapes/rhombus.png'), size: 30),
  '삼각형' : ImageIcon(AssetImage('assets/shapes/triangle.png'), size: 30)
};
var shapeInfoSubSlidingSegmentedData = {
  0 : '정제',
  1 : '경질캡슐',
  2 : '연질캡슐'
};