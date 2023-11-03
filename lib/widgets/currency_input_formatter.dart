import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

class CurrencyInputFormatter extends TextInputFormatter {
  late double totalPricevalue;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);
    totalPricevalue = value;
    final formatter = new intl.NumberFormat.decimalPattern();

    String newText = formatter.format(value / 1);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
