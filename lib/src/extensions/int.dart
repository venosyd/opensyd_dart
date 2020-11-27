///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.extensions.int;

///
/// Extensoes em int
///
extension SyInt on int {
  ///
  DateTime get datetime => DateTime.fromMillisecondsSinceEpoch(this);

  ///
  List<int> range() => List<int>.generate(this, (i) => i);

  ///
  List<int> rangeWith() => List<int>.generate(this + 1, (i) => i);

  ///
  List<int> rangeFromTo(int limit) =>
      List<int>.generate(limit, (i) => i + this);

  ///
  List<int> rangeFromToWith(int limit) =>
      List<int>.generate(limit + 1, (i) => i + this);
}
