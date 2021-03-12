///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.pais;

import 'dart:async';

import '../util/_module_.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Pais extends SerializableEntity {
  ///
  Pais() : super(null, 'Pais');

  Pais.fromJson(Map<String, dynamic> map) : super(map['id'] as String, 'Pais') {
    code = Parsers.parseInt(map['code'] as String);
    nome = map['nome'] as String ?? '';
  }

  @override
  Pais fromJson(Map<String, dynamic> map) => Pais.fromJson(map);

  String get nome => json['nome'] as String;
  set nome(String value) => json['nome'] = value;

  int get code => json['code'] as int;
  set code(int value) => json['code'] = value;

  @override
  Future<Pais> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
