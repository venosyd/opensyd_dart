///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.logs.log;

import 'dart:async';

import '../_module_.dart';

///
class Log extends OpensydEntity {
  ///
  Log({String id}) : super(id, 'Log');

  @override
  Log fromJson(Map<String, dynamic> map) => Log(id: map['id'] as String)
    ..type = Parsers.parseInt(map['type'])
    ..timestamp = Parsers.parseInt(map['timestamp'])
    ..namespace = map['namespace'] as String
    ..module = map['module'] as String
    ..user = map['user'] as String
    ..title = map['title'] as String
    ..details = map['details'] as String;

  int _type;
  int get type => _type;
  set type(int _) => set('type', _type = _);

  int _timestamp;
  int get timestamp => _timestamp;
  set timestamp(int _) => set('timestamp', _timestamp = _);

  String _namespace;
  String get namespace => _namespace;
  set namespace(String _) => set('namespace', _namespace = _);

  String _module;
  String get module => _module;
  set module(String _) => set('module', _module = _);

  String _user;
  String get user => _user;
  set user(String _) => set('user', _user = _);

  String _title;
  String get title => _title;
  set title(String _) => set('title', _title = _);

  String _details;
  String get details => _details;
  set details(String _) => set('details', _details = _);

  /// (1- Info, 2- Warning, 3- Error)
  String get typeF => {1: 'info', 2: 'warning', 3: 'error'}[type];

  @override
  Future<Log> deep(entities, {foreign, update}) async => this;
}
