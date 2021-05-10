

import 'sources/http_source.dart';
import 'sources/local_source.dart';
import '../fetch/strategy/http_fetch.dart';
import '../fetch/strategy/local_fetch.dart';

abstract class DataProcessor<T> {
  HttpFetch<T> processHttpSource(HttpSource<T> httpSource);

  LocalFetch<T> processLocalSource(LocalSource<T> localSource);
}
