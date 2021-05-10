

import 'exceptions/content_selector_exception.dart';
import 'table_structure/header.dart';

class CellContentSelector {
  static String select(Map<String, dynamic> json, Header header) {
    String toReturn;
    List<String> keys = json.keys.toList();
    keys.forEach((k) {
      if (k == header.text) toReturn = json[k].toString();
    });

    if (toReturn == null)
      throw ContentSelectorException(
          message: 'Cannot find' + header.text + ' property');

    return toReturn;
  }
}
