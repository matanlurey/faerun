import 'package:faerun/src/internal.dart';
import 'package:meta/meta.dart';

/// Abilities that measure physical and mental characteristics.
enum Ability {
  /// Physical might.
  strength,

  /// Agility, reflexes, and balance.
  dexterity,

  /// Health and stamina.
  constitution,

  /// Reasoning and memory.
  intelligence,

  /// Perceptiveness and mental fortitude.
  wisdom,

  /// Confidence, poise, and charm.
  charisma;

  /// Returns the ability with the exact [name], or `null` if none exists.
  static Ability? tryByName(String name) {
    return values.firstWhereOrNull((ability) => ability.name == name);
  }

  /// Returns the ability with the given [name], which must exist.
  static Ability byName(String name) {
    final result = tryByName(name);
    if (result == null) {
      throw ArgumentError.value(name, 'name', 'not a valid ability name');
    }
    return result;
  }

  /// Returns the ability with the given [abbreviation], which must exist.
  static Ability byAbbreviation(String abbreviation) {
    final result = tryByAbbreviation(abbreviation);
    if (result == null) {
      throw ArgumentError.value(
        abbreviation,
        'abbreviation',
        'not a valid ability abbreviation',
      );
    }
    return result;
  }

  /// Returns the ability with the given [abbreviation], or `null` if none
  /// exists.
  static Ability? tryByAbbreviation(String abbreviation) {
    return values.firstWhereOrNull(
      (ability) => ability.abbreviation == abbreviation,
    );
  }

  /// Three-letter abbreviation of the ability, in lowercase.
  ///
  /// For example, `Ability.strength.abbreviation` returns `'str'`.
  String get abbreviation => name.substring(0, 3);
}

/// Ability [score], or the amount of an [Ability] a character or creature has.
///
/// ## Equality
///
/// Two ability scores are considered equal if they have the same [ability] and
/// [score].
@immutable
final class AbilityScore {
  /// Creates a new ability score.
  ///
  /// {@template faerun.AbilityScore:validScore}
  /// The [score] must be a positive integer between 1 and 30, inclusive.
  /// {@endtemplate}
  factory AbilityScore(Ability ability, int score) {
    RangeError.checkValueInInterval(score, 1, 30, 'score');
    return AbilityScore._(ability, score);
  }

  const AbilityScore._(this.ability, this.score);

  /// The ability the score is for.
  final Ability ability;

  /// Amount of an ability a character or creature has.
  ///
  /// The [score] must be a positive integer between 1 and 30, inclusive.
  final int score;

  /// The modifier for the ability score.
  ///
  /// The modifier is calculated as `(score - 10) ~/ 2`; that is, an ability
  /// score of `1` has a modifier of `-5`, and an ability score of `30` has a
  /// modifier of `10`.
  int get modifier {
    if (score < 10) {
      return (score - 11) ~/ 2;
    } else {
      return (score - 10) ~/ 2;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is AbilityScore &&
        ability == other.ability &&
        score == other.score;
  }

  @override
  int get hashCode => Object.hash(ability, score);

  @override
  String toString() => 'AbilityScore($ability, $score)';
}
