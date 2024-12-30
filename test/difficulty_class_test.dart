import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('cannot be lower than 0', () {
    check(() => DifficultyClass(-1)).throws<RangeError>();
  });

  test('cannot be 0', () {
    check(() => DifficultyClass(0)).throws<RangeError>();
  });

  test('should be equivalent to itself', () {
    final dc = DifficultyClass(1);
    check(dc).isEquivalentTo(DifficultyClass(1));
  });

  test('has a string representation', () {
    final dc = DifficultyClass(10);
    check(dc).hasToString.equals('DifficultyClass(10)');
  });

  test('is ordered by value', () {
    final dcs = [
      DifficultyClass(11),
      DifficultyClass(10),
      DifficultyClass(18),
      DifficultyClass(14),
      DifficultyClass(16),
    ]..sort();

    check(dcs).deepEquals([
      DifficultyClass(10),
      DifficultyClass(11),
      DifficultyClass(14),
      DifficultyClass(16),
      DifficultyClass(18),
    ]);
  });
}
