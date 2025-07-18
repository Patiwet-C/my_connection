import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_connection/constants/decimal_formatter_constants.dart';

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;
  final int maximumDigit;

  DecimalFormatter({this.decimalDigits = 2, this.maximumDigit = 9})
    : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(
        DecimalFormatterConstant.onlyNumberRegex,
        '',
      );
    } else {
      newText = newValue.text.replaceAll(
        DecimalFormatterConstant.numberWithDecimalRegex,
        '',
      );
    }

    if (newText.split('.')[0].length > maximumDigit) {
      return oldValue;
    } else if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: const TextSelection.collapsed(offset: 2),
        );
        //in case if user tries to input multiple "."s or tries to input more than the decimal place
      } else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > decimalDigits)) {
        return oldValue;
      } else {
        return newValue;
      }
    }

    // in case if input is empty or zero
    if (newText.trim() == '') {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    final double newDouble = double.parse(newText);
    final selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    final String newString = NumberFormat(
      DecimalFormatterConstant.currencyWithTwoDecimalPattern,
    ).format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
