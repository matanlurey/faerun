import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('cannot be lower than 0', () {
    check(() => Level(-1)).throws<RangeError>();
  });

  test('cannot be 0', () {
    check(() => Level(0)).throws<RangeError>();
  });

  test('should be equivalent to itself', () {
    final level = Level(1);
    check(level).isEquivalentTo(Level(1));
  });

  test('has a string representation', () {
    final level = Level(10);
    check(level).hasToString.equals('Level(10)');
  });

  test('is ordered by value', () {
    final levels = [
      Level(11),
      Level(10),
      Level(18),
      Level(14),
      Level(16),
    ]..sort();

    check(levels).deepEquals([
      Level(10),
      Level(11),
      Level(14),
      Level(16),
      Level(18),
    ]);
  });

  test('returns proficiency bonus', () {
    final level = Level(1);
    check(level)
        .has((a) => a.proficiencyBonus, 'proficiencyBonus')
        .equals(ProficiencyBonus(2));
  });

  test('returns whether the maximum level has been reached', () {
    check(Level(20)).has((a) => a.isMaxLevel, 'isMaxLevel').isTrue();
  });

  test('returns the next level', () {
    final level = Level(1);
    check(level.toNextLevel()).equals(Level(2));
  });

  test('refuses to return the next level if it is the maximum level', () {
    final level = Level(20);
    check(level.toNextLevel).throws<StateError>();
  });
}
