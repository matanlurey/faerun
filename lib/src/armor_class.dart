import 'package:faerun/src/difficulty_class.dart';
import 'package:meta/meta.dart';
import 'package:quirk/quirk.dart';

/// How well a creature or character avoids being wounded in combat.
///
/// An armor class encapsulates a computed AC and provides a guaranteed valid
/// range of values.
///
/// The AC of a character is determined at character creation, whereas the AC
/// of a monster appears in its stat block. All creatures start with the same
/// base AC calculation (`10 + Dexterity modifier`), but can increase their AC
/// by armor, magic items, spells, and more.
///
/// Examples of common armor classes are:
///
/// Armor Type  | AC
/// ------------|---------------------------------------------------------------
/// Unarmored   | 10
/// Leather     | 11
/// Breastplate | 14
/// Chain Mail  | 16
/// Plate       | 18
/// Shield      | +2
///
/// # Equality
///
/// Two armor classes are considered equal if their values are equal.
///
/// # Comparison
///
/// Armor classes are ordered by lowest to highest value.
@immutable
final class ArmorClass implements Comparable<ArmorClass> {
  /// Creates a new armor class.
  ///
  /// The [value] must be a positive integer.
  factory ArmorClass(int value) {
    return ArmorClass._(checkPositive(value, 'value'));
  }

  const ArmorClass._(this.value);

  /// The value of the armor class.
  ///
  /// Must be a positive integer.
  final int value;

  @override
  int compareTo(ArmorClass other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(Object other) {
    return other is ArmorClass && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  /// Converts the armor class to a difficulty class.
  DifficultyClass toDifficultyClass() {
    return DifficultyClass.fromArmorClass(this);
  }

  @override
  String toString() => 'ArmorClass($value)';
}
