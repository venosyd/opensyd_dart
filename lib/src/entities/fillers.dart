///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.entities.util.fillers;

import 'dart:async';

import 'opensydentity.dart';

///
/// sao preenchedores do VEF (Venosyd Entities Framework)
///
abstract class Fillers {
  ///
  /// preenche um objeto raso associando objetos compostos encontrados
  /// na base de dados
  ///
  static Future<T> fillFromAnID<T extends OpensydEntity>({
    Map<String, Entities> foreign,
    Entities entities,
    String id,
    bool update = false,
  }) async {
    final object = await entities.byID<T>(id);

    if (object.isshallow || update)
      return await object.deep(
        entities,
        foreign: foreign,
        update: update,
      ) as T;
    //
    else
      return object;
  }

  ///
  /// substituta da fillList
  ///
  static Future<List<T>> fillFromIDs<T extends OpensydEntity>({
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
  static Future<List<T>> fillShallowObjects<T extends OpensydEntity>({
    Map<String, Entities> foreign,
    Entities entities,
    List<T> shallowObjs,
    bool update = false,
  }) async {
    final futures = <Future<T>>[];

    for (final shallow in shallowObjs) {
      if (shallow.isshallow || update)
        futures.add(shallow.deep(entities, foreign: foreign, update: update)
            as Future<T>);
      //
      else
        futures.add((() async => shallow)());
    }

    return List<T>.from(await Future.wait<T>(futures));
  }
}
