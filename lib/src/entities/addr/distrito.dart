///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.distrito;

import 'dart:async';

import '../_module_.dart';
import 'cidade.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Distrito extends OpensydEntity {
  ///
  Distrito({String id}) : super(id, 'Distrito');

  @override
  Distrito fromJson(Map<String, dynamic> map) =>
      Distrito(id: map['id'] as String)
        ..cidadeID = map['cidadeID'] as String
        ..nome = map['nome'] as String ?? '';

  String _cidadeID;
  String get cidadeID => _cidadeID;
  set cidadeID(String _) => set('cidadeID', _cidadeID = _);

  String _nome;
  String get nome => _nome;
  set nome(String _) => set('nome', _nome = _);

  Cidade _cidade;
  Cidade get cidade => _cidade;
  set cidade(Cidade _) => cidadeID = setdeep('cidade', _cidade = _);

  @override
  Future<Distrito> deep(entities, {foreign, update}) async {
    deepconfig(entities, foreign: foreign, update: update);
    fill<Cidade>(cidade, cidadeID, (_) => cidade = _);

    return await deepprocess();
  }
}
