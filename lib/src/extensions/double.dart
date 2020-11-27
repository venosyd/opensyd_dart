///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.extensions.double;

import 'package:intl/intl.dart';

import '../commons/text/_module_.dart';

///
/// Extensoes em double
///
extension SyDouble on double {
  ///
  String get ptformatted => NumberFormat.currency(
        locale: 'pt_BR',
        decimalDigits: 2,
        symbol: '',
      ).format(this).replaceAll(' ', '');

  ///
  String get currency => Masks.moneymask(toStringAsFixed(2));

  ///
  String get percent => Masks.percentmask(toStringAsFixed(2));

  ///
  List<double> range() => List<double>.generate(floor(), (i) => i.toDouble());

  ///
  List<double> rangeWith() =>
      List<double>.generate(floor() + 1, (i) => i.toDouble());

  ///
  List<double> rangeFromTo(int limit) =>
      List<double>.generate(limit, (i) => i + this);

  ///
  List<double> rangeFromToWith(int limit) =>
      List<double>.generate(limit + 1, (i) => i + this);
}
