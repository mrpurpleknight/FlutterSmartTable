import 'package:flutter/material.dart';

import '../table_structure/headers.dart';
import '../table_structure/header.dart';

class SmartTableSource<T> extends DataTableSource {
  final List<T> _elementsList;
  final Headers _headers;
  final Function(T, Header) _getCellContent;

  SmartTableSource({
    @required List<T> elementsList,
    @required Headers headers,
    @required Function(T, Header) getCellContent,
  })  : _elementsList = elementsList,
        _headers = headers,
        _getCellContent = getCellContent;

  List<DataCell> getDataCellList(T t) {
    List<DataCell> list = [];

    _headers.list.forEach((element) {
      list.add(
        DataCell(
          (_getCellContent(t, element)),
        ),
      );
    });

    return list;
  }

  @override
  DataRow getRow(int index) {
    final T element = _elementsList.elementAt(index);

    return DataRow.byIndex(index: index, cells: getDataCellList(element));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _elementsList.length;

  @override
  int get selectedRowCount => 0;
}
