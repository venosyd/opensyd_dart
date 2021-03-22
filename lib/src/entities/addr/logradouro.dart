///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.logradouro;

import 'dart:async';

import '../_module_.dart';
import 'distrito.dart';
import 'tipo_logradouro.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Logradouro extends OpensydEntity {
  ///
  Logradouro({String id}) : super(id, 'Logradouro');

  @override
  Logradouro fromJson(Map<String, dynamic> map) =>
      Logradouro(id: map['id'] as String)
        ..cep = map['cep'] as String ?? ''
        ..nome = map['nome'] as String ?? ''
        ..distritoID = map['distritoID'] as String
        ..tipoLogradouroID = map['tipoLogradouroID'] as String;

  String _nome;
  String get nome => _nome;
  set nome(String _) => set('nome', _nome = _);

  String _cep;
  String get cep => _cep;
  set cep(String _) => set('cep', _cep = _);

  String _distritoID;
  String get distritoID => _distritoID;
  set distritoID(String _) => set('distritoID', _distritoID = _);

  String _tipologID;
  String get tipoLogradouroID => _tipologID;
  set tipoLogradouroID(String _) => set('tipoLogradouroID', _tipologID = _);

  Distrito _distrito;
  Distrito get distrito => _distrito;
  set distrito(Distrito _) => distritoID = setdeep('distrito', _distrito = _);

  TipoLogradouro _tipoLogradouro;
  TipoLogradouro get tipoLogradouro => _tipoLogradouro;
  set tipoLogradouro(TipoLogradouro _) =>
      tipoLogradouroID = setdeep('tipoLogradouro', _tipoLogradouro = _);

  String get resumo => '${tipoLogradouro.descricao} $nome, ${distrito.nome}, '
      '${distrito.cidade.nome} - ${distrito.cidade.estado.sigla}';

  @override
  Future<Logradouro> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);

    fill<Distrito>(distrito, distritoID, (_) => distrito = _);

    fill<TipoLogradouro>(
      tipoLogradouro,
      tipoLogradouroID,
      (_) => tipoLogradouro = _,
    );

    return await deepprocess();
  }
}
