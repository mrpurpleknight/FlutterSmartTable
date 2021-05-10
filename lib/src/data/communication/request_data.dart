import 'package:flutter/cupertino.dart';

class RequestData with ChangeNotifier {
  int _pageElements;
  String _searchString;
  bool _sortAscending;
  int _sortColumnIndex;

  RequestData({
    @required int pageElements,
    String searchString,
    bool sortAscending = true,
    int sortColumnIndex,
  })  : _pageElements = pageElements,
        _searchString = searchString,
        _sortAscending = sortAscending,
        _sortColumnIndex = sortColumnIndex;

  int get pageElements => _pageElements;

  String get searchString => _searchString;

  bool get sortAscending => _sortAscending;

  int get sortColumnIndex => _sortColumnIndex;

  set searchString(String value) {
    _searchString = value;
    notifyListeners();
  }

  set pageElements(int value) {
    _pageElements = value;
    notifyListeners();
  }

  set sortColumnIndex(int value) {
    _sortColumnIndex = value;
    notifyListeners();
  }

  set sortAscending(bool value) {
    _sortAscending = value;
    notifyListeners();
  }
}

enum SortDirection { DESC, ASC }
