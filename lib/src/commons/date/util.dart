///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.date.util;

import 'parser.dart';

/// utilidades para datas
abstract class DatesUtil {
  /// gets the year-month-day of the patterned date string
  static DateTime extractDay(String date) => DateTime(
      int.parse(date.substring(0, 4)),
      int.parse(date.substring(5, 7)),
      int.parse(date.substring(8, 10)));

  /// converte dia, mes e ano para o Pernilonge DATE PATTERN
  static String fromDayMonthYear(int day, int month, int year,
          [int hour = 0,
          int minute = 0,
          int secs = 0,
          int mili = 0,
          int nano = 0]) =>
      DatesParser.fromDateTime(
          DateTime(year, month, day, hour, secs, mili, nano));

  static int totalDeDias(int ano, int mes) => getMeses(ano)[mes][1] as int;

  static Map<int, List<dynamic>> getMeses(int year) => {
        1: <dynamic>['Janeiro', 31],
        2: <dynamic>['Fevereiro', if (isBissexto(year)) 29 else 28],
        3: <dynamic>['Março', 31],
        4: <dynamic>['Abril', 30],
        5: <dynamic>['Maio', 31],
        6: <dynamic>['Junho', 30],
        7: <dynamic>['Julho', 31],
        8: <dynamic>['Agosto', 31],
        9: <dynamic>['Setembro', 30],
        10: <dynamic>['Outubro', 31],
        11: <dynamic>['Novembro', 30],
        12: <dynamic>['Dezembro', 31]
      };

// verifica se o ano eh bissexto
  static bool isBissexto(int year) =>
      (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0));

  ///
  static int getAno(int date) => DateTime.fromMillisecondsSinceEpoch(date).year;

  ///
  static int getMes(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date).month;

  ///
  static int getDia(int date) => DateTime.fromMillisecondsSinceEpoch(date).day;

  ///
  static int getHora(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date).hour;

  ///
  static int getMinuto(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date).minute;

  ///
  static int getInitialMonthGap(int date) =>
      DateTime(getAno(date), getMes(date), 1).weekday;

  /// retorna a quantidade de semestres de uma data inicial ate hoje
  static List<String> getPeriods(int initialYear) => List<String>.generate(
          1 + DateTime.now().year - initialYear,
          (index) => (initialYear + index).toString())
      .map((year) => ['$year.1', '$year.2'])
      .expand((period) => period)
      .toList();

  // retorna o periodo corrente
  static int getCurrentPeriod(int initialYear) => getPeriods(initialYear)
      .indexOf('${DateTime.now().year}.${DateTime.now().month <= 6 ? 1 : 2}');

  ///
  static List<DateTime> findInInterval(
    List<DateTime> source,
    List<DateTime> interval,
  ) =>
      List<DateTime>.from(<DateTime>[interval[0]])
        ..addAll(source.where(
            (day) => day.isAfter(interval[0]) && day.isBefore(interval[1])))
        ..add(interval[1]);
}
