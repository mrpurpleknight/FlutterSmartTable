import 'package:flutter/material.dart';

import 'header.dart';
import '../string_extension.dart';
import '../data/communication/request_data.dart';
import '../data/communication/response_data.dart';

class Headers<T> {
  final List<Header> _list;

  const Headers({
    @required List<Header> list,
  }) : _list = list;

  List<Header> get list => _list;

  List<DataColumn> getDataColumns(
      RequestData requestData, ResponseData<T> responseData) {
    List<DataColumn> dataColumns = [];

    _list.forEach((e) {
      dataColumns.add(
        DataColumn(
          label: Text(
            e.text.capitalize(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onSort: (e.sortFunction != null)
              ? (columnIndex, ascending) {
                  requestData.sortAscending = ascending;
                  requestData.sortColumnIndex = columnIndex;
                  e.sortFunction(responseData.elementsList, ascending);
                }
              : (_, __) {},
        ),
      );
    });

    return dataColumns;
  }
}
