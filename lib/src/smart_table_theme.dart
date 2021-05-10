import 'package:flutter/material.dart';

class SmartTableTheme {
  MaterialStateProperty<Color> _rowColor;
  MaterialStateProperty<Color> _headingColor;
  TextStyle _rowTextStyle;
  TextStyle _headingTextStyle;

  SmartTableTheme({
     MaterialStateProperty<Color> rowColor,
     MaterialStateProperty<Color> headingColor,
     TextStyle rowsTextStyle,
     TextStyle headingTextStyle,
  })  : _rowColor = rowColor,
        _headingColor = headingColor,
        _rowTextStyle = rowsTextStyle,
        _headingTextStyle = headingTextStyle;

  TextStyle get headingTextStyle => _headingTextStyle;

  TextStyle get rowsTextStyle => _rowTextStyle;

  MaterialStateProperty<Color> get headingColor => _headingColor;

  MaterialStateProperty<Color> get rowColor => _rowColor;
}
