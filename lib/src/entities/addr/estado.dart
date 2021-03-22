///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.estado;

import 'dart:async';

import '../_module_.dart';
import 'pais.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Estado extends OpensydEntity {
  ///
  Estado({String id}) : super(id, 'Estado');

  @override
  Estado fromJson(Map<String, dynamic> map) => Estado(id: map['id'] as String)
    ..paisID = map['paisID'] as String
    ..nome = map['nome'] as String ?? ''
    ..sigla = map['sigla'] as String ?? '';

  String _paisID;
  String get paisID => _paisID;
  set paisID(String _) => set('paisID', _paisID = _);

  String _nome;
  String get nome => _nome;
  set nome(String _) => set('nome', _nome = _);

  String _sigla;
  String get sigla => _sigla;
  set sigla(String _) => set('sigla', _sigla = _);

  Pais _pais;
  Pais get pais => _pais;
  set pais(Pais _) => paisID = setdeep('pais', _pais = _);

  @override
  Future<Estado> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);
    fill<Pais>(pais, paisID, (_) => pais = _);

    return await deepprocess();
  }
}
