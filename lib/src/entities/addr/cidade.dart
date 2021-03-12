///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.v2.cidade;

import 'dart:async';

import '../util/_module_.dart';
import 'estado.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Cidade extends SerializableEntity {
  ///
  Cidade() : super(null, 'Cidade');

  Cidade.fromJson(Map<String, dynamic> map)
      : super(map['id'] as String, 'Cidade') {
    estadoID = map['estadoID'] as String;
    nome = map['nome'] as String ?? '';
  }

  @override
  Cidade fromJson(Map<String, dynamic> map) => Cidade.fromJson(map);

  String get estadoID => json['estadoID'] as String;
  set estadoID(String value) => json['estadoID'] = value;

  String get nome => json['nome'] as String;
  set nome(String value) => json['nome'] = value;

  Estado _estado;
  Estado get estado => _estado;
  set estado(Estado value) =>
      value != null ? estadoID = (_estado = value).id : '';

  @override
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json)
    ..['estado'] = estado?.deepmap ?? <String, dynamic>{};

  @override
  Future<Cidade> deep(entities, {foreign, update}) async {
    super.deep(entities, foreign: foreign, update: update);

    fill<Estado>(estado, estadoID, (_) => estado = _);
    await deepprocess();

    return this;
  }
}
