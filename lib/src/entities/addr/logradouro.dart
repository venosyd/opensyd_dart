///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.logradouro;

import 'dart:async';

import '../util/_module_.dart';
import 'distrito.dart';
import 'tipo_logradouro.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Logradouro extends SerializableEntity {
  ///
  Logradouro() : super(null, 'Logradouro');

  Logradouro.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Logradouro') {
    cep = map['cep'] as String ?? '';
    nome = map['nome'] as String ?? '';
    distritoID = map['distritoID'] as String;
    tipoLogradouroID = map['tipoLogradouroID'] as String;
  }

  @override
  Logradouro fromJson(Map<String, dynamic> map) => Logradouro.fromJson(map);

  String get resumo => '${tipoLogradouro.descricao} $nome, ${distrito.nome}, '
      '${distrito.cidade.nome} - ${distrito.cidade.estado.sigla}';

  String get nome => json['nome'] as String;
  set nome(String value) => json['nome'] = value;

  String get cep => json['cep'] as String;
  set cep(String value) => json['cep'] = value;

  String get distritoID => json['distritoID'] as String;
  set distritoID(String value) => json['distritoID'] = value;

  String get tipoLogradouroID => json['tipoLogradouroID'] as String;
  set tipoLogradouroID(String value) => json['tipoLogradouroID'] = value;

  Distrito _distrito;
  Distrito get distrito => _distrito;
  set distrito(Distrito value) =>
      value != null ? distritoID = (_distrito = value).id : '';

  TipoLogradouro _tipoLogradouro;
  TipoLogradouro get tipoLogradouro => _tipoLogradouro;
  set tipoLogradouro(TipoLogradouro value) =>
      value != null ? tipoLogradouroID = (_tipoLogradouro = value).id : '';

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['distrito'] = distrito?.deepmap ?? <String, dynamic>{}
    ..['tipoLogradouro'] = tipoLogradouro?.deepmap ?? <String, dynamic>{};

  @override
  Future<Logradouro> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<Distrito>(distrito, distritoID, (_) => distrito = _);

    fill<TipoLogradouro>(
      tipoLogradouro,
      tipoLogradouroID,
      (_) => tipoLogradouro = _,
    );

    await deepprocess();

    return this;
  }
}
