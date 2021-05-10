import 'dart:async';

import 'package:flutter/material.dart';

import 'fetch_strategy.dart';
import '../../data/communication/request_data.dart';
import '../../data/communication/response_data.dart';
import '../../data/sources/data_source.dart';

class LocalFetch<T> implements FetchStrategy<T> {
  final List<T> _elements;

  LocalFetch({
    @required DataSource dataSource,
    @required RequestData requestData,
  }) : _elements = dataSource.data;

  @override
  Future<ResponseData<T>> fetch(RequestData requestData) {
    final Completer completer = Completer<ResponseData<T>>();
    completer.complete(
      ResponseData(
        elementsList: _elements,
      ),
    );
    return completer.future;
  }
}
