///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.date.parser;

import 'package:intl/intl.dart';

import 'constants.dart';

/// utilidades para datas
abstract class DatesParser {
  /// from datetime to string
  static String fromDateTime(DateTime date) =>
      DateFormat(DatesConstants.DATE_PATTERN).format(date);

  /// from int to string
  static String fromInt(int source) => DateFormat(DatesConstants.DATE_PATTERN)
      .format(DateTime.fromMillisecondsSinceEpoch(source));

  /// from string to datetime
  static DateTime fromString(String date) =>
      DateFormat(DatesConstants.DATE_PATTERN).parse(date);

  /// from string to datetime
  static DateTime fromReadableString(String date) =>
      DateFormat(DatesConstants.READABLE_DATE_PATTERN).parse(date);

  /// from string to datetime
  static DateTime fromReadableDateTimeString(String date) =>
      DateFormat(DatesConstants.READABLE_DATETIME_PATTERN).parse(date);

  /// from source to readable text
  static String toReadableText(String source) =>
      DateFormat(DatesConstants.READABLE_DATE_PATTERN)
          .format(DateFormat(DatesConstants.DATE_PATTERN).parse(source));

  /// from source to readable text
  static String fromDateTimeToReadable(DateTime source) =>
      DateFormat(DatesConstants.READABLE_DATE_PATTERN).format(source);

  /// from source to readable text
  static String fromIntToReadable(int source) =>
      DateFormat(DatesConstants.READABLE_DATE_PATTERN)
          .format(DateTime.fromMillisecondsSinceEpoch(source));

  /// from source to html input text field format
  static String toHTMLFormatted(int source) =>
      DateTime.fromMillisecondsSinceEpoch(source)
          .toIso8601String()
          .substring(0, 10);

  /// from source to readable text
  static String fromIntToReadableTime(int source) =>
      DateFormat(DatesConstants.READABLE_TIME_PATTERN)
          .format(DateTime.fromMillisecondsSinceEpoch(source));

  /// from source to readable text
  static String fromIntToReadableSimpleTime(int source) =>
      DateFormat(DatesConstants.READABLE_TIME_SIMPLE_PATTERN)
          .format(DateTime.fromMillisecondsSinceEpoch(source));

  /// from source to readable text
  static String fromIntToReadableDateTime(int source) =>
      DateFormat(DatesConstants.READABLE_DATETIME_PATTERN)
          .format(DateTime.fromMillisecondsSinceEpoch(source));
}
