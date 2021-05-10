import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../http_client.dart';
import 'fetch_strategy.dart';
import '../../data/communication/request_data.dart';
import '../../data/sources/http_source.dart';
import '../../data/communication/response_data.dart';
import '../../data/communication/http_request_data.dart';

class HttpFetch<T> implements FetchStrategy<T> {
  final HttpSource<T> _httpSource;
  final HttpClient _client;

  HttpFetch({
    @required HttpSource dataSource,
    @required RequestData requestData,
  })  : _httpSource = dataSource,
        _client = HttpClient();

  @override
  Future<ResponseData<T>> fetch(RequestData requestData) async {
    Response response = await _client.getRequest(
      _httpSource.data,
      QueryParametersFormat(queryParameters: _httpSource.queryParameters)
          .getRequestDataHeaders(),
    );
    return _httpSource.responseFormat.getResponseData(response.body);
  }
}
