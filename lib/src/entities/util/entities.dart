///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.util.entities;

import 'dart:async';
import 'dart:convert' as convert;

import 'package:meta/meta.dart';

import 'fillers.dart';

///
/// entidade serializavel
///
abstract class SerializableEntity with DeepEntity, Searcheable {
  /// shallow constructor
  SerializableEntity(String id, String collectionKey) {
    this.id = id;
    this.collectionKey = collectionKey;
  }

  /// json constructor
  SerializableEntity fromJson(Map<String, dynamic> map);

  //
  // Fundamental properties
  //

  String get id => json['id'] as String;
  set id(String value) => json['id'] = value;

  String get collectionKey => json['collection_key'] as String;
  set collectionKey(String value) => json['collection_key'] = value;

  /// retorna uma lista com seguranca
  List<T> retrievelist<T>(String property) =>
      (json[property] ??= <T>[]) as List<T>;

  /// retorna um mapa com seguranca
  Map<K, T> retrievemap<K, T>(String property) =>
      (json[property] ??= <K, T>{}) as Map<K, T>;

  //
  // json storage
  //

  final json = <String, dynamic>{};

  /// resumed map of properties
  Map<String, dynamic> get simplemap => Map<String, dynamic>.from(json);

  /// deep map of properties
  Map<String, dynamic> get deepmap => Map<String, dynamic>.from(json);

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
      collectionKey == (other as SerializableEntity).collectionKey;

  ///
  bool _sameid(Object other) => id == (other as SerializableEntity).id;

  @override
  String toString() => convert.json.encode(deepmap);
}

///
/// Usado para objetos que apresentam resultados de busca
///
mixin Searcheable {
  /// resumo arbitrario sobre o objeto
  String searchtitle() => toString();

  /// resumo arbitrario sobre o objeto
  String searchresume() => toString();
}

///
/// deep constructor
///
mixin DeepEntity {
  /// forma de usar:
  ///
  /// super.deep(entities, foreign, update);
  ///
  /// fill<T>(...)
  /// fillmap<K>(...)
  /// filllist<U>(...)
  ///
  /// await deepprocess();
  ///
  @mustCallSuper
  Future deep(
    Entities entities, {
    Map<String, Entities> foreign,
    bool update,
  }) async {
    configuredeep(entities, foreign, update ?? false);
    return this;
  }

  // deep functions

  /// lista de operacoes de preenchimento
  List<Future> futures = [];

  /// usados durante o deep process
  Entities entities;

  /// usados durante o deep process
  Map<String, Entities> foreign;

  /// usados durante o deep process
  bool update;

  /// seta os parametros de deep antes de usar
  void configuredeep(
    Entities entities,
    Map<String, Entities> foreign,
    bool update,
  ) {
    this.entities = entities;
    this.foreign = foreign;
    this.update = update;
  }

  /// retorna um futuro que preenche um objeto pela sua id
  void fill<T extends SerializableEntity>(
    T object,
    String id,
    void Function(T) set, {
    String foreigndb = '',
  }) {
    if ((object == null || update) && id != null) {
      final provider = foreigndb.isEmpty ? entities : foreign[foreigndb];

      final future = Fillers.fillFromAnID<T>(
        entities: provider,
        foreign: foreign,
        id: id,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      futures.add(post);
    }
  }

  ///
  void fillshallow<T extends SerializableEntity>(
    String id,
    void Function(T) set,
  ) {
    if (id != null)
      futures.add(entities.byID<T>(id).then<T>((result) {
        set(result);
        return;
      }));
  }

  /// retorna um futuro que preenche uma lista pela suas ids
  void filllist<T extends SerializableEntity>(
    List<T> list,
    List<String> ids,
    void Function(List<T>) set, {
    String foreigndb = '',
  }) {
    if (((list ?? []).isEmpty || update) && (ids ?? []).isNotEmpty) {
      final provider = foreigndb.isEmpty ? entities : foreign[foreigndb];

      final future = Fillers.fillFromIDs<T>(
        entities: provider,
        foreign: foreign,
        ids: ids,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      futures.add(post);
    }
  }

  ///
  void fillshallowlist<T extends SerializableEntity>(
    List<String> ids,
    void Function(List<T>) set,
  ) {
    futures.add(entities.listByIDs<T>(ids).then<T>((result) {
      set(result);
      return;
    }));
  }

  /// retorna um futuro que preenche um mapa pela suas ids as chaves
  void fillmap<T extends SerializableEntity, K>(
    Map<T, K> vessel,
    Map<String, K> map,
    void Function(List<T>) set, {
    String foreigndb = '',
  }) {
    final ids = map?.keys?.toList() ?? [];

    if (((vessel ?? {}).isEmpty || update) && ids.isNotEmpty) {
      final provider = foreigndb.isEmpty ? entities : foreign[foreigndb];

      final future = Fillers.fillFromIDs<T>(
        entities: provider,
        foreign: foreign,
        ids: ids,
      );

      final post = future.then<T>((result) {
        set(result);
        return;
      });

      futures.add(post);
    }
  }

  /// utilitario preenche um mapa
  Map<T, K> mapfiller<T extends SerializableEntity, K>(
    Map<String, K> map,
    List<T> result,
  ) =>
      {
        for (var id in map.keys) result.firstWhere((e) => e.id == id): map[id],
      };

  /// processa todos os futures carregados e
  /// aguarda o carregamento. apois isso, reseta
  /// a lista de futuros
  Future<void> deepprocess() async {
    await Future.wait<dynamic>(futures);
    futures.clear();
  }

  ///
  /// preenche a lista com objetos completos e a lista de ids
  ///
  void changelist<T extends SerializableEntity>(
    List<T> list,
    List<String> idslist,
    T object, [
    bool add = true,
  ]) {
    add ? list.add(object) : list.remove(object);
    add ? idslist.add(object.id) : idslist.remove(object.id);
  }

  ///
  /// preenche o mapa com objetos completos e o mapa de ids
  ///
  void changemap<T extends SerializableEntity, K>(
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
typedef EmptyInstanceGen = SerializableEntity Function(String);

///
typedef CollectionMap = String Function(Type T);

///
typedef InstanceBuilder = SerializableEntity Function(
    Map<String, dynamic> json);

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
  final Map<Type, Map<String, SerializableEntity>> cache = {};

  ///
  final InstanceBuilder builder;

  ///
  final EmptyInstanceGen emptyinstance;

  ///
  final CollectionMap collectionmap;

  ///
  Future<T> save<T extends SerializableEntity>(T object, [Type type]);

  ///
  Future<String> delete<T extends SerializableEntity>(T object, [Type type]);

  ///
  Future<T> byID<T extends SerializableEntity>(String id, [Type type]);

  ///
  Future<T> by<T extends SerializableEntity>({
    String field,
    dynamic data,
    Type type,
  });

  ///
  Future<T> byQuery<T extends SerializableEntity>(
    Map<String, dynamic> query, [
    Type type,
  ]);

  ///
  Future<List<T>> all<T extends SerializableEntity>([Type type]);

  ///
  Future<List<String>> allIDs<T extends SerializableEntity>([
    Map<String, dynamic> query,
    Type type,
  ]);

  ///
  Stream<List<T>> allStream<T extends SerializableEntity>({
    Map<String, dynamic> query,
    List<String> ids,
    Type type,
  });

  ///
  Future<List<T>> listByIDs<T extends SerializableEntity>(
    List<String> ids, [
    Type type,
  ]);

  ///
  Future<List<T>> listBy<T extends SerializableEntity>({
    String field,
    dynamic data,
    Type type,
  });

  ///
  Future<List<T>> listByQuery<T extends SerializableEntity>(
    Map<String, dynamic> query, [
    Type type,
  ]);
}
