import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('tryBySides should return null for non-existent dice', () {
    final dice = Dice.tryBySides(1);
    check(dice).isNull();
  });

  test('tryBySides should return the dice with the sides', () {
    for (final dice in Dice.values) {
      final result = Dice.tryBySides(dice.sides);
      check(result).equals(dice);
    }
  });

  test('bySides should throw for non-existent dice', () {
    check(() => Dice.bySides(1)).throws<ArgumentError>();
  });

  test('bySides should return the dice with the sides', () {
    for (final dice in Dice.values) {
      final result = Dice.bySides(dice.sides);
      check(result).equals(dice);
    }
  });

  group('DiceNotation', () {
    test('should reject an amount of 0', () {
      check(() => DiceNotation(Dice.d6, amount: 0)).throws<RangeError>();
    });

    test('should reject a negative amount', () {
      check(() => DiceNotation(Dice.d6, amount: -1)).throws<RangeError>();
    });

    test('should be equivalent to itself', () {
      final notation = DiceNotation(Dice.d6, amount: 2, modifier: 3);
      check(notation).equivalentTo(
        DiceNotation(
          Dice.d6,
          amount: 2,
          modifier: 3,
        ),
      );
    });

    test('should be represented in toString with a modifier', () {
      final notation = DiceNotation(Dice.d6, amount: 2, modifier: 3);
      check(notation).hasToString.equals('2d6 + 3');
    });

    test('should be represented in toString without a modifier', () {
      final notation = DiceNotation(Dice.d6, amount: 2);
      check(notation).hasToString.equals('2d6');
    });

    group('parse', () {
      test('should parse a simple dice notation', () {
        final notation = DiceNotation.parse('d6');
        check(notation).equals(DiceNotation(Dice.d6, amount: 1));
      });

      test('should parse a dice notation with an amount', () {
        final notation = DiceNotation.parse('2d6');
        check(notation).equals(DiceNotation(Dice.d6, amount: 2));
      });

      test('should parse a dice notation with a positive modifier', () {
        final notation = DiceNotation.parse('2d6 + 3');
        check(notation).equals(DiceNotation(Dice.d6, amount: 2, modifier: 3));
      });

      test('should parse a dice notation with a negative modifier', () {
        final notation = DiceNotation.parse('2d6 - 3');
        check(notation).equals(DiceNotation(Dice.d6, amount: 2, modifier: -3));
      });

      test('should reject a dice notation with a zero amount', () {
        check(() => DiceNotation.parse('0d6')).throws<RangeError>();
      });

      test('should reject a dice notation with a negative amount', () {
        check(() => DiceNotation.parse('-2d6')).throws<FormatException>();
      });
    });
  });

  test('Dice * n should return a DiceNotation', () {
    final dice = Dice.d6 * 2;
    check(dice).equals(DiceNotation(Dice.d6, amount: 2));
  });

  test('Dice + n should return a DiceNotation', () {
    final dice = Dice.d6 + 3;
    check(dice).equals(DiceNotation(Dice.d6, amount: 1, modifier: 3));
  });

  test('DiceModifier + n should return a new DiceNotation', () {
    final notation = DiceNotation(Dice.d6, amount: 2);
    check(notation + 3).equals(DiceNotation(Dice.d6, amount: 2, modifier: 3));
  });

  test('DiceModifier - n should return a new DiceNotation', () {
    final notation = DiceNotation(Dice.d6, amount: 2);
    check(notation - 3).equals(DiceNotation(Dice.d6, amount: 2, modifier: -3));
  });
}
