/// Obstacles can make a target more difficult to harm.
///
/// A target can benefit from cover only when an attack or other effect
/// originates on the opposite side of the cover.
///
/// ## Comparison
///
/// Ordered by least to most cover.
enum Cover implements Comparable<Cover> {
  ///  A target has half cover if an obstacle blocks at least half of its body.
  half(
    bonusToACAndDexteritySavingThrows: 2,
    exampleWhenApplied:
        'The obstacle might be a low wall, a large piece of furniture, a narrow tree trunk, or a creature, whether that creature is an enemy or a friend.',
  ),

  /// A target has three-quarters cover if about three-quarters of it is covered by an obstacle.
  threeQuarters(
    bonusToACAndDexteritySavingThrows: 5,
    exampleWhenApplied:
        'The obstacle might be a portcullis, an arrow slit, or a thick tree trunk.',
  ),

  /// A target has total cover if it is completely concealed by an obstacle.
  total(
    bonusToACAndDexteritySavingThrows: null,
    exampleWhenApplied: 'A target in a completely enclosed space.',
  );

  const Cover({
    required this.bonusToACAndDexteritySavingThrows,
    required this.exampleWhenApplied,
  });

  /// Amount of bonus to Armor Class and Dexterity saving throws.
  ///
  /// If `null`, the target cannot be targeted directly by an attack or spell.
  final int? bonusToACAndDexteritySavingThrows;

  /// Example of when the cover is applied.
  final String exampleWhenApplied;

  @override
  int compareTo(Cover other) => index.compareTo(other.index);
}
