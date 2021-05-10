import 'package:flutter/material.dart';

import '../../query_parameters/query_parameters.dart';

class QueryParametersFormat {
  final QueryParameters _queryParameters;

  const QueryParametersFormat({
    @required QueryParameters queryParameters,
  }) : _queryParameters = queryParameters;

  Map<String, String> getRequestDataHeaders() {
    Map<String, String> headers = Map();
    if (_queryParameters == null) return headers;
    _queryParameters.parameters.forEach((key, value) {
      headers.putIfAbsent(key, () => value);
    });

    return headers;
  }
}
