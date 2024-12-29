import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('cannot be lower than 0', () {
    check(() => ChallengeRating(-1)).throws<RangeError>();
  });

  test('can be 0', () {
    check(ChallengeRating(0)).has((a) => a.value, 'value').equals(0);
  });

  test('can be fractional', () {
    final rating = ChallengeRating(1, 4);
    check(rating).has((a) => a.value, 'value').equals(0.25);
  });

  test('fraction must be valid', () {
    check(() => ChallengeRating(1, 0)).throws<RangeError>();
  });

  test('should be equivalent to itself', () {
    final rating = ChallengeRating(1);
    check(rating).equivalentTo(ChallengeRating(1));
  });

  test('has a toString representation', () {
    final rating = ChallengeRating(1);
    check(rating).hasToString.equals('ChallengeRating(1)');
  });

  test('should be ordered by value', () {
    final ratings = [
      ChallengeRating(1),
      ChallengeRating(1, 4),
      ChallengeRating(1, 2),
    ]..sort();

    check(ratings).deepEquals([
      ChallengeRating(1, 4),
      ChallengeRating(1, 2),
      ChallengeRating(1),
    ]);
  });
}
