///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.dates.generator;

import 'package:intl/intl.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

import 'constants.dart';

/// utilidades para datas
abstract class DatesGenerator {
  /// retorna uma lista com os meses da metade do ano
  static List<String> generateHalfYearList(int year, int half) =>
      DatesConstants.MONTHS
          .sublist(half == 1 ? 0 : 6, half == 1 ? 6 : 12)
          .map((month) => '$year/$month')
          .toList();

  /// gera uma lista com os dias inicias da semana com base
  /// no mes do dia passado como parametro
  static List<String> generateWeekInitDaysList(DateTime dt) {
    final month = dt.month;
    final year = dt.year;

    final lastMonthDay = DateTime(year, month + 1, 0).day;

    final days = <String>[];

    List<int>.generate(lastMonthDay, (i) => i + 1).forEach((int day) {
      final datetime = DateTime(year, month, day);
      if (datetime.weekday == DateTime.sunday) {
        days.add('${datetime.day}/$month');
      }
    });

    return days;
  }

  ///
  static List<DateTime> parseDateInterval(String query) {
    final dateformat = DateFormat('dd/MM/yyyy HH:mm');
    var result = <DateTime>[];

    final regex1 = VerbalExpression()
      ..add('\\d+') // dia
      ..then('/')
      ..add('\\d+') // mes
      ..then('/')
      ..add('\\d+') // ano
      ..space()
      ..add('\\d+') // dia
      ..then('/')
      ..add('\\d+') // mes
      ..then('/')
      ..add('\\d+'); // ano

    final regex2 = VerbalExpression()
      ..add('\\d+') // dia
      ..then('/')
      ..add('\\d+') // mes
      ..space()
      ..add('\\d+') // dia
      ..then('/')
      ..add('\\d+'); // mes

    if (regex1.hasMatch(query) || regex2.hasMatch(query)) {
      try {
        result = [
          dateformat.parse(processDate(query.split(' ')[0]) + ' 00:00'),
          dateformat.parse(processDate(query.split(' ')[1]) + ' 23:59')
        ];
      } catch (_, __) {
        result = [];
      }
    }

    return result;
  }

  ///
  static String processDate(String source) {
    final ds = source.split('/');

    final day = int.parse(ds[0]);
    final month = int.parse(ds[1]);
    final year = ds.length > 2
        ? (ds[2].length >= 4 ? int.parse(ds[2]) : int.parse('20${ds[2]}'))
        : DateTime.now().year;

    final sDay = day >= 10 ? day.toString() : '0$day';
    final sMonth = month >= 10 ? month.toString() : '0$month';

    return '$sDay/$sMonth/$year';
  }
}
