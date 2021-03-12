///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.estado;

import 'dart:async';

import '../util/_module_.dart';
import 'pais.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Estado extends SerializableEntity {
  ///
  Estado() : super(null, 'Estado');

  Estado.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Estado') {
    paisID = map['paisID'] as String;
    nome = map['nome'] as String ?? '';
    sigla = map['sigla'] as String ?? '';
  }

  @override
  Estado fromJson(Map<String, dynamic> map) => Estado.fromJson(map);

  String get paisID => json['paisID'] as String;
  set paisID(String value) => json['paisID'] = value;

  String get nome => json['nome'] as String;
  set nome(String value) => json['nome'] = value;

  String get sigla => json['sigla'] as String;
  set sigla(String value) => json['sigla'] = value;

  Pais _pais;
  Pais get pais => _pais;
  set pais(Pais value) => value != null ? paisID = (_pais = value).id : '';

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['pais'] = pais?.deepmap ?? <String, dynamic>{};

  @override
  Future<Estado> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<Pais>(pais, paisID, (_) => pais = _);
    await deepprocess();

    return this;
  }
}
