///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.endereco;

import 'dart:async';

import '../_module_.dart';
import 'cidade.dart';
import 'distrito.dart';
import 'estado.dart';
import 'logradouro.dart';
import 'pais.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Endereco extends OpensydEntity {
  ///
  Endereco({String id}) : super(id, 'Endereco');

  @override
  Endereco fromJson(Map<String, dynamic> map) =>
      Endereco(id: map['id'] as String)
        ..logradouroID = map['logradouroID'] as String
        ..numero = Parsers.parseInt(map['numero'])
        ..complemento = map['complemento'] as String ?? ''
        ..longitude = Parsers.parseDouble(map['longitude'])
        ..latitude = Parsers.parseDouble(map['latitude']);

  String _logradouroID;
  String get logradouroID => _logradouroID;
  set logradouroID(String _) => set('logradouroID', _logradouroID = _);

  String _complemento;
  String get complemento => _complemento;
  set complemento(String _) => set('complemento', _complemento = _);

  int _numero;
  int get numero => _numero;
  set numero(int _) => set('numero', _numero = _);

  double _latitude;
  double get latitude => _latitude;
  set latitude(double _) => set('latitude', _latitude = _);

  double _longitude;
  double get longitude => _longitude;
  set longitude(double _) => set('longitude', _longitude = _);

  Logradouro _logradouro;
  Logradouro get logradouro => _logradouro;
  set logradouro(Logradouro _) =>
      logradouroID = setdeep('logradouro', _logradouro = _);

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

  @override
  Future<Endereco> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);

    fill<Logradouro>(
      logradouro,
      logradouroID,
      (_) => logradouro = _,
      foreigndb: 'spanish',
    );

    return await deepprocess();
  }
}
