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

  /// Returns the result of combining multiple possible circumstances.
  ///
  /// If the list...
  /// - is empty, `null` is returned;
  /// - contains only [advantage], [advantage] is returned;
  /// - contains only [disadvantage], [disadvantage] is returned;
  /// - contains both [advantage] and [disadvantage], `null` is returned.
  static Circumstance? combine(Iterable<Circumstance> circumstances) {
    if (circumstances.isEmpty) {
      return null;
    }
    var hasAdvantage = false;
    var hasDisadvantage = false;
    for (final circumstance in circumstances) {
      if (circumstance == advantage) {
        hasAdvantage = true;
      } else {
        hasDisadvantage = true;
      }
    }
    return switch (hasAdvantage) {
      true => hasDisadvantage ? null : advantage,
      false => hasDisadvantage ? disadvantage : null,
    };
  }

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
