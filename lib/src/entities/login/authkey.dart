///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.authkey;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

///
class AuthKey extends OpensydEntity {
  ///
  AuthKey({String id}) : super(id, 'AuthKey');

  @override
  AuthKey fromJson(Map<String, dynamic> map) => AuthKey(id: map['id'] as String)
    ..authkey = map['authkey'] as String
    ..service = map['service'] as String
    ..database = map['database'] as String;

  String _authkey;
  String get authkey => _authkey;
  set authkey(String _) => set('authkey', _authkey = _);

  String _database;
  String get database => _database;
  set database(String _) => set('database', _database = _);

  String _service;
  String get service => _service;
  set service(String _) => set('service', _service = _);

  @override
  Future<AuthKey> deep(entities, {foreign, update}) async => this;
}
