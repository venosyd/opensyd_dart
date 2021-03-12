///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.eval.date;

import 'package:intl/intl.dart';

///
///
///
abstract class ValidateDate {
  /// valida se o dia passado eh no futuro ou nao
  static bool isFutureDate(String date) {
    if (date.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final datetime = DateFormat('dd/MM/yyyy HH:mm').parse(date);
    return datetime.compareTo(DateTime.now()) > 0;
  }
}
