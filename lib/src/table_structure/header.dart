import 'package:flutter/material.dart';

class Header<T> {
  final String _text;
  Function(List<T>, bool) _sortFunction;

  Header({
    @required String text,
    Function sortFunction,
  })  : _text = text,
        _sortFunction = sortFunction;

  String get text => _text;

  Function get sortFunction => _sortFunction;
}
