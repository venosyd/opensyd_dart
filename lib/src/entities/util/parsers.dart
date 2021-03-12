///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.util.parsers;

///
/// classe com utilidades para conversao de dados com
/// seguranca sobre nulificacao e tipos diferentes
///
abstract class Parsers {
  /// faz a conversao para o tipo correto do element
  static int parseInt(dynamic element) => (element == null)
      ? null
      : (element is double
          ? element.truncate()
          : (element is String ? int.parse(element) : element as int));

  /// faz a conversao para o tipo correto do element
  static double parseDouble(dynamic element) => (element == null)
      ? null
      : (element is int
          ? element.toDouble()
          : (element is String ? double.parse(element) : element as double));

  /// faz a conversao segura para booleano
  static bool parseBool(dynamic element) =>
      element != null && (element == 'true' || element as bool);

  /// faz a conversao de uma int para uma lista de objetos
  static List<T> parseList<T>(dynamic list) =>
      (list as List)?.toList()?.cast<T>() ?? [];

  /// faz a conversao de uma string para uma lista de objetos
  static Map<K, T> parseMap<K, T>(dynamic map) =>
      (map?.cast<K, T>() ?? <K, T>{}) as Map<K, T>;
}
