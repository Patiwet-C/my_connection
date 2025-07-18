import 'package:intl/intl.dart';

extension DoubleExtension on double? {
  String toStringCurrency({int decimalDigits = 2, bool? hideDecimal = false}) {
    final value = NumberFormat.currency(decimalDigits: decimalDigits, symbol: '').format(this ?? 0);

    /// Hide decimal work when the decimal value is .00
    if (hideDecimal == true && value.contains('.00')) {
      return value.replaceAll('.00', '');
    }
    return value;
  }
}
