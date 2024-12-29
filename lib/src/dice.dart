import 'package:faerun/src/internal.dart';
import 'package:meta/meta.dart';

/// Dice add randomness to the game and determine the outcome of many actions.
enum Dice {
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
  static Dice? tryBySides(int sides) {
    return values.firstWhereOrNull((die) => die.sides == sides);
  }

  /// Returns the dice with the given number of [sides].
  static Dice bySides(int sides) {
    final result = tryBySides(sides);
    if (result == null) {
      throw ArgumentError.value(sides, 'sides', 'not a valid number of sides');
    }
    return result;
  }

  /// The number of sides on the die.
  final int sides;

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

/// A notation for dice expressions.
///
/// Dice expressions are strings that represent a combination of dice rolls and
/// arithmetic operations.
///
/// For example, `2d6 + 3` represents the sum of rolling two 6-sided dice and
/// adding 3, and can be represented as:
///
/// - `2 * Dice.d6 + 3`
/// - `DiceNotation(Dice.d6, amount: 2, modifier: 3)`
/// - `DiceNotation.parse('2d6 + 3')`
///
/// ## Equality
///
/// Two dice notations are considered equal if they have the same [dice],
/// [amount], and [modifier].
@immutable
final class DiceNotation {
  /// Creates a new dice notation.
  ///
  /// The [amount] must be a positive integer.
  ///
  /// The [modifier] is optional and defaults to 0.
  factory DiceNotation(
    Dice dice, {
    required int amount,
    int modifier = 0,
  }) {
    return DiceNotation._(
      dice,
      amount: checkPositive(amount, 'amount'),
      modifier: modifier,
    );
  }

  /// Parses a dice notation from a string, which must be a valid dice notation.
  ///
  /// {@macro faerun.DiceNotation:validNotation}
  factory DiceNotation.parse(String input) {
    final result = tryParse(input);
    if (result == null) {
      throw FormatException('not a valid dice notation', input);
    }
    return result;
  }

  /// Parses a dice notation from a string.
  ///
  /// If the string is not a valid dice notation, `null` is returned.
  ///
  /// {@template faerun.DiceNotation:validNotation}
  /// A valid dice notation is a string that matches the following pattern:
  /// - An optional positive integer followed by the letter 'd'
  /// - A positive integer that represents a valid [Dice] value
  /// - An optional modifier that is either '+' or '-' followed by a positive
  ///   integer
  ///
  /// ```dart
  /// // OK
  /// DiceNotation.parse('d6');
  ///
  /// // Also OK
  /// DiceNotation.parse('2d6');
  ///
  /// // Also OK
  /// DiceNotation.parse('2d6 + 3');
  /// ```
  ///
  /// Spaces are allowed, and otherwise ignored, between each token:
  ///
  /// ```dart
  /// // OK
  /// DiceNotation.parse('2d6 + 3');
  ///
  /// // Also OK
  /// DiceNotation.parse(' 2d6 +        3 ');
  ///
  /// // Not OK
  /// DiceNotation.parse('2d 6+3');
  /// ```
  /// {@endtemplate}
  static DiceNotation? tryParse(String input) {
    final match = _pattern.firstMatch(input.trim());
    if (match == null) {
      return null;
    }

    final int amount;
    if (match.group(1)!.isEmpty) {
      amount = 1;
    } else {
      final parse = int.tryParse(match.group(1)!);
      if (parse == null) {
        return null;
      }
      amount = parse;
    }

    final Dice dice;
    {
      final parse = int.tryParse(match.group(2)!);
      if (parse == null) {
        return null;
      }
      dice = Dice.bySides(parse);
    }

    final int modifier;
    if (match.group(3) == null) {
      modifier = 0;
    } else {
      final sign = match.group(3)!;
      final parse = int.tryParse(match.group(4)!);
      if (parse == null) {
        return null;
      }
      modifier = sign == '+' ? parse : -parse;
    }

    return DiceNotation(dice, amount: amount, modifier: modifier);
  }

  static final _pattern = RegExp(r'^(\d*)d(\d+)(?:\s*([+-])\s*(\d+))?$');

  const DiceNotation._(
    this.dice, {
    required this.amount,
    required this.modifier,
  });

  /// Which dice to roll.
  final Dice dice;

  /// The number of dice to roll.
  ///
  /// Must be a positive integer.
  final int amount;

  /// A modifier to apply to the result.
  final int modifier;

  /// Creates a new dice notation with the modifier increased by [value].
  ///
  /// If [value] is negative, the modifier is decreased instead.
  DiceNotation operator +(int value) {
    return DiceNotation._(dice, amount: amount, modifier: modifier + value);
  }

  /// Creates a new dice notation with the modifier decreased by [value].
  ///
  /// If [value] is negative, the modifier is increased instead.
  DiceNotation operator -(int value) {
    return DiceNotation._(dice, amount: amount, modifier: modifier - value);
  }

  @override
  bool operator ==(Object other) {
    return other is DiceNotation &&
        dice == other.dice &&
        amount == other.amount &&
        modifier == other.modifier;
  }

  @override
  int get hashCode => Object.hash(dice, amount, modifier);

  @override
  String toString() {
    final suffix = switch (modifier) {
      0 => '',
      _ => modifier.isNegative ? ' - ${-modifier}' : ' + $modifier',
    };
    return '${amount}d${dice.sides}$suffix';
  }
}
