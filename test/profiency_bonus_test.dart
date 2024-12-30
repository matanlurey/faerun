import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('cannot be lower than 2', () {
    check(() => ProficiencyBonus(1)).throws<RangeError>();
  });

  test('cannot be higher than 9', () {
    check(() => ProficiencyBonus(10)).throws<RangeError>();
  });

  test('can be 2 to 9, inclusive', () {
    for (var i = 2; i <= 9; i++) {
      check(ProficiencyBonus(i)).has((a) => a.value, 'value').equals(i);
    }
  });

  test('should be equivalent to itself', () {
    final bonus = ProficiencyBonus(2);
    check(bonus).isEquivalentTo(ProficiencyBonus(2));
  });

  test('has a toString representation', () {
    final bonus = ProficiencyBonus(2);
    check(bonus).hasToString.equals('ProficiencyBonus(2)');
  });

  test('should be ordered by value', () {
    final bonuses = [
      ProficiencyBonus(4),
      ProficiencyBonus(2),
      ProficiencyBonus(5),
    ]..sort();

    check(bonuses).deepEquals([
      ProficiencyBonus(2),
      ProficiencyBonus(4),
      ProficiencyBonus(5),
    ]);
  });

  test('should convert from ChallengeRating', () {
    check({
      for (var i = 0; i <= 30; i++)
        ChallengeRating(i):
            ProficiencyBonus.fromChallengeRating(ChallengeRating(i)),
    }).deepEquals({
      ChallengeRating(0): ProficiencyBonus(2),
      ChallengeRating(1): ProficiencyBonus(2),
      ChallengeRating(2): ProficiencyBonus(2),
      ChallengeRating(3): ProficiencyBonus(2),
      ChallengeRating(4): ProficiencyBonus(2),
      ChallengeRating(5): ProficiencyBonus(3),
      ChallengeRating(6): ProficiencyBonus(3),
      ChallengeRating(7): ProficiencyBonus(3),
      ChallengeRating(8): ProficiencyBonus(3),
      ChallengeRating(9): ProficiencyBonus(4),
      ChallengeRating(10): ProficiencyBonus(4),
      ChallengeRating(11): ProficiencyBonus(4),
      ChallengeRating(12): ProficiencyBonus(4),
      ChallengeRating(13): ProficiencyBonus(5),
      ChallengeRating(14): ProficiencyBonus(5),
      ChallengeRating(15): ProficiencyBonus(5),
      ChallengeRating(16): ProficiencyBonus(5),
      ChallengeRating(17): ProficiencyBonus(6),
      ChallengeRating(18): ProficiencyBonus(6),
      ChallengeRating(19): ProficiencyBonus(6),
      ChallengeRating(20): ProficiencyBonus(6),
      ChallengeRating(21): ProficiencyBonus(7),
      ChallengeRating(22): ProficiencyBonus(7),
      ChallengeRating(23): ProficiencyBonus(7),
      ChallengeRating(24): ProficiencyBonus(7),
      ChallengeRating(25): ProficiencyBonus(8),
      ChallengeRating(26): ProficiencyBonus(8),
      ChallengeRating(27): ProficiencyBonus(8),
      ChallengeRating(28): ProficiencyBonus(8),
      ChallengeRating(29): ProficiencyBonus(9),
      ChallengeRating(30): ProficiencyBonus(9),
    });
  });
}
