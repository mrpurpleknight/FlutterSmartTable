import 'package:flutter/material.dart';

import '../../../smart_table.dart';
import '../data_source_processor.dart';
import '../../fetch/fetch_processor.dart';
import '../../response_formats/response_format.dart';
import '../../fetch/strategy/http_fetch.dart';
import 'data_source.dart';

class HttpSource<T> implements DataSource<T>, FetchProcessor<T> {
  final String _url;
  final ResponseFormat<T> _responseFormat;
  final QueryParameters _queryParameters;

  const HttpSource({
    @required String url,
    @required ResponseFormat<T> responseFormat,
    QueryParameters queryParameters,
  })  : _url = url,
        _responseFormat = responseFormat,
        _queryParameters = queryParameters;

  @override
  String get data {
    return _url;
  }

  QueryParameters get queryParameters => _queryParameters;

  ResponseFormat<T> get responseFormat => _responseFormat;

  @override
  HttpFetch<T> processDataSource(DataProcessor<T> dataSourceProcessor) {
    return dataSourceProcessor.processHttpSource(this);
  }
}
