///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.news.news;

import 'dart:async';

import 'package:opensyd_dart/opensyd_dart.dart';

import 'topic.dart';

///
class News extends OpensydEntity {
  ///
  News({String id}) : super(id, 'News') {
    date = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  News fromJson(Map<String, dynamic> map) => News(id: map['id'] as String)
    ..date = Parsers.parseInt(map['date'])
    ..expire = Parsers.parseInt(map['expire'])
    ..topicID = map['topicID'] as String
    ..title = map['title'] as String
    ..content = map['content'] as String
    ..read = Parsers.parseBool(map['read'])
    ..archived = Parsers.parseBool(map['archived']);

  int _date;
  int get date => _date;
  set date(int _) => set('date', _date = _);

  int _expire;
  int get expire => _expire;
  set expire(int _) => set('expire', _expire = _);

  String _topicID;
  String get topicID => _topicID;
  set topicID(String _) => set('topicID', _topicID = _);

  String _title;
  String get title => _title;
  set title(String _) => set('title', _title = _);

  String _content;
  String get content => _content;
  set content(String _) => set('content', _content = _);

  bool _read;
  bool get read => _read ??= false;
  set read(bool _) => set('read', _read = _);

  bool _archived;
  bool get archived => _archived ??= false;
  set archived(bool _) => set('archived', _archived = _);

  Topic _topic;
  Topic get topic => _topic;
  set topic(Topic _) => topicID = setdeep('topic', _topic = _);

  @override
  Future<News> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);

    fill<Topic>(topic, topicID, (_) => topic = _);

    return await deepprocess();
  }
}
