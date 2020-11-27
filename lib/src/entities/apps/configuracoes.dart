///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.apps;

import 'dart:async';

import '../util/_module_.dart';

///
class Configuracoes extends SerializableEntity {
  ///
  Configuracoes({String id}) : super(id, 'Configuracoes');

  Configuracoes.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Configuracoes') {
    json.addAll(map);
  }

  @override
  Configuracoes fromJson(Map<String, dynamic> map) =>
      Configuracoes.fromJson(map);

  ///
  dynamic operator [](String key) => json[key];

  ///
  void operator []=(String key, dynamic value) => json[key] = value;

  @override
  Future<Configuracoes> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
