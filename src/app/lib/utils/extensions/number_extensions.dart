import 'package:intl/intl.dart';

extension NumberExtensions on int {
  String thousandToK() {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(this);
  }
}
