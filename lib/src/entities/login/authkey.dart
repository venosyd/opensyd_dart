///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.authkey;

import 'dart:async';

import '../util/_module_.dart';

///
class AuthKey extends SerializableEntity {
  ///
  AuthKey({String id}) : super(id, 'AuthKey');

  ///
  AuthKey.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'AuthKey') {
    authkey = map['authkey'] as String;
    service = map['service'] as String;
    database = map['database'] as String;
  }

  @override
  AuthKey fromJson(Map<String, dynamic> map) => AuthKey.fromJson(map);

  String get authkey => json['authkey'] as String;
  set authkey(String value) => json['authkey'] = value;

  String get database => json['database'] as String;
  set database(String value) => json['database'] = value;

  String get service => json['service'] as String;
  set service(String value) => json['service'] = value;

  @override
  Future<AuthKey> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
