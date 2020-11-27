///
/// venosyd © 2016-2020
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.providers.database;

import 'dart:async';

///
/// interface para base de dados local
///
abstract class Database {
  /// erases the database
  Future<void> clear();

  /// retrieves a value by the key
  Future<String> retrieve(String key);

  /// saves a data by the key
  Future<String> save(String key, String data);

  /// retrieve keys
  Future<List<String>> keys();

  /// saves a data by the key
  Future<bool> contains(String key);

  /// retrieves an image
  Future<String> retrieveImage(String key);

  /// saves an image
  Future<String> saveImage(String key, String image);
}
