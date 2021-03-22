///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.pais;

import 'dart:async';

import '../_module_.dart';

///
/// os nomes das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class Pais extends OpensydEntity {
  ///
  Pais({String id}) : super(id, 'Pais');

  @override
  Pais fromJson(Map<String, dynamic> map) => Pais(id: map['id'] as String)
    ..code = Parsers.parseInt(map['code'] as String)
    ..nome = map['nome'] as String ?? '';

  String _nome;
  String get nome => _nome;
  set nome(String _) => set('nome', _nome = _);

  int _code;
  int get code => _code;
  set code(int _) => set('code', _code = _);

  @override
  Future<Pais> deep(entities, {foreign, update}) async => this;
}
