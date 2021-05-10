import 'package:flutter/material.dart';

class ResponseData<T> with ChangeNotifier{
  List<T> _elementsList;

  ResponseData({
    @required List<T> elementsList,
  })  : _elementsList = elementsList;

  List<T> get elementsList => _elementsList;

  set elementsList(List<T> value) {
    _elementsList = value;
    notifyListeners();
  }
}
