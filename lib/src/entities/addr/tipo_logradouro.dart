///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.tipologradouro;

import 'dart:async';

import '../util/_module_.dart';

///
/// os descricaos das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class TipoLogradouro extends SerializableEntity {
  ///
  TipoLogradouro() : super(null, 'TipoLogradouro');

  TipoLogradouro.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'TipoLogradouro') {
    descricao = map['descricao'] as String ?? '';
  }

  @override
  TipoLogradouro fromJson(Map<String, dynamic> map) =>
      TipoLogradouro.fromJson(map);

  String get descricao => json['descricao'] as String;
  set descricao(String value) => json['descricao'] = value;

  @override
  Future<TipoLogradouro> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
