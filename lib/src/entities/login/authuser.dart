///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.authuser;

import 'dart:async';

import '../_module_.dart';

///
///
///
class AuthUser extends OpensydEntity {
  ///
  AuthUser({String id}) : super(id, 'AuthUser');

  @override
  AuthUser fromJson(Map<String, dynamic> map) =>
      AuthUser(id: map['id'] as String)
        ..email = map['email'] as String
        ..phone = map['phone'] as String
        ..password = map['password'] as String
        ..authorized = Parsers.parseInt(map['authorized'])
        ..registerdate = Parsers.parseInt(map['registerdate'])
        ..roles = Parsers.parseList(map['roles'])
        ..history = Parsers.parseList(map['history']);

  String _email;
  String get email => _email;
  set email(String _) => set('email', _email = _);

  String _phone;
  String get phone => _phone;
  set phone(String _) => set('phone', _phone = _);

  String _password;
  String get password => _password;
  set password(String _) => set('password', _password = _);

  int _registerdate;
  int get registerdate => _registerdate;
  set registerdate(int _) => set('registerdate', _registerdate = _);

  int _authorized;
  int get authorized => _authorized;
  set authorized(int _) => set('authorized', _authorized = _);

  List<String> _history = [];
  List<String> get history => _history;
  set history(List<String> _) => set('history', _history = _);

  List<String> _roles = [];
  List<String> get roles => _roles;
  set roles(List<String> _) => set('roles', _roles = _);

  @override
  Future<AuthUser> deep(entities, {foreign, update}) async => this;
}
