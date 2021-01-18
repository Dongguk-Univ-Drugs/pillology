import 'package:flutter/material.dart';

class PhotoSearchImageStore with ChangeNotifier{
  List<String> storage = ['none','none'];

  void store(String path, int index) {
    storage[index] = path;
    notifyListeners();
  }
  void remove(bool isFront) {
    var index = isFront ? 0 : 1;
    storage[index] = '';
    notifyListeners();
  } 

}