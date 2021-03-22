///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.tipologradouro;

import 'dart:async';

import '../_module_.dart';

///
/// os descricaos das classes estao em portugues propositalmente
/// para nao conflitar com a lib antiga
///
class TipoLogradouro extends OpensydEntity {
  ///
  TipoLogradouro({String id}) : super(id, 'TipoLogradouro');

  @override
  TipoLogradouro fromJson(Map<String, dynamic> map) =>
      TipoLogradouro(id: map['id'] as String)
        ..descricao = map['descricao'] as String ?? '';

  String _descricao;
  String get descricao => _descricao;
  set descricao(String _) => set('descricao', _descricao = _);

  @override
  Future<TipoLogradouro> deep(entities, {foreign, update}) async => this;
}
