/// @docImport 'package:faerun/src/ability.dart';
/// @docImport 'package:faerun/src/circumstance.dart';
/// @docImport 'package:faerun/src/condition.dart';
/// @docImport 'package:faerun/src/skill.dart';
library;

/// Defines the ability to hinder vision in an area.
///
/// A lack of obscurity (or `null` for `Obscured?`) is considered normal vision.
///
/// ## Comparison
///
/// Ordered by least to most obscured.
enum Obscured implements Comparable<Obscured> {
  /// An area with dim light, patchy fog, or moderate foliage.
  ///
  /// Creatures have [Circumstance.disadvantage] on [Ability.wisdom]
  /// ([Skill.perception]) checks that rely on sight.
  lightly,

  /// An area with darkness, heavy fog, or dense foliage, which is opaque.
  ///
  /// You have [Condition.blinded] when trying to see something there.
  heavily;

  @override
  int compareTo(Obscured other) => index.compareTo(other.index);
}
