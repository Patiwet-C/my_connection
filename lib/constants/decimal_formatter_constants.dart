class DecimalFormatterConstant {
  DecimalFormatterConstant._();

  static const String currencyWithTwoDecimalPattern = "#,##0.##";
  static const String numberWithTwoDecimalPattern = "###.0#";
  static final RegExp onlyNumberRegex = RegExp('[^0-9]');
  static final RegExp numberWithDecimalRegex = RegExp('[^0-9.]');
}
