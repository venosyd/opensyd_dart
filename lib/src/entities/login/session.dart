///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.session;

import 'dart:async';

import '../util/_module_.dart';
import 'authuser.dart';

class Session extends SerializableEntity {
  ///
  Session() : super(null, 'Session');

  Session.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Session') {
    authuserID = map['authuserID'] as String;
    sessions = (map['sessions'] as List)?.cast<String>();
  }

  @override
  Session fromJson(Map<String, dynamic> map) => Session.fromJson(map);

  bool validsession(String token) => sessions?.contains(token) ?? false;

  String get authuserID => json['authuserID'] as String;
  set authuserID(String value) => json['authuserID'] = value;

  List<String> get sessions => json['sessions'] as List<String>;
  set sessions(List<String> value) => json['sessions'] = value;

  AuthUser _authuser;
  AuthUser get authuser => _authuser;
  set authuser(AuthUser value) =>
      value != null ? authuserID = (_authuser = value).id : '';

  @override
  Future<Session> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<AuthUser>(_authuser, authuserID, (_) => authuser = _);
    await deepprocess();

    return this;
  }
}
