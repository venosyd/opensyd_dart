///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.logs.namespace;

import 'dart:async';

import '../_module_.dart';

///
class Namespace extends OpensydEntity {
  ///
  Namespace({String id}) : super(id, 'Namespace');

  @override
  Namespace fromJson(Map<String, dynamic> map) =>
      Namespace(id: map['id'] as String)..name = map['name'] as String;

  String _name;
  String get name => _name;
  set name(String _) => set('name', _name = _);

  @override
  Future<Namespace> deep(entities, {foreign, update}) async => this;
}
