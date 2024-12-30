import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('ordered based on name', () {
    final skills = [
      Skill.perception,
      Skill.insight,
      Skill.arcana,
    ]..sort();

    check(skills).deepEquals([
      Skill.arcana,
      Skill.insight,
      Skill.perception,
    ]);
  });
}
