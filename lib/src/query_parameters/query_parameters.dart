import 'package:flutter/material.dart';

class QueryParameters {
  Map<String, String> _parameters;

  QueryParameters({
    @required Map<String, String> parameters,
  }) : _parameters = parameters;

  Map<String, String> get parameters => _parameters;
}
