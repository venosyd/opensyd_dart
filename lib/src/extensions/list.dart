///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.extensions.list;

import 'dart:math';

///
/// Extensoes em listas
///
extension SyList<T> on List<T> {
  /// adiciona apesar se nao tiver
  void addIfNotContains(T e) => !contains(e) ? add(e) : '';

  /// sintax sugar para slices
  List<List<T>> operator /(int slices) {
    if (length <= (slices ?? 0)) {
      return [this];
    }
    //
    else {
      final sliced = <List<T>>[];
      final chunksize = (length / slices).ceil();

      for (var i = 0; i < length; i += chunksize) {
        sliced.add(sublist(i, min(i + chunksize, length)));
      }

      return sliced;
    }
  }
}
