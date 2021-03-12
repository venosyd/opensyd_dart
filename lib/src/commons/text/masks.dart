///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.text.masks;

import 'package:intl/intl.dart';

import '../../extensions/_module_.dart';

///
/// utlidades para campos de formularios
///
abstract class Masks {
  ///
  ///
  ///
  static final NumberFormat _currency = NumberFormat.currency(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: r'R$',
  );

  ///
  /// mascara para porcentagem
  ///
  static String urlemailmask(String value) {
    if (value.isEmpty || value == ' ') {
      return '';
    }

    return value.replaceAll(' ', '').toLowerCase();
  }

  ///
  /// mascara para porcentagem
  ///
  static String percentmask(String value) {
    if (value.isEmpty || value == ' ') {
      return '';
    }

    if (value.length > 1 && value.endsWith(' ') && !value.contains('%')) {
      return '${numbermask(value.substring(0, value.length - 2))} %';
    } else {
      return '${numbermask(value)} %';
    }
  }

  ///
  /// mascara para porcentagem com numeros inteiros
  ///
  static String intpercentmask(String value) {
    if (value.isEmpty || value == ' ') {
      return '';
    }

    final onlydigits = value.onlydigits;

    if (onlydigits.length > 1 &&
        value.endsWith(' ') &&
        !onlydigits.contains('%')) {
      return '${numbermask(onlydigits.substring(0, onlydigits.length - 2))} %';
    } else {
      return '${numbermask(onlydigits)} %';
    }
  }

  ///
  ///
  ///
  static String editpercentmask(String value) =>
      percentmask(editnumbermask(value));

  ///
  /// mascara para numeros
  ///
  static String numbermask(String value) =>
      value.replaceAll(RegExp(r'[^0-9,.-]'), '');

  ///
  /// mascara para numeros
  ///
  static String editnumbermask(String value) =>
      moneymask(value).replaceAll(r'R$', '').trim();

  ///
  /// mascara para cep
  ///
  static String cepmask(String value) {
    final digits = value.onlydigits;

    if (value.length > (digits.startsWith('0') ? 10 : 9)) {
      return value.substring(0, 9);
    }

    // cep paulista
    if (digits.length == 7)
      return '0${digits.substring(digits[0] == '0' ? 1 : 0, 4)}-${digits.substring(4)}';

    // cep do resto do brasil
    else if (digits.length == 8)
      return '${digits.substring(0, 5)}-${digits.substring(5)}';
    else if (digits.length == 9)
      return '${digits.substring(1, 6)}-${digits.substring(6)}';

    return value;
  }

  ///
  /// mascara para dinheiro
  ///
  static String moneymask(String value) {
    if (value.isEmpty || value == ' ') {
      return '';
    }

    final negative = value.contains('-') ? '-' : '';
    var digits = value.onlydigits;

    if (digits.length == 1)
      digits = '${negative}0.0$digits';
    else if (digits.length == 2)
      digits = '${negative}0.$digits';
    else if (digits.length >= 3)
      digits = '$negative${digits.substring(0, digits.length - 2)}.'
          '${digits.substring(digits.length - 2)}';

    return digits.isNotEmpty
        ? _currency
            .format(double.parse(digits.replaceAll(',', '.')))
            .replaceAll('-R\$', 'R\$ -')
        : '';
  }

  ///
  /// mascara para telefone
  ///
  static String phonemask(String value) {
    value ??= '';

    if (value.length > 15) {
      return value.substring(0, 15);
    }

    final onlydigits = value.onlydigits;

    // ddd
    if (onlydigits.length == 3)
      return '(${onlydigits.substring(0, 2)}) ${onlydigits.substring(2)}';

    // mascara completa
    else if (onlydigits.length == 7)
      return '(${onlydigits.substring(0, 2)}) '
          '${onlydigits.substring(2, 6)}-'
          '${onlydigits.substring(6)}';

    // mascara completa digit 9 no inicio
    else if (onlydigits.length == 11)
      return '(${onlydigits.substring(0, 2)}) '
          '${onlydigits.substring(2, 7)}-'
          '${onlydigits.substring(7)}';
    else
      return value;
  }

  ///
  /// mascara de cnpj
  ///
  static String cnpjmask(String value) {
    value ??= '';

    if (value.length > 18) {
      return value.substring(0, 18);
    }

    final digits = value.onlydigits;

    if (digits.length == 3)
      return '${digits.substring(0, 2)}.${digits.substring(2)}';

    //
    else if (digits.length == 6)
      return '${digits.substring(0, 2)}.'
          '${digits.substring(2, 5)}.'
          '${digits.substring(5)}';

    //
    else if (digits.length >= 13)
      return '${digits.substring(0, 2)}.'
          '${digits.substring(2, 5)}.'
          '${digits.substring(5, 8)}/'
          '${digits.substring(8, 12)}-'
          '${digits.substring(12)}';

    return value;
  }

  ///
  /// mascara de cnpj
  ///
  static String cpfmask(String value) {
    value ??= '';

    final digits = value.onlydigits;

    if (digits.length == 4)
      return '${digits.substring(0, 3)}.${digits.substring(3)}';

    //
    else if (digits.length == 7)
      return '${digits.substring(0, 3)}.'
          '${digits.substring(3, 6)}.'
          '${digits.substring(6)}';

    //
    else if (digits.length >= 10)
      return '${digits.substring(0, 3)}.'
          '${digits.substring(3, 6)}.'
          '${digits.substring(6, 9)}-'
          '${digits.substring(9)}';

    return value;
  }
}
