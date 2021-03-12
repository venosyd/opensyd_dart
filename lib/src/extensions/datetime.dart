///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.extensions.datetime;

import '../commons/date/_module_.dart';

///
/// Extensoes em datetime
///
extension SyDate on DateTime {
  ///
  DateTime get simple => DateTime(year, month, day);

  ///
  String get readabledate => Dates.fromIntToReadable(millisecondsSinceEpoch);

  ///
  String get readabletime =>
      Dates.fromIntToReadableSimpleTime(millisecondsSinceEpoch);

  ///
  String get readabledatetime =>
      Dates.fromIntToReadableDateTime(millisecondsSinceEpoch);

  ///
  String get html => Dates.toHTMLFormatted(millisecondsSinceEpoch);
}
