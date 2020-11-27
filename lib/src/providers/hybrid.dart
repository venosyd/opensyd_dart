///
/// venosyd © 2016-2020
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.providers.database.hybrid;

import 'dart:async';
import 'dart:convert';

import 'database.dart';
import 'lawndart.dart';

///
/// web database utils
///
class HybridDatabase implements Database {
  ///
  HybridDatabase(this.database);

  ///
  final String database;

  ///
  Store _instance;

  ///
  Future<Store> get instance async {
    _instance ??= await Store.open(database, 'data');
    return _instance;
  }

  /// nuke the storage
  @override
  Future<void> clear() async {
    instance.then<dynamic>((db) => db.nuke());
  }

  /// extracts data from localstorage based on key
  @override
  Future<String> retrieve(String key) async {
    final data = await (await instance).getByKey(key);
    return String.fromCharCodes(base64.decode(data ?? ''));
  }

  /// extracts data from localstorage based on key
  @override
  Future<bool> contains(String key) async {
    return (await instance).exists(key);
  }

  /// extracts data from localstorage based on key
  @override
  Future<String> retrieveImage(String key) async {
    final data = await (await Store.open(database, 'image')).getByKey(key);
    return data ?? '';
  }

  /// save data locally
  @override
  Future<String> save(String key, String data) async =>
      (await instance).save(base64.encode(data.codeUnits), key);

  /// save data locally
  @override
  Future<String> saveImage(String key, String image) async =>
      (await instance).save(image, key);

  /// retrieve keys
  @override
  Future<List<String>> keys() async {
    final keys = <String>[];

    // ignore: prefer_foreach
    await for (final key in (await instance).keys()) {
      keys.add(key);
    }

    return keys;
  }
}
