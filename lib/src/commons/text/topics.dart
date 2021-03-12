///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.sorter.topics;

import 'dart:math' as math;

abstract class TopicSorter {
  ///
  /// Organiza topicos com varios subtopicos
  ///
  /// ex:
  /// 1.1
  /// 1.1.1
  /// 1.1.2
  /// 1.2
  /// 1.3
  /// 1.3.1
  /// 1.3.2
  /// 2.4
  ///
  int sort(String i, String j) {
    final v1 = i.split('.');
    final v2 = j.split('.');

    final len1 = v1.length;
    final len2 = v2.length;
    final lim = math.min(len1, len2);

    var k = 0;
    while (k < lim) {
      final c1 = v1[k];
      final c2 = v2[k];

      if (c1 != c2) {
        return int.parse(c1) - int.parse(c2);
      }

      k++;
    }

    return len1 - len2;
  }
}
