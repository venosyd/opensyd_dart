///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.apps.account;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

///
class Account extends OpensydEntity {
  ///
  Account({String id}) : super(id, 'Account');

  @override
  Account fromJson(Map<String, dynamic> map) => Account(id: map['id'] as String)
    ..service = map['service'] as String
    ..email = map['email'] as String
    ..hash = map['hash'] as String
    ..registered = Parsers.parseInt(map['registered']);

  String _service;
  String get service => _service;
  set service(String _) => set('service', _service = _);

  String _email;
  String get email => _email;
  set email(String _) => set('email', _email = _);

  String _hash;
  String get hash => _hash;
  set hash(String _) => set('hash', _hash = _);

  int _registered;
  int get registered => _registered;
  set registered(int _) => set('registered', _registered = _);

  @override
  Future<Account> deep(entities, {foreign, update}) async => this;
}
