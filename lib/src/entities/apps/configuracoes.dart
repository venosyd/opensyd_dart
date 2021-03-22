///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.apps.config;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

///
class Configuracoes extends OpensydEntity {
  ///
  Configuracoes({String id}) : super(id, 'Configuracoes');

  @override
  Configuracoes fromJson(Map<String, dynamic> map) =>
      Configuracoes(id: map['id'] as String)..json.addAll(map);

  ///
  dynamic operator [](String key) => get<dynamic>(key);

  ///
  void operator []=(String key, dynamic value) => set<dynamic>(key, value);

  @override
  Future<Configuracoes> deep(entities, {foreign, update}) async => this;
}
