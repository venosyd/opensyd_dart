///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.login.authuser;

import 'dart:async';

import '../../commons/_module_.dart';
import '../util/_module_.dart';

///
///
///
class AuthUser extends SerializableEntity {
  ///
  AuthUser() : super(null, 'AuthUser');

  AuthUser.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'AuthUser') {
    email = map['email'] as String;
    phone = map['phone'] as String;
    password = map['password'] as String;
    authorized = Parsers.parseInt(map['authorized']);
    roles = (map['roles'] as List)?.cast<String>();
    history = (map['history'] as List)?.cast<String>();
    registerdate = Parsers.parseInt(map['registerdate']) ??
        DateTime.parse(map['register_date'] as String).millisecondsSinceEpoch;
  }

  @override
  AuthUser fromJson(Map<String, dynamic> map) => AuthUser.fromJson(map);

  String get registerdatedt => Dates.fromIntToReadable(registerdate);

  String get registerdateF => Dates.toHTMLFormatted(registerdate);

  String get email => json['email'] as String;
  set email(String value) => json['email'] = value;

  String get phone => json['phone'] as String;
  set phone(String value) => json['phone'] = value;

  String get password => json['password'] as String;
  set password(String value) => json['password'] = value;

  int get registerdate => json['registerdate'] as int;
  set registerdate(int value) => json['registerdate'] = value;

  int get authorized => json['authorized'] as int;
  set authorized(int value) => json['authorized'] = value;

  List<String> get history => json['history'] as List<String>;
  set history(List<String> value) => json['history'] = value;

  List<String> get roles => json['roles'] as List<String>;
  set roles(List<String> value) => json['roles'] = value;

  @override
  Future<AuthUser> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
