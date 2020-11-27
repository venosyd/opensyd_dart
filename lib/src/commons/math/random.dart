///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.math.random;

import 'dart:math' as math;

/// utilidade para aleatorios
abstract class Aleatorio {
  /// retorna um numero aleatorio
  static int next(int min, int max) => min + math.Random().nextInt(max - min);
}
