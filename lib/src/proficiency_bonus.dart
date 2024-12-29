import 'package:faerun/src/challenge_rating.dart';
import 'package:meta/meta.dart';

/// Reflects the impact that training has on the creature’s capabilities.
///
/// A valid range of values is 2 to 9 (up to 6 for player characters); this
/// value is assumed to be _before_ any bonus effects are applied (such as
/// doubling for _expertise_).
///
/// ## Equality
///
/// Two proficiency bonuses are considered equal if their values are equal.
///
/// ## Comparison
///
/// Proficiency bonuses are ordered by lowest to highest value.
@immutable
final class ProficiencyBonus implements Comparable<ProficiencyBonus> {
  /// Creates a new proficiency bonus.
  ///
  /// The [value] must be between 2 and 9.
  ///
  /// In most cases, this value is provided automatically by the game system.
  ProficiencyBonus(this.value) {
    RangeError.checkValueInInterval(value, 2, 9, 'value');
  }

  /// Determines the proficiency bonus based on the given [ChallengeRating].
  factory ProficiencyBonus.fromChallengeRating(ChallengeRating rating) {
    final value = rating.value;
    return switch (value) {
      <= 4 => ProficiencyBonus(2),
      >= 29 => ProficiencyBonus(9),
      _ => ProficiencyBonus((value - 1) ~/ 4 + 2),
    };
  }

  /// Value of the proficiency bonus.
  ///
  /// The value must be between 2 and 9.
  final int value;

  @override
  int compareTo(ProficiencyBonus other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(Object other) {
    return other is ProficiencyBonus && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ProficiencyBonus($value)';
}
