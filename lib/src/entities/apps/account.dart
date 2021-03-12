///
/// venosyd © 2016-2021
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.apps.account;

import 'dart:async';

import '../util/_module_.dart';

///
class Account extends SerializableEntity {
  ///
  Account() : super(null, 'Account');

  ///
  Account.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Account') {
    service = map['service'] as String;
    email = map['email'] as String;
    hash = map['hash'] as String;
    registered = Parsers.parseInt(map['registered']);
  }

  @override
  Account fromJson(Map<String, dynamic> map) => Account.fromJson(map);

  String get service => json['service'] as String;
  set service(String value) => json['service'] = value;

  String get email => json['email'] as String;
  set email(String value) => json['email'] = value;

  String get hash => json['hash'] as String;
  set hash(String value) => json['hash'] = value;

  int get registered => json['registered'] as int;
  set registered(int value) => json['registered'] = value;

  @override
  Future<Account> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
