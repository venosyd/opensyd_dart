///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.logs.namespace;

import 'dart:async';

import '../util/_module_.dart';

class Namespace extends SerializableEntity {
  ///
  Namespace() : super(null, 'Namespace');

  Namespace.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Namespace') {
    name = map['name'] as String;
  }

  @override
  Namespace fromJson(Map<String, dynamic> map) => Namespace.fromJson(map);

  String _name;
  String get name => _name;
  set name(String value) => json['name'] = _name = value;

  @override
  Future<Namespace> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
