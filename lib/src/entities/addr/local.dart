///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.addr.local;

import 'dart:async';

import '../../extensions/_module_.dart';
import '../_module_.dart';
import '_module_.dart';

///
/// Este objeto diferente do Endereco é independente de conexao com o
/// Spanish e pode ser persistido/consultado sem conexao com este.
///
class EnderecoLocal extends OpensydEntity {
  ///
  EnderecoLocal({String id}) : super(id, 'EnderecoLocal');

  /// recebe um endereco normal, integrado com o servico de enderecos
  /// e cria um objeto independente
  EnderecoLocal.fromEndereco(Endereco endereco)
      : super(endereco.id, 'EnderecoLocal') {
    logradouro = '${endereco.logradouro.tipoLogradouro.descricao}'
        ' ${endereco.logradouro.nome}';
    cep = endereco.logradouro.cep;
    complemento = endereco.complemento;
    numero = endereco.numero;
    distrito = endereco.distrito.nome;
    cidade = endereco.cidade.nome;
    estado = endereco.estado.nome;
    pais = endereco.pais.nome;
    longitude = endereco.longitude;
    latitude = endereco.latitude;
  }

  @override
  EnderecoLocal fromJson(Map<String, dynamic> map) =>
      EnderecoLocal(id: map['id'] as String)
        ..logradouro = map['logradouro'] as String
        ..cep = map['cep'] as String
        ..complemento = map['complemento'] as String ?? ''
        ..numero = Parsers.parseInt(map['numero'])
        ..distrito = map['distrito'] as String
        ..cidade = map['cidade'] as String
        ..estado = map['estado'] as String
        ..pais = map['pais'] as String
        ..longitude = Parsers.parseDouble(map['longitude'])
        ..latitude = Parsers.parseDouble(map['latitude']);

  String _logradouro;
  String get logradouro => _logradouro;
  set logradouro(String _) => set('logradouro', _logradouro = _);

  String _complemento;
  String get complemento => _complemento;
  set complemento(String _) => set('complemento', _complemento = _);

  int _numero;
  int get numero => _numero;
  set numero(int _) => set('numero', _numero = _);

  String _cep;
  String get cep => _cep;
  set cep(String _) => set('cep', _cep = _);

  String _distrito;
  String get distrito => _distrito;
  set distrito(String _) => set('distrito', _distrito = _);

  String _cidade;
  String get cidade => _cidade;
  set cidade(String _) => set('cidade', _cidade = _);

  String _estado;
  String get estado => _estado;
  set estado(String _) => set('estado', _estado = _);

  String _pais;
  String get pais => _pais;
  set pais(String _) => set('pais', _pais = _);

  double _latitude;
  double get latitude => _latitude;
  set latitude(double _) => set('latitude', _latitude = _);

  double _longitude;
  double get longitude => _longitude;
  set longitude(double _) => set('longitude', _longitude = _);

  @override
  String searchtitle() => '$logradouro $numero, ${cep.cepmask}';

  @override
  String searchresume() => '$logradouro $numero ${complemento ?? ''}, '
      '${cep.cepmask} ${distrito ?? ''} - ${cidade ?? ''}, ${estado ?? ''}';

  @override
  Future<EnderecoLocal> deep(entities, {foreign, update}) async => this;
}
