///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.cidade;

import 'dart:async';

import '../_module_.dart';
import 'estado.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Cidade extends OpensydEntity {
  ///
  Cidade({String id}) : super(id, 'Cidade');

  @override
  Cidade fromJson(Map<String, dynamic> map) => Cidade(id: map['id'] as String)
    ..estadoID = map['estadoID'] as String
    ..nome = map['nome'] as String ?? '';

  String _estadoID;
  String get estadoID => _estadoID;
  set estadoID(String _) => set('estadoID', _estadoID = _);

  String _nome;
  String get nome => _nome;
  set nome(String _) => set('nome', _nome = _);

  Estado _estado;
  Estado get estado => _estado;
  set estado(Estado _) => estadoID = setdeep('estado', _estado = _);

  @override
  Future<Cidade> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);
    fill<Estado>(estado, estadoID, (_) => estado = _);

    return await deepprocess();
  }
}
