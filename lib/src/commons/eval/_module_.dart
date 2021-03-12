///
/// @author sergio lisan
///
/// venosyd © 2016-2021
///
library opensyd.dart.commons.commons.dart.eval;

import 'cnp.dart';
import 'date.dart';
import 'number.dart';
import 'security.dart';
import 'specialchar.dart';
import 'text.dart';

export '_deprecated_.dart';
export 'cnp.dart';
export 'date.dart';
export 'number.dart';
export 'security.dart';
export 'specialchar.dart';
export 'text.dart';

///
/// interface fachada para as validacoes
///
abstract class Validate {
  ///
  static bool validateText(String text) => ValidateText.validateText(text);

  ///
  static bool validateTextWithLimit(String text, int limit) =>
      ValidateText.validateTextWithLimit(text, limit);

  ///
  static bool validateName(String name) => ValidateText.validateName(name);

  ///
  static bool validateNameWithSpace(String name) =>
      ValidateText.validateNameWithSpace(name);

  ///
  static bool validateEmail(String email) => ValidateText.validateEmail(email);

  ///
  static bool validateURL(String url) => ValidateText.validateURL(url);

  ///
  static bool isValidCNP(String cnp) => ValidateCNP.isValidCNP(cnp);

  ///
  static bool isValidCPF(String cpf) => ValidateCNP.isValidCPF(cpf);

  ///
  static bool isValidCNPJ(String cnpj) => ValidateCNP.isValidCNPJ(cnpj);

  static bool isValidCarplate(String carplate) =>
      ValidateSpecialChar.isValidCarplate(carplate);

  ///
  static bool isFutureDate(String date) => ValidateDate.isFutureDate(date);

  ///
  static bool isOnlyDigits(String value) => ValidateNumber.isOnlyDigits(value);

  ///
  static bool isInRange(String toValidate,
          [int digits = 4, int init = 0, int end = 1000]) =>
      ValidateNumber.isInRange(toValidate, digits, init, end);

  ///
  static bool isCEP(String value) => ValidateNumber.isCEP(value);

  ///
  static bool validatePasswd(String passwd) =>
      ValidateSecurity.validatePasswd(passwd);

  ///
  static bool isAddress(String address) =>
      ValidateSpecialChar.isAddress(address);

  ///
  static bool validatePhone(String phone, [int limit = 16]) =>
      ValidateSpecialChar.validatePhone(phone, limit);
}
