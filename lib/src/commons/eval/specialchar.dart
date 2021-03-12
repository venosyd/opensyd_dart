///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.eval.specialchar;

import 'package:verbal_expressions/verbal_expressions.dart';

///
/// Utilidades para validar campos de texto complexos
///
abstract class ValidateSpecialChar {
  /// validate if something contains address
  static bool isAddress(String address) {
    if (address.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final regex = VerbalExpression()..add(r'[!@#$%"&*()=_+\[\]{}<>|\\/\^]+');
    return !regex.hasMatch(address.trim()) && address.trim().isNotEmpty;
  }

  /// apenas digitos
  static bool validatePhone(String phone, [int limit = 16]) {
    if (phone.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final regex = VerbalExpression()
      ..add(r'[a-zA-Z!@#$%"&.*=_\[\]{}<>|\\/\^]+');
    return !regex.hasMatch(phone) && phone.isNotEmpty && phone.length <= limit;
  }

  ///
  static bool isValidCarplate(String carplate) =>
      isValidBRCarplate(carplate) || isValidMercosulCarplate(carplate);

  ///
  static bool isValidBRCarplate(String carplate) {
    if (carplate.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final regex = VerbalExpression()..add(r'[A-Z]{3}-[0-9]{4}');
    return regex.hasMatch(carplate) &&
        carplate.isNotEmpty &&
        carplate.length == 8;
  }

  ///
  static bool isValidMercosulCarplate(String carplate) {
    if (carplate.replaceAll(' ', '').isEmpty) {
      return false;
    }

    final regex = VerbalExpression()..add(r'[A-Z]{3}-[0-9][A-Z][0-9]{2}');
    return regex.hasMatch(carplate) &&
        carplate.isNotEmpty &&
        carplate.length == 8;
  }
}
