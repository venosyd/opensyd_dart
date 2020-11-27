///
/// @author sergio lisan
///
/// venosyd © 2016-2020
///
library opensyd.dart.commons.date;

import 'constants.dart';
import 'generator.dart';
import 'parser.dart';
import 'util.dart';

export '_deprecated_.dart';
export 'constants.dart';
export 'periods.dart';

///
///
///
abstract class Dates implements DatesConstants {
  //
  // PARSER
  //

  ///
  static String fromDateTime(DateTime source) =>
      DatesParser.fromDateTime(source);

  ///
  static String fromInt(int source) => DatesParser.fromInt(source);

  ///
  static DateTime fromString(String source) => DatesParser.fromString(source);

  ///
  static DateTime fromReadableString(String source) =>
      DatesParser.fromReadableString(source);

  ///
  static DateTime fromReadableDateTimeString(String source) =>
      DatesParser.fromReadableDateTimeString(source);

  ///
  static String toReadableText(String source) =>
      DatesParser.toReadableText(source);

  ///
  static String fromDateTimeToReadable(DateTime source) =>
      DatesParser.fromDateTimeToReadable(source);

  ///
  static String fromIntToReadable(int source) =>
      DatesParser.fromIntToReadable(source);

  ///
  static String toHTMLFormatted(int source) =>
      DatesParser.toHTMLFormatted(source);

  ///
  static String fromIntToReadableTime(int source) =>
      DatesParser.fromIntToReadableTime(source);

  ///
  static String fromIntToReadableSimpleTime(int source) =>
      DatesParser.fromIntToReadableSimpleTime(source);

  ///
  static String fromIntToReadableDateTime(int source) =>
      DatesParser.fromIntToReadableDateTime(source);

  //
  // GENERATOR
  //

  ///
  static List<String> generateHalfYearList(int year, int half) =>
      DatesGenerator.generateHalfYearList(year, half);

  ///
  static List<String> generateWeekInitDaysList(DateTime datetime) =>
      DatesGenerator.generateWeekInitDaysList(datetime);

  ///
  static List<DateTime> parseDateInterval(String query) =>
      DatesGenerator.parseDateInterval(query);

  ///
  static String processDate(String source) =>
      DatesGenerator.processDate(source);

  // UTIL

  ///
  static DateTime extractDay(String date) => DatesUtil.extractDay(date);

  ///
  static String fromDayMonthYear(int day, int month, int year,
          [int hour = 0,
          int minute = 0,
          int secs = 0,
          int mili = 0,
          int nano = 0]) =>
      DatesUtil.fromDayMonthYear(
          day, month, year, hour, minute, secs, mili, nano);

  ///
  static int totalDeDias(int ano, int mes) => DatesUtil.totalDeDias(ano, mes);

  ///
  static Map<int, List> getMeses(int year) => DatesUtil.getMeses(year);

  ///
  static bool isBissexto(int year) => DatesUtil.isBissexto(year);

  ///
  static int getAno(int date) => DatesUtil.getAno(date);

  ///
  static int getMes(int date) => DatesUtil.getMes(date);

  ///
  static int getDia(int date) => DatesUtil.getDia(date);

  ///
  static int getHora(int date) => DatesUtil.getHora(date);

  ///
  static int getMinuto(int date) => DatesUtil.getMinuto(date);

  ///
  static int getInitialMonthGap(int date) => DatesUtil.getInitialMonthGap(date);

  ///
  static List<String> getPeriods(int initialYear) =>
      DatesUtil.getPeriods(initialYear);

  ///
  static int getCurrentPeriod(int initialYear) =>
      DatesUtil.getCurrentPeriod(initialYear);

  ///
  static List<DateTime> findInInterval(
    List<DateTime> source,
    List<DateTime> interval,
  ) =>
      DatesUtil.findInInterval(source, interval);
}
