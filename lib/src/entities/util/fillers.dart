///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.util.fillers;

import 'dart:async';

import 'entities.dart';

///
/// sao preenchedores do VEF (Venosyd Entities Framework)
///
abstract class Fillers {
  ///
  /// preenche um objeto raso associando objetos compostos encontrados
  /// na base de dados
  ///
  static Future<T> fillFromAnID<T extends SerializableEntity>({
    Map<String, Entities> foreign,
    Entities entities,
    String id,
    bool update = false,
  }) async {
    final shallow = await entities.byID<T>(id);

    if (shallow.entities == null || update)
      return await shallow.deep(
        entities,
        foreign: foreign,
        update: update,
      ) as T;
    //
    else
      return shallow;
  }

  ///
  /// substituta da fillList
  ///
  static Future<List<T>> fillFromIDs<T extends SerializableEntity>({
    Map<String, Entities> foreign,
    Entities entities,
    List<String> ids,
    bool update = false,
  }) async {
    final shallow = await entities.listByIDs<T>(ids);

    final deep = await fillShallowObjects<T>(
      entities: entities,
      foreign: foreign,
      shallowObjs: shallow,
      update: update,
    );

    return List<T>.from(deep);
  }

  ///
  /// substituta da fillAll
  ///
  static Future<List<T>> fillShallowObjects<T extends SerializableEntity>({
    Map<String, Entities> foreign,
    Entities entities,
    List<T> shallowObjs,
    bool update = false,
  }) async {
    final futures = <Future<T>>[];

    for (final shallow in shallowObjs) {
      if (shallow.entities == null || update)
        futures.add(shallow.deep(entities, foreign: foreign, update: update)
            as Future<T>);
      //
      else
        futures.add((() async => shallow)());
    }

    return List<T>.from(await Future.wait<T>(futures));
  }
}
