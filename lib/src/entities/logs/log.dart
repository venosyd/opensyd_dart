///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.logs.log;

import 'dart:async';

import '../../commons/_module_.dart';
import '../../extensions/_module_.dart';
import '../util/_module_.dart';

class Log extends SerializableEntity {
  ///
  Log() : super(null, 'Log');

  Log.fromJson(Map<String, dynamic> map) : super(map['id'] as String, 'Log') {
    type = Parsers.parseInt(map['type']);
    timestamp = Parsers.parseInt(map['timestamp']);
    namespace = map['namespace'] as String;
    module = map['module'] as String;
    user = map['user'] as String;
    title = map['title'] as String;
    details = map['details'] as String;
  }

  @override
  Log fromJson(Map<String, dynamic> map) => Log.fromJson(map);

  String get typeF => type == 1 ? 'info' : (type == 2 ? 'warning' : 'error');

  String get timestampF => Dates.fromInt(timestamp);

  String get timestampDT => Dates.fromIntToReadable(timestamp);

  String get timestampHTML => Dates.toHTMLFormatted(timestamp);

  /// (1- Info, 2- Warning, 3- Error)
  int get type => json['type'] as int;
  set type(int value) => json['type'] = value;

  int get timestamp => json['timestamp'] as int;
  set timestamp(int value) => json['timestamp'] = value;

  String get namespace => json['namespace'] as String;
  set namespace(String value) => json['namespace'] = value;

  String get module => json['module'] as String;
  set module(String value) => json['module'] = value;

  String get user => json['user'] as String;
  set user(String value) => json['user'] = value;

  String get title => json['title'] as String;
  set title(String value) => json['title'] = value;

  String get details => json['details'] as String;
  set details(String value) => json['details'] = value;

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['date'] = timestamp.datetime.readabledatetime;

  @override
  Future<Log> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);
    return this;
  }
}
