import 'package:checks/context.dart';

export 'package:checks/checks.dart';
export 'package:test/test.dart' show TestOn, fail, group, setUp, tearDown, test;

extension ObjectChecks<T extends Object?> on Subject<T> {
  /// Expects that this value is equivalent to [other].
  ///
  /// Two objects are considered equivalent if they are equal and have the same
  /// hash code.
  void isEquivalentTo(T other) {
    context.expect(() => prefixFirst('equals ', literal(other)), (actual) {
      if (actual != other) {
        return Rejection(which: ['are not equal']);
      }
      if (actual.hashCode != other.hashCode) {
        return Rejection(which: ['have different hash codes']);
      }
      return null;
    });
  }

  /// Returns a subject that expects the [Object.toString] representation of
  /// this value.
  Subject<String> get hasToString {
    return context.nest<String>(
      () => ['has a string representation'],
      (actual) => Extracted.value(actual.toString()),
      atSameLevel: true,
    );
  }
}
