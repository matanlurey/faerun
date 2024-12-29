import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('tryByName should return null for non-existent ability', () {
    final ability = Ability.tryByName('non-existent');
    check(ability).isNull();
  });

  group('tryByName should return the ability with the name', () {
    for (final ability in Ability.values) {
      test('for ${ability.name}', () {
        final result = Ability.tryByName(ability.name);
        check(result).equals(ability);
      });
    }
  });

  test('byName should throw for non-existent ability', () {
    check(() => Ability.byName('non-existent')).throws<ArgumentError>();
  });

  test('byName should return the ability with the name', () {
    for (final ability in Ability.values) {
      final result = Ability.byName(ability.name);
      check(result).equals(ability);
    }
  });

  test('tryByAbbreviation should return null for non-existent ability', () {
    final ability = Ability.tryByAbbreviation('non-existent');
    check(ability).isNull();
  });

  test('tryByAbbreviation should return the ability with the abbreviation', () {
    for (final ability in Ability.values) {
      final result = Ability.tryByAbbreviation(ability.abbreviation);
      check(result).equals(ability);
    }
  });

  test('byAbbreviation should throw for non-existent ability', () {
    check(() => Ability.byAbbreviation('non-existent')).throws<ArgumentError>();
  });

  test('byAbbreviation should return the ability with the abbreviation', () {
    for (final ability in Ability.values) {
      final result = Ability.byAbbreviation(ability.abbreviation);
      check(result).equals(ability);
    }
  });

  test('each abbreviation should be the first three letters of the name', () {
    for (final ability in Ability.values) {
      final abbreviation = ability.name.substring(0, 3).toLowerCase();
      check(ability.abbreviation).equals(abbreviation);
    }
  });

  test('each modifier should be computed as expected', () {
    final actual = {
      for (var i = 1; i <= 30; i++)
        i: AbilityScore(Ability.strength, i).modifier,
    };
    const expected = {
      1: -5,
      2: -4,
      3: -4,
      4: -3,
      5: -3,
      6: -2,
      7: -2,
      8: -1,
      9: -1,
      10: 0,
      11: 0,
      12: 1,
      13: 1,
      14: 2,
      15: 2,
      16: 3,
      17: 3,
      18: 4,
      19: 4,
      20: 5,
      21: 5,
      22: 6,
      23: 6,
      24: 7,
      25: 7,
      26: 8,
      27: 8,
      28: 9,
      29: 9,
      30: 10,
    };
    try {
      check(actual).deepEquals(expected);
      // TODO: Workaround https://github.com/dart-lang/test/pull/2442.
      // ignore: avoid_catching_errors
    } on TypeError catch (_) {
      fail('Expected: $expected\nActual: $actual');
    }
  });

  test('should be equal if they have the same ability and score', () {
    final a = AbilityScore(Ability.strength, 10);
    final b = AbilityScore(Ability.strength, 10);
    check(a).equivalentTo(b);
  });

  test('has a toString representation', () {
    final score = AbilityScore(Ability.strength, 10);
    check(score).hasToString.equals('AbilityScore(Ability.strength, 10)');
  });
}
