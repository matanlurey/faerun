import 'package:collection/collection.dart';
import 'package:faerun/src/dice_notation.dart';

/// Dice add randomness to the game and determine the outcome of many actions.
///
/// For display and serialization purposes, each die has a unique [name] and
/// number of [sides]. The name is the same as the enum value, and the number
/// of sides is the same as the enum value. Use [byName] and [bySides] to
/// look up dice by name or number of sides.
///
/// ## Comparison
///
/// Dice are ordered based on their number of sides, with [d3] being the lowest
/// and [d100] being the highest.
enum Dice implements Comparable<Dice> {
  /// A 3-sided die.
  d3(3),

  /// A 4-sided die.
  d4(4),

  /// A 6-sided die.
  d6(6),

  /// An 8-sided die.
  d8(8),

  /// A 10-sided die.
  d10(10),

  /// A 12-sided die.
  d12(12),

  /// A 20-sided die.
  d20(20),

  /// A 100-sided die.
  d100(100);

  const Dice(this.sides);

  /// Returns the dice with the given number of [sides], if it exists.
  ///
  /// If no dice with the given number of sides exists, `null` is returned.
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [bySides] instead.
  static Dice? tryBySides(int sides) {
    return values.firstWhereOrNull((die) => die.sides == sides);
  }

  /// Returns the dice with the given number of [sides].
  ///
  /// If you are unsure whether a die with the given number of sides exists,
  /// consider using [tryBySides] instead which returns `null` if the die does
  /// not exist.
  static Dice bySides(int sides) {
    final result = tryBySides(sides);
    if (result == null) {
      throw ArgumentError.value(sides, 'sides', 'not a valid number of sides');
    }
    return result;
  }

  /// Returns the dice with the given [name], if it exists.
  ///
  /// If no dice with the given name exists, `null` is returned.
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [byName] instead.
  static Dice? tryByName(String name) {
    return values.firstWhereOrNull((die) => die.name == name);
  }

  /// Returns the dice with the given [name].
  ///
  /// If you are unsure whether a die with the given name exists, consider using
  /// [tryByName] instead which returns `null` if the die does not exist.
  static Dice byName(String name) {
    final result = tryByName(name);
    if (result == null) {
      throw ArgumentError.value(name, 'name', 'not a valid die name');
    }
    return result;
  }

  /// The number of sides on the die.
  final int sides;

  @override
  int compareTo(Dice other) => sides.compareTo(other.sides);

  /// Creates a dice notation of [amount] dice with this die and no modifier.
  ///
  /// This method is equivalent to `DiceNotation(this, amount: amount)`.
  DiceNotation operator *(int amount) {
    return DiceNotation(this, amount: amount);
  }

  /// Creates a dice notation of one die with this die and the given [modifier].
  ///
  /// This method is equivalent to `DiceNotation(this, amount: 1, modifier: modifier)`.
  DiceNotation operator +(int modifier) {
    return DiceNotation(this, amount: 1, modifier: modifier);
  }
}
