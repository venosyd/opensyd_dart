///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.local;

import 'dart:async';

import '../../extensions/_module_.dart';
import '../util/_module_.dart';
import '_module_.dart';

///
/// Este objeto diferente do Endereco é independente de conexao com o
/// Address e pode ser persistido/consultado sem conexao com este.
///
class EnderecoLocal extends SerializableEntity {
  ///
  EnderecoLocal() : super(null, 'EnderecoLocal');

  EnderecoLocal.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'EnderecoLocal') {
    logradouro = map['logradouro'] as String;
    cep = map['cep'] as String;
    complemento = map['complemento'] as String ?? '';
    numero = Parsers.parseInt(map['numero']);
    distrito = map['distrito'] as String;
    cidade = map['cidade'] as String;
    estado = map['estado'] as String;
    pais = map['pais'] as String;
    longitude = Parsers.parseDouble(map['longitude']);
    latitude = Parsers.parseDouble(map['latitude']);
  }

  /// recebe um endereco normal, integrado com o servico de enderecos
  /// e cria um objeto independente
  EnderecoLocal.fromEndereco(Endereco endereco)
      : super(endereco.id, 'EnderecoLocal') {
    logradouro = '${endereco.logradouro.tipoLogradouro.descricao}'
        ' ${endereco.logradouro.nome}';
    cep = endereco.logradouro.cep;
    complemento = endereco.complemento;
    numero = endereco.numero;
    distrito = endereco.distrito.nome;
    cidade = endereco.cidade.nome;
    estado = endereco.estado.nome;
    pais = endereco.pais.nome;
    longitude = endereco.longitude;
    latitude = endereco.latitude;
  }

  @override
  EnderecoLocal fromJson(Map<String, dynamic> map) =>
      EnderecoLocal.fromJson(map);

  String get logradouro => json['logradouro'] as String;
  set logradouro(String value) => json['logradouro'] = value;

  String get complemento => json['complemento'] as String;
  set complemento(String value) => json['complemento'] = value;

  int get numero => json['numero'] as int;
  set numero(int value) => json['numero'] = value;

  String get cep => json['cep'] as String;
  set cep(String value) => json['cep'] = value;

  String get distrito => json['distrito'] as String;
  set distrito(String value) => json['distrito'] = value;

  String get cidade => json['cidade'] as String;
  set cidade(String value) => json['cidade'] = value;

  String get estado => json['estado'] as String;
  set estado(String value) => json['estado'] = value;

  String get pais => json['pais'] as String;
  set pais(String value) => json['pais'] = value;

  double get latitude => json['latitude'] as double;
  set latitude(double value) => json['latitude'] = value;

  double get longitude => json['longitude'] as double;
  set longitude(double value) => json['longitude'] = value;

  @override
  String searchtitle() => '$logradouro $numero, ${cep.cepmask}';

  @override
  String searchresume() => '$logradouro $numero ${complemento ?? ''}, '
      '${cep.cepmask} ${distrito ?? ''} - ${cidade ?? ''}, ${estado ?? ''}';

  @override
  Future<EnderecoLocal> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
