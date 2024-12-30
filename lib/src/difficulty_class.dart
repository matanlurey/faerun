import 'package:faerun/src/armor_class.dart';
import 'package:meta/meta.dart';
import 'package:quirk/quirk.dart';

/// The difficulty class of a task.
///
/// A difficulty class encapsulates the difficulty of a task and provides a
/// guaranteed valid range of values.
///
/// Examples of common difficulty classes are:
///
/// Task Difficulty   | DC
/// ------------------|---------------------------------------------------------
/// Very Easy         | 5
/// Easy              | 10
/// Medium            | 15
/// Hard              | 20
/// Very Hard         | 25
/// Nearly Impossible | 30
///
/// ## Equality
///
/// Two difficulty classes are considered equal if their values are equal.
///
/// ## Comparison
///
/// Difficulty classes are ordered by lowest to highest value.
@immutable
final class DifficultyClass implements Comparable<DifficultyClass> {
  /// Creates a new difficulty class.
  ///
  /// The [value] must be a positive integer.
  factory DifficultyClass(int value) {
    return DifficultyClass._(checkPositive(value, 'value'));
  }

  /// Creates a new difficulty class from an armor class.
  factory DifficultyClass.fromArmorClass(ArmorClass armorClass) {
    return DifficultyClass(armorClass.value);
  }

  const DifficultyClass._(this.value);

  /// The value of the difficulty class.
  ///
  /// Must be a positive integer.
  final int value;

  @override
  int compareTo(DifficultyClass other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(Object other) {
    return other is DifficultyClass && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'DifficultyClass($value)';
}
