import 'package:collection/collection.dart';
import 'package:faerun/src/skill.dart';
import 'package:meta/meta.dart';

/// Abilities that measure physical and mental characteristics.
///
/// For example, [strength] measures physical might:
///
/// ```dart
/// final ability = Ability.strength;
/// ```
///
/// For display and serialization purposes, each ability has a unique [name]
/// and three-letter [abbreviation]. The name is the same as the enum value, and
/// the abbreviation is the first three letters of the name in lowercase. Use
/// [byName] and [byAbbreviation] to look up abilities by name or abbreviation.
///
/// ## Comparison
///
/// Abilities are ordered based on their enum value, with [strength] being the
/// lowest and [charisma] being the highest.
///
/// ## Example
///
/// To get the name and abbreviation of an ability:
///
/// ```dart
/// final ability = Ability.strength;
/// print(ability.name); // 'strength'
/// print(ability.abbreviation); // 'str'
/// ```
///
/// To look up an ability by name or abbreviation:
///
/// ```dart
/// final a = Ability.byName('strength');
/// print(a); // 'Ability.strength'
///
/// final b = Ability.byAbbreviation('str');
/// print(b); // 'Ability.strength'
/// ```
enum Ability implements Comparable<Ability> {
  /// Physical might.
  strength(
    measures: 'Physical might',
    checkExample: 'Lift, push, pull, or break something',
    savingThrowExample: 'Physically resist direct force',
  ),

  /// Agility, reflexes, and balance.
  dexterity(
    measures: 'Agility, reflexes, and balance',
    checkExample: 'Move nimbly, quickly, or quietly',
    savingThrowExample: 'Dodge out of harm’s way',
  ),

  /// Health and stamina.
  constitution(
    measures: 'Health and stamina',
    checkExample: 'Push your body beyond normal limits',
    savingThrowExample: 'Endure a toxic hazard',
  ),

  /// Reasoning and memory.
  intelligence(
    measures: 'Reasoning and memory',
    checkExample: 'Reason or remember',
    savingThrowExample: 'Recognize an illusion as fake',
  ),

  /// Perceptiveness and mental fortitude.
  wisdom(
    measures: 'Perceptiveness and mental fortitude',
    checkExample: 'Notice things in the environment or in creatures’ behavior',
    savingThrowExample: 'Resist a mental assault',
  ),

  /// Confidence, poise, and charm.
  charisma(
    measures: 'Confidence, poise, and charm',
    checkExample: 'Influence, entertain, or deceive',
    savingThrowExample: 'Assert your identity',
  );

  const Ability({
    required this.measures,
    required this.checkExample,
    required this.savingThrowExample,
  });

  /// Returns the ability with the exact [name], or `null` if none exists.
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [byName] instead.
  static Ability? tryByName(String name) {
    return values.firstWhereOrNull((ability) => ability.name == name);
  }

  /// Returns the ability with the given [name].
  ///
  /// [name] must be the exact name of an ability, such as `'strength'` or
  /// `'charisma'`, or an error is thrown.
  ///
  /// If you are unsure whether the name is valid, such as when the name comes
  /// from user input or an external source, use [tryByName] instead which
  /// returns `null` if the name is invalid.
  static Ability byName(String name) {
    final result = tryByName(name);
    if (result == null) {
      throw ArgumentError.value(name, 'name', 'not a valid ability name');
    }
    return result;
  }

  /// Returns the ability with the given [abbreviation], which must exist.
  ///
  /// [abbreviation] must be the three-letter abbreviation of an ability, such
  /// as `'str'` or `'cha'`, or an error is thrown.
  ///
  /// If you are unsure whether the abbreviation is valid, such as when the
  /// abbreviation comes from user input or an external source, use
  /// [tryByAbbreviation] instead which returns `null` if the abbreviation is
  /// invalid.
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
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [byAbbreviation] instead.
  static Ability? tryByAbbreviation(String abbreviation) {
    return values.firstWhereOrNull(
      (ability) => ability.abbreviation == abbreviation,
    );
  }

  /// A description of what the ability measures, or its purpose.
  final String measures;

  /// A description of what an ability check might use this ability for.
  final String checkExample;

  /// A description of what a savings throw might use this ability for.
  final String savingThrowExample;

  /// Three-letter abbreviation of the ability.
  ///
  /// For example, `Ability.strength.abbreviation` returns `'str'`.
  String get abbreviation => name.substring(0, 3);

  /// Skill checks that use this ability.
  Iterable<Skill> get skills {
    return Skill.values.where((skill) => skill.ability == this);
  }

  @override
  int compareTo(Ability other) => index.compareTo(other.index);
}

/// Ability [score], or the amount of an [Ability] a character or creature has.
///
/// An ability score encapsulates both the ability and the score, and provides
/// a guaranteed valid range for the score, as well as a [modifier] that can be
/// used to calculate bonuses and penalties; for example, a score of `1` has a
/// modifier of `-5`, and a score of `30` has a modifier of `10`.
///
/// ## Equality
///
/// Two ability scores are considered equal if they have the same [ability] and
/// [score].
@immutable
final class AbilityScore {
  /// The minimum possible ability score a score can normally be.
  ///
  /// If an effect reduces a score to 0, that effect explains what happens.
  static const minScore = 1;

  /// The maximum possible ability score.
  static const maxScore = 30;

  /// Creates a new ability score.
  ///
  /// {@template faerun.AbilityScore:validScore}
  /// The [score] must be a positive integer between 1 and 30, inclusive;
  /// the range can be referenced for validation purposes using [minScore] and
  /// [maxScore].
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
  /// The [score] must be a positive integer between 1 and 30, inclusive:
  ///
  /// Score      | Meaning
  /// -----------|--------------------------------------------------------------
  /// 1          | This is the lowest a score can normally go. If an effect reduces a score to 0, that effect explains what happens.
  /// 2-9        | This represents a weak capability.
  /// 10-11      | This represents the human average.
  /// 12-19      | This represents a strong capability.
  /// 20         | This is the highest an adventurer’s score can go unless a feature says otherwise.
  /// 21-29      | This represents an extraordinary capability.
  /// 30         | This is the highest a score can go.
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
