import 'package:flutter/material.dart';

import 'header.dart';
import 'headers.dart';

class Rows<T> {
  final Headers _headers;
  final List<T> _list;
  final Function(T, Header header) _getCellContent;

  const Rows({
    @required Headers headers,
    @required List<T> list,
    @required Function(T, Header header) getCellContent,
  })  : _headers = headers,
        _list = list,
        _getCellContent = getCellContent;

  List<DataRow> getDataRows() {
    List<DataRow> rows = [];

    _list.forEach((e) {
      rows.add(DataRow(
        cells: _getDataCellList(e),
      ));
    });

    return rows;
  }

  List<DataCell> _getDataCellList(T t) {
    List<DataCell> dataCellsList = [];
    _headers.list.forEach((header) {
      dataCellsList.add(
        DataCell(
          _getCellContent(t, header),
        ),
      );
    });

    return dataCellsList;
  }
}
