///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.report.report;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

import 'topic.dart';

///
class Report extends OpensydEntity {
  ///
  Report({String id}) : super(id, 'Report');

  @override
  Report fromJson(Map<String, dynamic> map) => Report(id: map['id'] as String)
    ..title = map['title'] as String
    ..topicID = map['topicID'] as String
    ..content = map['content'] as String
    ..reporter = map['reporter'] as String
    ..response = map['response'] as String
    ..date = Parsers.parseInt(map['date'])
    ..responsedate = Parsers.parseInt(map['responsedate'])
    ..read = Parsers.parseBool(map['read'])
    ..resolved = Parsers.parseBool(map['resolved'])
    ..archived = Parsers.parseBool(map['archived']);

  int _date;
  int get date => _date;
  set date(int _) => set('date', _date = _);

  int _responsedate;
  int get responsedate => _responsedate;
  set responsedate(int _) => set('responsedate', _responsedate = _);

  String _topicID;
  String get topicID => _topicID;
  set topicID(String _) => set('topicID', _topicID = _);

  String _title;
  String get title => _title;
  set title(String _) => set('title', _title = _);

  String _reporter;
  String get reporter => _reporter;
  set reporter(String _) => set('reporter', _reporter = _);

  String _content;
  String get content => _content;
  set content(String _) => set('content', _content = _);

  String _response;
  String get response => _response;
  set response(String _) => set('response', _response = _);

  bool _read = false;
  bool get read => _read;
  set read(bool _) => set('read', _read = _);

  bool _resolved = false;
  bool get resolved => _resolved;
  set resolved(bool _) => set('resolved', _resolved = _);

  bool _archived = false;
  bool get archived => _archived;
  set archived(bool _) => set('archived', _archived = _);

  Topic _topic;
  Topic get topic => _topic;
  set topic(Topic _) => _ != null ? topicID = (_topic = _).id : '';

  @override
  Future<Report> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);

    fill<Topic>(topic, topicID, (_) => topic = _);

    return await deepprocess();
  }
}
