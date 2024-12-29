import 'dart:math' as math;

/// Whether an ability test is at [advantage] or [disadvantage].
///
/// `Circumstance?` should often be used as a parameter type.
enum Circumstance {
  /// The test is at advantage.
  ///
  /// The higher of two rolls is taken.
  advantage,

  /// The test is at disadvantage.
  ///
  /// The lower of two rolls is taken.
  disadvantage;

  /// Returns the result of rolling with advantage or disadvantage.
  ///
  /// If `this` is [advantage], the higher of the two rolls is returned;
  /// otherwise, the lower of the two rolls is returned.
  int pick(int first, int second) {
    return switch (this) {
      advantage => math.max(first, second),
      disadvantage => math.min(first, second),
    };
  }
}
