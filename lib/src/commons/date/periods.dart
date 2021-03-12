///
/// @author sergio lisan
///
/// venosyd © 2016-2021
///
library opensyd.dart.commons.graph.periods;

import '../../extensions/_module_.dart';

///
///
///
class Period {
  ///
  const Period(this.start, this.end);

  ///
  final int start;

  ///
  final int end;

  @override
  String toString() =>
      '${start.datetime.readabledate} - ${end.datetime.readabledate}';
}

///
///
///
class Periods {
  ///
  factory Periods() {
    return _singleton;
  }

  ///
  Periods._internal();

  ///
  static final Periods _singleton = Periods._internal();

  ///
  static const ENDS_IN_31 = [1, 3, 5, 7, 8, 10, 12];

  ///
  static const ENDS_IN_30 = [4, 6, 9, 11];

  /// retorna o dicionario de Periods de acordo com o intervalo
  /// solicitado pelo usuario
  Map<Period, dynamic> build(
    int year_, {
    int month,
    bool yearly = false,
    bool half = false,
    bool quarter = false,
    bool weekly = false,
    bool monthly = false,
  }) {
    if (yearly)
      return year(year_);
    //
    else if (half)
      return halfs(year_);
    //
    else if (quarter)
      return quarters(year_);
    //
    else if (monthly)
      return months(year_);
    //
    else if (weekly)
      return weeks(year_, month);
    //
    else
      return days(year_, month);
  }

  ///
  Map<Period, dynamic> year(int year) => <Period, dynamic>{
        Period(jan(year), dec(year, end: true)): .0,
      };

  ///
  Map<Period, dynamic> halfs(int year) => <Period, dynamic>{
        h1(year): .0,
        h2(year): .0,
      };

  ///
  Map<Period, dynamic> quarters(int year) => <Period, dynamic>{
        q1(year): .0,
        q2(year): .0,
        q3(year): .0,
        q4(year): .0,
      };

  ///
  Map<Period, dynamic> months(int year) => <Period, dynamic>{
        january(year): .0,
        february(year): .0,
        march(year): .0,
        april(year): .0,
        may(year): .0,
        june(year): .0,
        july(year): .0,
        august(year): .0,
        september(year): .0,
        october(year): .0,
        november(year): .0,
        december(year): .0,
      };

  ///
  Map<Period, dynamic> weeks(int year, int month) => <Period, dynamic>{
        week1(year, month): .0,
        week2(year, month): .0,
        week3(year, month): .0,
        week4(year, month): .0,
        if (month != 2) week5(year, month): .0,
      };

  ///
  Map<Period, dynamic> days(int year, int month) => <Period, dynamic>{
        for (final day in 1.rangeFromTo(lastmonthday(year, month)))
          Period(daystart(year, month, day), dayend(year, month, day)): .0
      };

  ///
  Period h1(int year) => Period(jan(year), jun(year, end: true));

  ///
  Period h2(int year) => Period(jul(year), dec(year, end: true));

  ///
  Period q1(int year) => Period(jan(year), mar(year, end: true));

  ///
  Period q2(int year) => Period(apr(year), jun(year, end: true));

  ///
  Period q3(int year) => Period(jul(year), sep(year, end: true));

  ///
  Period q4(int year) => Period(oct(year), dec(year, end: true));

  ///
  Period week1(int year, int month) =>
      Period(w1(year, month), w1(year, month, end: true));

  ///
  Period week2(int year, int month) =>
      Period(w2(year, month), w2(year, month, end: true));

  ///
  Period week3(int year, int month) =>
      Period(w3(year, month), w3(year, month, end: true));

  ///
  Period week4(int year, int month) =>
      Period(w4(year, month), w4(year, month, end: true));

  ///
  Period week5(int year, int month) =>
      Period(w5(year, month), w5(year, month, end: true));

  ///
  Period january(int year) => Period(jan(year), jan(year, end: true));

  ///
  Period february(int year) => Period(feb(year), feb(year, end: true));

  ///
  Period march(int year) => Period(mar(year), mar(year, end: true));

  ///
  Period april(int year) => Period(apr(year), apr(year, end: true));

  ///
  Period may(int year) => Period(mai(year), mai(year, end: true));

  ///
  Period june(int year) => Period(jun(year), jun(year, end: true));

  ///
  Period july(int year) => Period(jul(year), jul(year, end: true));

  ///
  Period august(int year) => Period(aug(year), aug(year, end: true));

  ///
  Period september(int year) => Period(sep(year), sep(year, end: true));

  ///
  Period october(int year) => Period(oct(year), oct(year, end: true));

  ///
  Period november(int year) => Period(nov(year), nov(year, end: true));

  ///
  Period december(int year) => Period(dec(year), dec(year, end: true));

  ///
  int jan(int year, {bool end = false}) =>
      end ? monthend(year, 1) : monthstart(year, 1);

  ///
  int feb(int year, {bool end = false}) =>
      end ? monthend(year, 2) : monthstart(year, 2);

  ///
  int mar(int year, {bool end = false}) =>
      end ? monthend(year, 3) : monthstart(year, 3);

  ///
  int apr(int year, {bool end = false}) =>
      end ? monthend(year, 4) : monthstart(year, 4);

  ///
  int mai(int year, {bool end = false}) =>
      end ? monthend(year, 5) : monthstart(year, 5);

  ///
  int jun(int year, {bool end = false}) =>
      end ? monthend(year, 6) : monthstart(year, 6);

  ///
  int jul(int year, {bool end = false}) =>
      end ? monthend(year, 7) : monthstart(year, 7);

  ///
  int aug(int year, {bool end = false}) =>
      end ? monthend(year, 8) : monthstart(year, 8);

  ///
  int sep(int year, {bool end = false}) =>
      end ? monthend(year, 9) : monthstart(year, 9);

  ///
  int oct(int year, {bool end = false}) =>
      end ? monthend(year, 10) : monthstart(year, 10);

  ///
  int nov(int year, {bool end = false}) =>
      end ? monthend(year, 11) : monthstart(year, 11);

  ///
  int dec(int year, {bool end = false}) =>
      end ? monthend(year, 12) : monthstart(year, 12);

  ///
  int w1(int year, int month, {bool end = false}) =>
      end ? weekend(year, month, 7) : weekstart(year, month, 1);

  ///
  int w2(int year, int month, {bool end = false}) =>
      end ? weekend(year, month, 14) : weekstart(year, month, 8);

  ///
  int w3(int year, int month, {bool end = false}) =>
      end ? weekend(year, month, 21) : weekstart(year, month, 15);

  ///
  int w4(int year, int month, {bool end = false}) =>
      end ? weekend(year, month, 28) : weekstart(year, month, 22);

  ///
  int w5(int year, int month, {bool end = false}) {
    final endday = ENDS_IN_31.contains(month) ? 31 : 30;
    return end ? weekend(year, month, endday) : weekstart(year, month, 29);
  }

  ///
  int lastmonthday(int year, int month) => month == 2
      ? (leapyear(year) ? 29 : 28)
      : (ENDS_IN_31.contains(month) ? 31 : 30);

  /// comeco do dia em millisegundos
  int daystart(int year, int month, int day) =>
      DateTime(year, month, day).millisecondsSinceEpoch;

  /// final do dia em millisegundos
  int dayend(int year, int month, int day) =>
      DateTime(year, month, day, 23, 59, 59).millisecondsSinceEpoch;

  /// comeco do dia em millisegundos
  int weekstart(int year, int month, int day) =>
      DateTime(year, month, day).millisecondsSinceEpoch;

  /// final do dia em millisegundos
  int weekend(int year, int month, int day) =>
      DateTime(year, month, day, 23, 59, 59).millisecondsSinceEpoch;

  /// comeco do month em millisegundos
  int monthstart(int year, int month) =>
      DateTime(year, month, 1).millisecondsSinceEpoch;

  /// final do month em millisegundos
  int monthend(int year, int month) =>
      DateTime(year, month, lastmonthday(year, month), 23, 59, 59)
          .millisecondsSinceEpoch;

  ///
  bool leapyear(int year) =>
      year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
}
