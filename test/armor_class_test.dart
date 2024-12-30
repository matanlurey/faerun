import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('value must be positive', () {
    check(() => ArmorClass(-1)).throws<RangeError>();
    check(() => ArmorClass(0)).throws<RangeError>();
  });

  test('is equivalent to itself', () {
    final ac = ArmorClass(10);
    check(ac).isEquivalentTo(ArmorClass(10));
  });

  test('is ordered by value', () {
    final acs = [
      ArmorClass(11),
      ArmorClass(10),
      ArmorClass(18),
      ArmorClass(14),
      ArmorClass(16),
    ]..sort();

    check(acs).deepEquals([
      ArmorClass(10),
      ArmorClass(11),
      ArmorClass(14),
      ArmorClass(16),
      ArmorClass(18),
    ]);
  });

  test('has a string representation', () {
    final ac = ArmorClass(10);
    check(ac).hasToString.equals('ArmorClass(10)');
  });

  test('converts to a DifficultyClass', () {
    final ac = ArmorClass(10);
    final dc = ac.toDifficultyClass();
    check(dc).isEquivalentTo(DifficultyClass(10));
  });
}
