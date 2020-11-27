///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.distrito;

import 'dart:async';

import '../util/_module_.dart';
import 'cidade.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Distrito extends SerializableEntity {
  ///
  Distrito() : super(null, 'Distrito');

  Distrito.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Distrito') {
    cidadeID = map['cidadeID'] as String;
    nome = map['nome'] as String ?? '';
  }

  @override
  Distrito fromJson(Map<String, dynamic> map) => Distrito.fromJson(map);

  String get cidadeID => json['cidadeID'] as String;
  set cidadeID(String value) => json['cidadeID'] = value;

  String get nome => json['nome'] as String;
  set nome(String value) => json['nome'] = value;

  Cidade _cidade;
  Cidade get cidade => _cidade;
  set cidade(Cidade value) =>
      value != null ? cidadeID = (_cidade = value).id : '';

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['cidade'] = cidade?.deepmap ?? <String, dynamic>{};

  @override
  Future<Distrito> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<Cidade>(cidade, cidadeID, (_) => cidade = _);
    await deepprocess();

    return this;
  }
}
