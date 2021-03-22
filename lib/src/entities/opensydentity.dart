///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.util.entities;

import 'dart:async';
import 'dart:convert' as convert;

import 'fillers.dart';

///
/// classe abstrata que serve de base das entidades compativeis com o
/// Venosyd Entities Framework (VEF)
///
abstract class OpensydEntity
    with _SerializableEntity, _DeepEntity, _Searcheable {
  /// shallow constructor
  OpensydEntity(String id, String collectionKey) {
    this.id = id;
    this.collectionKey = collectionKey;
  }

  //
  // Fundamental properties
  //

  String _id;
  String get id => _id;
  set id(String _) => set('id', _id = _);

  String _collectionKey;
  String get collectionKey => _collectionKey;
  set collectionKey(String _) => set('collection_key', _collectionKey = _);

  //
  // equals and hashcode
  //

  @override
  int get hashCode => id.hashCode & collectionKey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (_sametype(other) && _sameid(other));

  ///
  bool _sametype(Object other) =>
      collectionKey == (other as OpensydEntity).collectionKey;

  ///
  bool _sameid(Object other) => id == (other as OpensydEntity).id;

  @override
  String toString() => convert.json.encode(deepmap);
}

///
/// Capacidade de jsonnificacao para a OpensydEntity
///
mixin _SerializableEntity {
  /// json constructor
  OpensydEntity fromJson(Map<String, dynamic> map);

  ///
  final _json = <String, dynamic>{};

  ///
  final _deep = <String, dynamic>{};

  /// resumed map of properties
  Map<String, dynamic> get json => _json;

  /// deep map of properties
  Map<String, dynamic> get deepmap =>
      Map<String, dynamic>.from(_json)..addAll(_deep);

  ///
  T get<T>(String property) => _json[property] as T;

  ///
  void set<T>(String property, T object) => _json[property] = object;

  /// insere o mapa do objeto no _deep e retorna o id dele, se houver
  String setdeep<T extends OpensydEntity>(String property, T object) {
    _deep[property] = object?.deepmap ?? <String, dynamic>{};
    return object?.id;
  }

  /// insere o mapa do objeto no _deep e retorna o id dele, se houver
  List<String> setdeeplist<T extends OpensydEntity>(
      String property, List<T> list) {
    _deep[property] = list?.map((s) => s.deepmap)?.toList() ?? [];
    return list?.map((e) => e.id)?.toList() ?? [];
  }

  ///
  /// preenche a lista com objetos completos e a lista de ids
  ///
  void changelist<T extends OpensydEntity>(
    String property,
    List<T> list,
    List<String> idslist,
    T object, [
    bool add = true,
  ]) {
    if (add) {
      list.add(object);
      idslist.add(object.id);

      _deep[property] ??= <dynamic>[];
      _deep[property].add(object.deepmap);
    }
    //
    else {
      list.remove(object);
      idslist.remove(object.id);

      _deep[property]?.remove(object.deepmap);
    }
  }

  ///
  /// preenche o mapa com objetos completos e o mapa de ids
  ///
  void changemap<T extends OpensydEntity, K>(
    Map<T, K> map,
    Map<String, K> mapids,
    T key, [
    K value,
  ]) {
    if (value != null) {
      map[key] = value;
      mapids[key.id] = value;
    }
    //
    else {
      map.remove(key);
      mapids.remove(key.id);
    }
  }
}

///
/// deep constructor
///
mixin _DeepEntity {
  /// usados durante o deep process
  bool _update;

  /// lista de operacoes de preenchimento
  final _futures = <Future>[];

  /// usados durante o deep process
  Entities _entities;

  /// usados durante o deep process
  Map<String, Entities> _foreign;

  /// forma de usar:
  ///
  /// deepconfig(_entities, foreign, update);
  ///
  /// fill<T>(...)
  /// fillmap<K>(...)
  /// filllist<U>(...)
  ///
  /// await deepprocess();
  ///
  Future deep(
    Entities entities, {
    Map<String, Entities> foreign,
    bool update,
  });

  /// prepara a configuracao para realizar o deep
  void deepconfig(
    Entities entities, {
    Map<String, Entities> foreign,
    bool update,
  }) {
    _entities = entities;
    _foreign = foreign;
    _update = update ?? false;
  }

  ///
  bool get isshallow => _entities == null;

  /// retorna um futuro que preenche um objeto pela sua id
  void fill<T extends OpensydEntity>(
    T object,
    String id,
    void Function(T) set, {
    String foreigndb = '',
  }) {
    if ((object == null || _update) && id != null) {
      final provider = foreigndb.isEmpty ? _entities : _foreign[foreigndb];

      final future = Fillers.fillFromAnID<T>(
        entities: provider,
        foreign: _foreign,
        id: id,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      _futures.add(post);
    }
  }

  ///
  void fillshallow<T extends OpensydEntity>(
    String id,
    void Function(T) set,
  ) {
    if (id != null)
      _futures.add(_entities.byID<T>(id).then<T>((result) {
        set(result);
        return;
      }));
  }

  /// retorna um futuro que preenche uma lista pela suas ids
  void filllist<T extends OpensydEntity>(
    List<T> list,
    List<String> ids,
    void Function(List<T>) set, {
    String foreigndb = '',
  }) {
    if (((list ?? []).isEmpty || _update) && (ids ?? []).isNotEmpty) {
      final provider = foreigndb.isEmpty ? _entities : _foreign[foreigndb];

      final future = Fillers.fillFromIDs<T>(
        entities: provider,
        foreign: _foreign,
        ids: ids,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      _futures.add(post);
    }
  }

  ///
  void fillshallowlist<T extends OpensydEntity>(
    List<String> ids,
    void Function(List<T>) set,
  ) {
    _futures.add(_entities.listByIDs<T>(ids).then<T>((result) {
      set(result);
      return;
    }));
  }

  /// retorna um futuro que preenche um mapa pela suas ids as chaves
  void fillmap<T extends OpensydEntity, K>(
    Map<T, K> vessel,
    Map<String, K> map,
    void Function(List<T>) set, {
    String foreigndb = '',
  }) {
    final ids = map?.keys?.toList() ?? [];

    if (((vessel ?? {}).isEmpty || _update) && ids.isNotEmpty) {
      final provider = foreigndb.isEmpty ? _entities : _foreign[foreigndb];

      final future = Fillers.fillFromIDs<T>(
        entities: provider,
        foreign: _foreign,
        ids: ids,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      _futures.add(post);
    }
  }

  /// utilitario preenche um mapa
  Map<T, K> mapfiller<T extends OpensydEntity, K>(
    Map<String, K> map,
    List<T> result,
  ) =>
      {
        for (var id in map.keys) result.firstWhere((e) => e.id == id): map[id],
      };

  /// processa todos os futures carregados e
  /// aguarda o carregamento. apois isso, reseta
  /// a lista de futuros
  Future<T> deepprocess<T extends _DeepEntity>() async {
    await Future.wait<dynamic>(_futures);
    _futures.clear();

    return this as T;
  }
}

///
/// Usado para objetos que apresentam resultados de busca
///
mixin _Searcheable {
  /// resumo arbitrario sobre o objeto
  String searchtitle() => toString();

  /// resumo arbitrario sobre o objeto
  String searchresume() => toString();
}

///
/// Classe abstrata com estrutura para fornecer informacoes
/// para integrar os modelos de um sistema ao VEF (Venosyd
/// Entities Framework)
///
abstract class EntitiesIntegrationModel {
  ///
  EntitiesIntegrationModel({
    this.exclusiveClasses,
    List<OpensydEntity> coreClasses = const [],
  }) {
    allClasses = <OpensydEntity>[...exclusiveClasses, ...coreClasses];

    buildMap = {
      for (var c in allClasses) c.collectionKey: (data) => c.fromJson(data)
    };
  }

  ///
  List<OpensydEntity> allClasses;

  ///
  List<OpensydEntity> exclusiveClasses;

  ///
  Map<String, InstanceBuilder> buildMap;

  ///
  List<OpensydEntity> get classes => exclusiveClasses;

  ///
  OpensydEntity instanceBuilder(Map<String, dynamic> data) =>
      buildMap[data['collection_key']](data);

  ///
  T emptyInstanceGen<T extends OpensydEntity>(String type) =>
      allClasses.firstWhere(
        (clazz) =>
            type == clazz.collectionKey || type == '${clazz.runtimeType}',
      ) as T;

  ///
  String collectionMap(Type type) => emptyInstanceGen('$type').collectionKey;
}

///
///
typedef EmptyInstanceGen = OpensydEntity Function(String);

///
///
typedef CollectionMap = String Function(Type T);

///
///
typedef InstanceBuilder = OpensydEntity Function(Map<String, dynamic> json);

///
/// provedor de entidades abstrato
///
abstract class Entities {
  ///
  Entities({
    this.builder,
    this.collectionmap,
    this.emptyinstance,
  });

  ///
  final Map<Type, Map<String, OpensydEntity>> cache = {};

  ///
  final InstanceBuilder builder;

  ///
  final EmptyInstanceGen emptyinstance;

  ///
  final CollectionMap collectionmap;

  ///
  Future<T> save<T extends OpensydEntity>(T object, [Type type]);

  ///
  Future<String> delete<T extends OpensydEntity>(T object, [Type type]);

  ///
  Future<T> byID<T extends OpensydEntity>(String id, [Type type]);

  ///
  Future<T> by<T extends OpensydEntity>({
    String field,
    dynamic data,
    Type type,
  });

  ///
  Future<T> byQuery<T extends OpensydEntity>(
    Map<String, dynamic> query, [
    Type type,
  ]);

  ///
  Future<List<T>> all<T extends OpensydEntity>([Type type]);

  ///
  Future<List<String>> allIDs<T extends OpensydEntity>([
    Map<String, dynamic> query,
    Type type,
  ]);

  ///
  Stream<List<T>> allStream<T extends OpensydEntity>({
    Map<String, dynamic> query,
    List<String> ids,
    Type type,
  });

  ///
  Future<List<T>> listByIDs<T extends OpensydEntity>(
    List<String> ids, [
    Type type,
  ]);

  ///
  Future<List<T>> listBy<T extends OpensydEntity>({
    String field,
    dynamic data,
    Type type,
  });

  ///
  Future<List<T>> listByQuery<T extends OpensydEntity>(
    Map<String, dynamic> query, [
    Type type,
  ]);
}
