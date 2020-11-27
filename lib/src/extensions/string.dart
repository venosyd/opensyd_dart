///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.extensions.string;

import 'dart:convert';

import '../commons/eval/_module_.dart';
import '../commons/text/masks.dart';

///
/// Extensoes em strings
///
extension StringSyd on String {
  /// apenas digitos
  String get onlydigits => replaceAll(RegExp('\\D+'), '');

  ///
  double get fromcurrencytodouble => double.parse(
      replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.'));

  ///
  String get first => this[0];

  ///
  String get last => this[length - 1];

  ///
  String insert(int index, String value) {
    final runes = split('');
    runes.insertAll(index, value.split(''));

    return '$runes'.readablelist.replaceAll(', ', '');
  }

  /// grana em pt-br pra grana em ingles
  String get pttousmoney => replaceAll('.', '').replaceAll(',', '.');

  /// transforma a string em um slug URL
  String get urlfyied => replaceAll(RegExp('[^A-Za-z]'), '-').toLowerCase();

  /// transformacao rapida de uma lista em string
  String get readablelist => replaceAll(RegExp('\[\\[\\]\]'), '');

  /// transformacao rapida de uma lista em string
  String get readablelistnewline =>
      replaceAll(RegExp('\[\\[\\]\]'), '').replaceAll(', ', '\n');

  /// reduz o tamanho de uma string
  String get shrink => shrinkTo(30);

  /// reduz o tamanho de uma string
  String shrinkTo(int limit) =>
      length > limit ? '${substring(0, limit - 3)}...' : this;

  /// faz o wrap
  String get wrap =>
      length > 10 && contains(' ') ? replaceFirst(' ', '\n') : this;

  /// verifica se eh cpf ou cnpj e poe pontinhos no cnp
  String get cnpmask => length <= 11 ? cpfmask : cnpjmask;

  /// mascara de cep
  String get cepmask => Masks.cepmask(this);

  /// poe pontinhos no cpf
  String get cpfmask => Masks.cpfmask(this);

  /// poe pontinhos no cnpj
  String get cnpjmask => Masks.cnpjmask(this);

  /// deixa o json bonitinho
  String get prettyjson =>
      const JsonEncoder.withIndent('  ').convert(json.decode(this));

  //
  // VALIDACOES
  //

  //
  bool get istext => ValidateText.validateText(this);
  bool get isnottext => !ValidateText.validateText(this);

  //
  bool get isname => ValidateText.validateNameWithSpace(this);
  bool get isnotname => !ValidateText.validateNameWithSpace(this);

  //
  bool get isemail => ValidateText.validateEmail(this);
  bool get isnotemail => !ValidateText.validateEmail(this);

  //
  bool get isurl => ValidateText.validateURL(this);
  bool get isnoturl => !ValidateText.validateURL(this);

  //
  bool get iscnp => ValidateCNP.isValidCNP(this);
  bool get isnotcnp => !ValidateCNP.isValidCNP(this);

  //
  bool get iscpf => ValidateCNP.isValidCPF(this);
  bool get isnotcpf => !ValidateCNP.isValidCPF(this);

  //
  bool get iscnpj => ValidateCNP.isValidCNPJ(this);
  bool get isnotcnpj => !ValidateCNP.isValidCNPJ(this);

  //
  bool get isonlydigits => ValidateNumber.isOnlyDigits(this);
  bool get isnotonlydigits => !ValidateNumber.isOnlyDigits(this);

  //
  bool get iscep => ValidateNumber.isCEP(this);
  bool get isnotcep => !ValidateNumber.isCEP(this);

  //
  bool get iscarplate => ValidateSpecialChar.isValidCarplate(this);
  bool get isnotcarplate => !ValidateSpecialChar.isValidCarplate(this);

  //
  bool get isphone => ValidateSpecialChar.validatePhone(this, 16);
  bool get isnotphone => !ValidateSpecialChar.validatePhone(this, 16);

  //
  // / VALIDACOES
  //
}
