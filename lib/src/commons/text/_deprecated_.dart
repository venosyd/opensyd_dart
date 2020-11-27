///
/// @author sergio lisan
///
/// venosyd © 2016-2020
///
library opensyd.dart.commons.text.deprecated;

import '../date/_module_.dart';
import 'masks.dart';

///
/// Recebe uma valor monetario em double e o converte para string
///
@Deprecated('Use as Extensoes para double')
class MoneyFormats {
  ///
  MoneyFormats(this.value);

  ///
  final double value;

  ///
  String get stringfy => value.toStringAsFixed(2);

  ///
  String get formatted => stringfy.replaceAll('.', ',');

  ///
  String get currency => Masks.moneymask(stringfy);
}

///
/// Traz uma data em milissegundos desde o Epoch em varios formatos
///
@Deprecated('Use as Extensoes para int e DateTime')
class DateFormats {
  ///
  DateFormats(int dateinms) : _dateinms = dateinms;

  ///
  final int _dateinms;

  ///
  DateTime get datetime => DateTime.fromMillisecondsSinceEpoch(_dateinms);

  ///
  DateTime get simpledate =>
      DateTime(datetime.year, datetime.month, datetime.day);

  ///
  String get readabledate => Dates.fromIntToReadable(_dateinms);

  ///
  String get readabletime => Dates.fromIntToReadableSimpleTime(_dateinms);

  ///
  String get readabledatetime => Dates.fromIntToReadableDateTime(_dateinms);

  ///
  String get htmldate => Dates.toHTMLFormatted(_dateinms);
}
