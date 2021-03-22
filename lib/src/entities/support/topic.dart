///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.apps.topic;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

///
class Topic extends OpensydEntity {
  ///
  Topic({String id}) : super(id, 'Topic');

  @override
  Topic fromJson(Map<String, dynamic> map) => Topic(id: map['id'] as String)
    ..name = map['name'] as String
    ..archived = Parsers.parseBool(map['archived']);

  String _name;
  String get name => _name;
  set name(String _) => set('name', _name = _);

  bool _archived = false;
  bool get archived => _archived;
  set archived(bool _) => set('archived', _archived = _);

  @override
  Future<Topic> deep(entities, {foreign, update}) async => this;
}
