import 'package:faerun/src/proficiency_bonus.dart';
import 'package:meta/meta.dart';
import 'package:quirk/quirk.dart';

/// A rating of the threat a monster poses to a group of four player characters.
///
/// A challenge rating encapsulates the difficulty of a monster and provides
/// a guaranteed valid range of values, as well as a [proficiencyBonus] that can
/// be used to calculate bonuses when an ability check should include the
/// monster's proficiency bonus.
///
/// ## Equality
///
/// Two challenge ratings are considered equal if their values are equal.
///
/// ## Comparison
///
/// Challenge ratings are ordered by lowest to highest value.
@immutable
final class ChallengeRating implements Comparable<ChallengeRating> {
  /// Creates a new challenge rating.
  ///
  /// The [value] must be a non-negative integer.
  ///
  /// If [denominator] is omitted, it defaults to `1`, otherwise it must be a
  /// positive integer.
  factory ChallengeRating(int value, [int denominator = 1]) {
    RangeError.checkNotNegative(value, 'value');
    checkPositive(denominator, 'denominator');
    return ChallengeRating._(value, denominator);
  }

  const ChallengeRating._(this.numerator, this.denominator);

  /// The numerator of the challenge rating.
  ///
  /// Must be a non-negative integer.
  final int numerator;

  /// The denominator of the challenge rating.
  ///
  /// Must be a positive integer.
  final int denominator;

  /// The value of the challenge rating as a floating-point number.
  ///
  /// For example, a challenge rating of `1/4` would return `0.25`.
  ///
  /// This is calculated as `numerator / denominator`.
  double get value => numerator / denominator;

  /// The proficiency bonus for the challenge rating.
  ProficiencyBonus get proficiencyBonus {
    return ProficiencyBonus.fromChallengeRating(this);
  }

  @override
  int compareTo(ChallengeRating other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(Object other) {
    return other is ChallengeRating &&
        numerator == other.numerator &&
        denominator == other.denominator;
  }

  @override
  int get hashCode => Object.hash(numerator, denominator);

  @override
  String toString() {
    return 'ChallengeRating(${switch (denominator) {
      1 => '$numerator',
      _ => '$numerator/$denominator',
    }})';
  }
}
