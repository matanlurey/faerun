import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('advantage picks the higher of two numbers', () {
    check(Circumstance.advantage.pick(1, 2)).equals(2);
  });

  test('disadvantage picks the lower of two numbers', () {
    check(Circumstance.disadvantage.pick(1, 2)).equals(1);
  });
}
