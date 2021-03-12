///
/// @author sergio lisan
///
/// venosyd © 2016-2021
///
library opensyd.dart.commons.datastructures.tupla;

///
/// tupla (a, b)
///
class Tupla<A, B> {
  ///
  const Tupla(this.a, this.b);

  ///
  final A a;

  ///
  final B b;

  @override
  String toString() => '($a, $b)';
}

///
/// trinca (a, b)
///
class Trinca<A, B, C> {
  ///
  const Trinca(this.a, this.b, this.c);

  ///
  final A a;

  ///
  final B b;

  ///
  final C c;

  @override
  String toString() => '($a, $b, $c)';
}
