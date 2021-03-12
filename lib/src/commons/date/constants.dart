///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.date.constants;

///
///
///
abstract class DatesConstants {
  /// DATE PATTERN
  static const String DATE_PATTERN = 'yyyy-MM-dd HH:mm:ss.SSSSSS';

  ///
  static const String READABLE_DATE_PATTERN = 'dd/MM/yyyy';

  ///
  static const String READABLE_TIME_PATTERN = 'HH:mm:ss';

  ///
  static const String READABLE_TIME_SIMPLE_PATTERN = 'HH:mm';

  ///
  static const String READABLE_DATETIME_PATTERN = 'dd/MM/yyyy HH:mm:ss';

  ///
  static const List<String> MONTHS = [
    ...['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN'],
    ...['JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'],
  ];

  ///
  static const List<String> MESES = [
    ...['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho'],
    ...['Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
  ];
}
