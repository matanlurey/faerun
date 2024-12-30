import 'package:faerun/src/difficulty_class.dart';
import 'package:faerun/src/example.dart';
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
/// ## Example
///
/// Built-in [substanceExamples] are provided for objects with an inherent AC.
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
  /// An example list of armor classes for object substances.
  ///
  /// This list is unmodifiable.
  static const substanceExamples = [
    Example(ArmorClass._(11), 'Cloth, paper, rope'),
    Example(ArmorClass._(13), 'Crystal, glass, ice'),
    Example(ArmorClass._(15), 'Wood'),
    Example(ArmorClass._(17), 'Stone'),
    Example(ArmorClass._(19), 'Iron, steel'),
    Example(ArmorClass._(21), 'Mithral'),
    Example(ArmorClass._(23), 'Adamanatine'),
  ];

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
