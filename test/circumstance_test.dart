import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('advantage picks the higher of two numbers', () {
    check(Circumstance.advantage.pick(1, 2)).equals(2);
  });

  test('disadvantage picks the lower of two numbers', () {
    check(Circumstance.disadvantage.pick(1, 2)).equals(1);
  });

  test('combine returns null for an empty list', () {
    check(Circumstance.combine([])).isNull();
  });

  test('combine returns advantage for a list with only advantage', () {
    check(
      Circumstance.combine([Circumstance.advantage]),
    ).equals(Circumstance.advantage);
  });

  test('combine returns disadvantage for a list with only disadvantage', () {
    check(
      Circumstance.combine([Circumstance.disadvantage]),
    ).equals(Circumstance.disadvantage);
  });

  test('combine returns null for a list with both ', () {
    check(
      Circumstance.combine([Circumstance.advantage, Circumstance.disadvantage]),
    ).isNull();
  });
}
