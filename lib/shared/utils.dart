import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertCurrency(int price) {
  return NumberFormat.currency(
    locale: "id-ID",
    decimalDigits: 0,
    symbol: "Rp ",
  ).format(price);
}

void showAlert(BuildContext context, {@required child}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => child,
  );
}
