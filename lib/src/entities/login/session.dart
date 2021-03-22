///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.session;

import 'dart:async';

import '../_module_.dart';
import 'authuser.dart';

///
class Session extends OpensydEntity {
  ///
  Session({String id}) : super(id, 'Session');

  @override
  Session fromJson(Map<String, dynamic> map) => Session(id: map['id'] as String)
    ..authuserID = map['authuserID'] as String
    ..sessions = Parsers.parseList(map['sessions']);

  String _authuserID;
  String get authuserID => _authuserID;
  set authuserID(String _) => set('authuserID', _authuserID = _);

  List<String> _sessions = [];
  List<String> get sessions => _sessions;
  set sessions(List<String> _) => set('sessions', _sessions = _);

  AuthUser _authuser;
  AuthUser get authuser => _authuser;
  set authuser(AuthUser _) => authuserID = setdeep('authuser', _authuser = _);

  ///
  bool validsession(String token) => sessions?.contains(token) ?? false;

  @override
  Future<Session> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);

    fill<AuthUser>(_authuser, authuserID, (_) => authuser = _);

    return await deepprocess();
  }
}
