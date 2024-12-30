import 'package:faerun/src/ability.dart';
import 'package:meta/meta.dart';

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
