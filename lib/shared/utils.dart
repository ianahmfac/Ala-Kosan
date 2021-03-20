import 'package:intl/intl.dart';

String convertCurrency(int price) {
  return NumberFormat.currency(
    locale: "id-ID",
    decimalDigits: 0,
    symbol: "Rp ",
  ).format(price);
}
