///
/// @author sergio lisan
///
/// venosyd © 2016-2020
///
library opensyd.dart.commons.eval.security;

import 'package:crypto/crypto.dart';

///
/// Utlidades para validacao de senhas
///
abstract class ValidateSecurity {
  /// validate if something contains only text
  static bool validatePasswd(String passwd) =>
      passwd != null && passwd.isNotEmpty && passwd.length >= 8;
}

///
String shuffle(String data) {
  data = '${sha256.convert(data.codeUnits)}';
  data =
      '${data.substring(1, 24)}${data.substring(0, 1)}${data.substring(25, 27)}';
  return data.toUpperCase();
}
