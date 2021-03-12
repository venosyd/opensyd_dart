///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.eval.cnp;

import 'package:verbal_expressions/verbal_expressions.dart';

import '../../extensions/_module_.dart';

///
/// utilidades para validacao de CPF/CNPJ
///
abstract class ValidateCNP {
  static const peso_cpf = <int>[11, 10, 9, 8, 7, 6, 5, 4, 3, 2];
  static const peso_cnpj = <int>[6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  /// cpf ou cnpj ?
  static bool isValidCNP(String cnp) => isValidCPF(cnp) || isValidCNPJ(cnp);

  /// validates CPF
  static bool isValidCPF(String cpf) {
    if ((VerbalExpression()..nonDigit()).hasMatch(cpf)) {
      return false;
    }

    cpf = cpf.onlydigits;

    if ((cpf == null) || (cpf.length != 11)) {
      return false;
    }

    if (_samedigit(cpf)) {
      return false;
    }

    final digito1 = _calcularDigito(cpf.substring(0, 9), peso_cpf);
    final digito2 = _calcularDigito('${cpf.substring(0, 9)}$digito1', peso_cpf);

    return cpf == '${cpf.substring(0, 9)}$digito1$digito2';
  }

  /// validates CNPJ
  static bool isValidCNPJ(String cnpj) {
    if ((VerbalExpression()..nonDigit()).hasMatch(cnpj)) {
      return false;
    }

    cnpj = cnpj.onlydigits;

    if ((cnpj == null) || (cnpj.length != 14)) {
      return false;
    }

    if (_samedigit(cnpj)) {
      return false;
    }

    final digito1 = _calcularDigito(cnpj.substring(0, 12), peso_cnpj);
    final digito2 =
        _calcularDigito('${cnpj.substring(0, 12)}$digito1', peso_cnpj);

    return cnpj == '${cnpj.substring(0, 12)}$digito1$digito2';
  }

  /// calcula o digito do CNP passado
  static int _calcularDigito(String str, List<int> peso) {
    int soma = 0;
    for (int indice = str.length - 1, digito; indice >= 0; indice--) {
      digito = int.parse(str.substring(indice, indice + 1));
      soma += digito * peso[peso.length - str.length + indice];
    }
    soma = 11 - soma % 11;
    return soma > 9 ? 0 : soma;
  }

  /// verifica se a string de caracteres eh formada do mesmo digito
  /// que apesar do calculo permitir, a regra de validacao do CPF nao permite
  static bool _samedigit(String value) {
    final digit = value.runes.first;
    for (final char in value.runes.skip(1)) {
      if (char != digit) {
        return false;
      }
    }

    return true;
  }
}
