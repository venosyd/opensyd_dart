// Copyright 2012 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library lawndart;

import 'dart:async';

import 'package:universal_html/html.dart';

///
///Represents a Store that can hold key/value pairs. No order
/// is guaranteed for either keys or values.
///
abstract class Store {
  // For subclasses
  Store._();

  /// Finds the best implementation. In order: IndexedDB, WebSQL, LocalStorage.
  static Future<Store> open(
    String dbName,
    String storeName, [
    Map options,
  ]) async {
    final store = LocalStorageStore._();
    await store._open();

    return store;
  }

  /// Returns all the keys as a stream. No order is guaranteed.
  Stream<String> keys();

  /// Stores an [obj] accessible by [key].
  /// The returned Future completes with the key when the objects
  /// is saved in the store.
  Future<String> save(String obj, String key);

  /// Stores all objects by their keys. This should happen in a single
  /// transaction if the underlying store supports it.
  /// The returned Future completes when all objects have been added
  /// to the store.
  Future batch(Map<String, String> objectsByKey);

  /// Returns a Future that completes with the value for a key,
  /// or null if the key does not exist.
  Future<String> getByKey(String key);

  /// Returns a Stream of all values for the keys.
  /// If a particular key is not found,
  /// no value will be returned, not even null.
  Stream<String> getByKeys(Iterable<String> keys);

  /// Returns a Future that completes with true if the key exists, or false.
  Future<bool> exists(String key);

  /// Returns a Stream of all values in no particular order.
  Stream<String> all();

  /// Returns a Future that completes when the key's value is removed.
  Future removeByKey(String key);

  /// Returns a Future that completes when all the keys' values are removed.
  Future removeByKeys(Iterable<String> keys);

  /// Returns a Future that completes when all values and keys
  /// are removed.
  Future<bool> nuke();
}

///
abstract class _MapStore extends Store {
  _MapStore._() : super._();

  Map<String, String> storage;

  Future<bool> _open() async {
    storage = _generateMap();
    return true;
  }

  Map<String, String> _generateMap();

  @override
  Stream<String> keys() async* {
    for (final k in storage.keys) {
      yield k;
    }
  }

  @override
  Future<String> save(String obj, String key) async {
    storage[key] = obj;
    return key;
  }

  @override
  Future batch(Map<String, String> objs) async {
    for (final key in objs.keys) {
      storage[key] = objs[key];
    }
    return true;
  }

  @override
  Future<String> getByKey(String key) async {
    return storage[key];
  }

  @override
  Stream<String> getByKeys(Iterable<String> keys) async* {
    final values = keys.map((key) => storage[key]).where((v) => v != null);

    // ignore: prefer_final_in_for_each
    for (var v in values) {
      yield v;
    }
  }

  @override
  Future<bool> exists(String key) async {
    return storage.containsKey(key);
  }

  @override
  Stream<String> all() async* {
    // ignore: prefer_final_in_for_each
    for (var v in storage.values) {
      yield v;
    }
  }

  @override
  Future removeByKey(String key) async {
    storage.remove(key);
    return true;
  }

  @override
  Future removeByKeys(Iterable<String> keys) async {
    keys.forEach((key) => storage.remove(key));
    return true;
  }

  @override
  Future<bool> nuke() async {
    storage.clear();
    return true;
  }
}

///
/// Wraps the local storage API and exposes it as a [Store].
/// Local storage is a synchronous API, and generally not recommended
/// unless all other storage mechanisms are unavailable.
///
class LocalStorageStore extends _MapStore {
  LocalStorageStore._() : super._();

  static Future<LocalStorageStore> open() async {
    final store = LocalStorageStore._();
    await store._open();

    return store;
  }

  @override
  Map<String, String> _generateMap() => window.localStorage;
}
