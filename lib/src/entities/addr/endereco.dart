///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.endereco;

import 'dart:async';

import '../util/_module_.dart';
import 'cidade.dart';
import 'distrito.dart';
import 'estado.dart';
import 'logradouro.dart';
import 'pais.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Endereco extends SerializableEntity {
  ///
  Endereco() : super(null, 'Endereco');

  Endereco.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Endereco') {
    logradouroID = map['logradouroID'] as String;
    numero = Parsers.parseInt(map['numero']);
    complemento = map['complemento'] as String ?? '';
    longitude = Parsers.parseDouble(map['longitude']);
    latitude = Parsers.parseDouble(map['latitude']);
  }

  @override
  Endereco fromJson(Map<String, dynamic> map) => Endereco.fromJson(map);

  ///
  String get extenso => logradouro == null
      ? ' - '
      : '${logradouro.tipoLogradouro.descricao} ${logradouro.nome} - ${logradouro.cep}, nº $numero '
          '${complemento != null ? '$complemento, ' : ''}${logradouro.distrito.nome}, '
          '${logradouro.distrito.cidade.nome} - ${logradouro.distrito.cidade.estado.sigla}';

  ///
  String get simples => logradouro == null
      ? ' - '
      : '${logradouro.tipoLogradouro.descricao} ${logradouro.nome} - ${logradouro.cep}, $numero '
          '${complemento != null ? '$complemento, ' : ''}${logradouro.distrito.nome}';

  ///
  Distrito get distrito => logradouro.distrito;

  ///
  Cidade get cidade => logradouro.distrito.cidade;

  ///
  Estado get estado => logradouro.distrito.cidade.estado;

  ///
  Pais get pais => logradouro.distrito.cidade.estado.pais;

  String get logradouroID => json['logradouroID'] as String;
  set logradouroID(String value) => json['logradouroID'] = value;

  String get complemento => json['complemento'] as String;
  set complemento(String value) => json['complemento'] = value;

  int get numero => json['numero'] as int;
  set numero(int value) => json['numero'] = value;

  double get latitude => json['latitude'] as double;
  set latitude(double value) => json['latitude'] = value;

  double get longitude => json['longitude'] as double;
  set longitude(double value) => json['longitude'] = value;

  Logradouro _logradouro;
  Logradouro get logradouro => _logradouro;
  set logradouro(Logradouro value) =>
      value != null ? logradouroID = (_logradouro = value).id : '';

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['logradouro'] = logradouro?.deepmap ?? <String, dynamic>{};

  @override
  Future<Endereco> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<Logradouro>(
      logradouro,
      logradouroID,
      (_) => logradouro = _,
      foreigndb: 'address',
    );

    await deepprocess();
    return this;
  }
}
