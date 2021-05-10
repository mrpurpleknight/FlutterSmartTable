import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/communication/response_data.dart';

class ResponseFormat<T> {
  Function(Map<String, dynamic>) _fromJson;
  String _responseListKey;

  ResponseFormat({
    @required Function(Map<String, dynamic>) fromJson,
    String responseKeyList,
  })  : _fromJson = fromJson,
        _responseListKey = responseKeyList;

  ResponseData<T> getResponseData(String toDecode) {
    List<T> elementsList = [];

    if (_responseListKey == null) {
      List<dynamic> jsonElementsList = jsonDecode(toDecode);
      jsonElementsList.forEach((element) {
        elementsList.add(
          _fromJson(element),
        );
      });
    } else {
      Map<String, dynamic> jsonElementMap = jsonDecode(toDecode);
      jsonElementMap[_responseListKey].forEach(
        (element) {
          elementsList.add(
            _fromJson(element),
          );
        },
      );
    }

    return ResponseData(elementsList: elementsList);
  }
}
