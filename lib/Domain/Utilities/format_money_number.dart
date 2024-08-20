import 'package:intl/intl.dart';

class FormatMoneyNumber{

  String formatCurrencyInMXN(double amount) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'es_MX',
    symbol: ''
  );
  return '${currencyFormatter.format(amount)} MXN';
}

}