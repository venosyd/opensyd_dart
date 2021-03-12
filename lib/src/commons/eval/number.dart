///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.eval.number;

import 'package:verbal_expressions/verbal_expressions.dart';

///
/// Utilidades para validacao de valores numericos
///
abstract class ValidateNumber {
  /// valida se o valor passado possui apenas digitos
  static bool isOnlyDigits(String value) {
    if (value.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final regex = VerbalExpression()
      ..add(r'[a-zA-Z!@#$%"&,.*=_+\[\]{}<>|\\/\^]+');

    return !regex.hasMatch(value);
  }

  /// valida se um campo tem so digitos e se esta dentro de um range especificado
  /// (o padrao sao 4 digitos de 0 a 999)
  static bool isInRange(String toValidate,
      [int digits = 4, int init = 0, int end = 1000]) {
    if (toValidate.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final valid = isOnlyDigits(toValidate);

    if (valid) {
      toValidate = toValidate.length >= digits
          ? toValidate.substring(0, digits)
          : toValidate;
      final intValue = int.parse(toValidate);
      return intValue > init && intValue <= end;
    }

    return false;
  }

  /// valida um CEP, mas apenas o formato
  /// a existencia dele deve ser checkada com
  /// o servico Address da Venosyd
  static bool isCEP(String value) {
    if (value.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final onlyDigit = value.replaceAll('-', '');
    return isOnlyDigits(onlyDigit) && (value.length == 8 || value.length == 9);
  }
}
