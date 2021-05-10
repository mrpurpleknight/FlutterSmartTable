import 'package:flutter/material.dart';

import './search_strategy.dart';

class SimpleSearchStrategy<T> implements SearchStrategy<T> {

  Function(String, List<T>) _searchFunction;

  SimpleSearchStrategy({
    @required Function(String, List<T>) searchFunction,
  }) : _searchFunction = searchFunction;

  @override
  Function(String p1, List<T> p2) getSearchFunction() {
    return _searchFunction;
  }

}
