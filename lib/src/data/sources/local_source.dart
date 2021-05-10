import 'package:flutter/material.dart';

import 'data_source.dart';

import '../../fetch/strategy/local_fetch.dart';
import '../../fetch/fetch_processor.dart';
import '../../data/data_source_processor.dart';

class LocalSource<T> implements DataSource<T>, FetchProcessor<T> {
  List<T> _list;

  LocalSource({
    @required List<T> list,
  }) : _list = list;

  @override
  List<T> get data {
    return _list;
  }

  @override
  LocalFetch<T> processDataSource(DataProcessor<T> dataSourceProcessor) {
    return dataSourceProcessor.processLocalSource(this);
  }
}
