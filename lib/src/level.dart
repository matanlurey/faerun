import 'package:faerun/src/proficiency_bonus.dart';
import 'package:meta/meta.dart';

/// A level of a player character.
///
/// A level encapsulates the experience and training of a player character,
/// a guaranteed valid range of values, as well as a [proficiencyBonus] that can
/// be used to calculate bonuses when an ability check should include the
/// character's proficiency bonus.
///
/// ## Equality
///
/// Two levels are considered equal if their values are equal.
///
/// ## Comparison
///
/// Levels are ordered by lowest to highest value.
@immutable
final class Level implements Comparable<Level> {
  /// The minimum level a player character can be.
  static const minValue = 1;

  /// The maximum level a player character can be.
  static const maxLevel = 20;

  /// Creates a new level.
  ///
  /// The [value] must be a positive integer between 1 and 20, inclusive.
  factory Level(int value) {
    RangeError.checkValueInInterval(value, 1, 20, 'value');
    return Level._(value);
  }

  const Level._(this.value);

  /// The value of the level.
  ///
  /// Must be a positive integer between 1 and 20, inclusive.
  final int value;

  /// Whether the level is the maximum level.
  bool get isMaxLevel => value == maxLevel;

  /// Returns the next level.
  ///
  /// The current level must not be the maximum level.
  Level toNextLevel() {
    if (isMaxLevel) {
      throw StateError('Cannot get the next level from the maximum level');
    }
    return Level(value + 1);
  }

  /// The proficiency bonus for the level.
  ProficiencyBonus get proficiencyBonus {
    return ProficiencyBonus.fromLevel(this);
  }

  @override
  int compareTo(Level other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(Object other) {
    return other is Level && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Level($value)';
}
