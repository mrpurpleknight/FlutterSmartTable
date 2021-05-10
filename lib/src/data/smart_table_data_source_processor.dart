import 'package:flutter/material.dart';

import 'communication/request_data.dart';
import 'data_source_processor.dart';
import 'sources/http_source.dart';
import 'sources/local_source.dart';

import '../fetch/strategy/local_fetch.dart';
import '../fetch/strategy/http_fetch.dart';

class SmartTableDataProcessor<T> implements DataProcessor<T> {
  final RequestData _requestData;

  const SmartTableDataProcessor(
      {@required RequestData requestData,})
      : _requestData = requestData;

  @override
  LocalFetch<T> processLocalSource(LocalSource<T> localSource) {
    return LocalFetch<T>(
        dataSource: localSource,);
  }

  @override
  HttpFetch<T> processHttpSource(HttpSource<T> httpSource) {
    return HttpFetch<T>(
        dataSource: httpSource,
        requestData: _requestData);
  }
}
