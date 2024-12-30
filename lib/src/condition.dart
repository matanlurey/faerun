import 'package:faerun/src/effect.dart';
import 'package:meta/meta.dart';

/// A condition that affects a creature's capabilities.
sealed class Condition implements Comparable<Condition> {
  /// The blinded condition.
  static const Condition blinded = _Condition.blinded;

  /// The charmed condition.
  static const Condition charmed = _Condition.charmed;

  /// The deafened condition.
  static const Condition deafened = _Condition.deafened;

  /// The exhausted condition.
  ///
  /// This condition when inspected defaults to a single level of exhaustion.
  static const Condition exhausted = Exhaustion._(1);

  /// The frightened condition.
  static const Condition frightened = _Condition.frightened;

  /// The grappled condition.
  static const Condition grappled = _Condition.grappled;

  /// The incapacitated condition.
  static const Condition incapacitated = _Condition.incapacitated;

  /// The invisible condition.
  static const Condition invisible = _Condition.invisible;

  /// The paralyzed condition.
  static const Condition paralyzed = _Condition.paralyzed;

  /// The petrified condition.
  static const Condition petrified = _Condition.petrified;

  /// The poisoned condition.
  static const Condition poisoned = _Condition.poisoned;

  /// The prone condition.
  static const Condition prone = _Condition.prone;

  /// The restrained condition.
  static const Condition restrained = _Condition.restrained;

  /// The stunned condition.
  static const Condition stunned = _Condition.stunned;

  /// The unconscious condition.
  static const Condition unconscious = _Condition.unconscious;

  /// List of conditions, including a single level of exhaustion.
  ///
  /// This list is unmodifiable.
  static const values = [
    blinded,
    charmed,
    deafened,
    exhausted,
    frightened,
    grappled,
    incapacitated,
    invisible,
    paralyzed,
    petrified,
    poisoned,
    prone,
    restrained,
    stunned,
    unconscious,
  ];

  /// Effects that are associated with this condition.
  List<Effect> get effects;

  /// Name of the condition.
  String get name;
}

enum _Condition implements Condition {
  blinded([
    Effect.constant(
      "Condition:Blinded:Can't See",
      "Can't See",
      "You can't see and automatically fail any ability check that requires sight.",
    ),
    Effect.constant(
      'Condition:Blinded:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage, and your attack rolls have Disadvantage.',
    ),
  ]),

  charmed([
    Effect.constant(
      "Condition:Charmed:Can't Harm the Charmer",
      "Can't Harm the Charmer",
      "You can't attack the charmer or target the charmer with damaging abilities or magical effects.",
    ),
    Effect.constant(
      'Condition:Charmed:Social Advantage',
      'Social Advantage',
      'The charmer has Advantage on any ability check to interact with you socially.',
    ),
  ]),

  deafened([
    Effect.constant(
      "Condition:Deafened:Can't Hear",
      "Can't Hear",
      "You can't hear and automatically fail any ability check that requires hearing.",
    ),
  ]),

  frightened([
    Effect.constant(
      'Condition:Frightened:Ability Checks and Attacks Affected',
      'Ability Checks and Attacks Affected',
      'You have Disadvantage on ability checks and attack rolls while the source of fear is within line of sight.',
    ),
    Effect.constant(
      "Condition:Frightened:Can't Approach",
      "Can't Move Closer",
      "You can't willingly move closer to the source of fear.",
    ),
  ]),

  grappled([
    Effect.constant(
      'Condition:Grappled:Speed 0',
      'Speed 0',
      "Your Speed is 0 and can't increase.",
    ),
    Effect.constant(
      'Condition:Grappled:Attacks Affected',
      'Attacks Affected',
      'You have Disadvantage on attack rolls against any target other than the grappler.',
    ),
    Effect.constant(
      'Condition:Grappled:Movable',
      'Movable',
      'The grappler can drag or carry you when it moves, but every foot of movement costs it 1 extra foot unless you are Tiny or two or more sizes smaller than it.',
    ),
  ]),

  incapacitated([
    Effect.constant(
      'Condition:Incapacitated:Inactive',
      'Inactive',
      "You can't take any action, Bonus Action, or Reaction.",
    ),
    Effect.constant(
      'Condition:Incapacitated:No Concentration',
      'No Concentration',
      'Your Concentration is broken.',
    ),
    Effect.constant(
      'Condition:Incapacitated:Speechless',
      'Speechless',
      "You can't speak.",
    ),
    Effect.constant(
      'Condition:Incapacitated:Surprised',
      'Surprised',
      "If you're Incapacitated when you roll Initiative, you have Disadvantage on the roll.",
    ),
  ]),

  invisible([
    Effect.constant(
      'Condition:Invisible:Surprise',
      'Surprise',
      "If you're Invisible when you roll Initiative, you have Advantage on the roll.",
    ),
    Effect.constant(
      'Condition:Invisible:Concealed',
      'Concealed',
      "You aren't affected by any effect that requires its target to be seen unless the effect's creator can somehow see you. Any equipment you are wearing or carrying is also concealed.",
    ),
    Effect.constant(
      'Condition:Invisible:Attacks Affected',
      'Attacks Affected',
      "Attack rolls against you have Disadvantage, and your attack rolls have Advantage. If a creature can somehow see you, you don't gain this benefit against that creature.",
    ),
  ]),

  paralyzed([
    Effect.constant(
      'Condition:Paralyzed:Incapacitated',
      'Incapacitated',
      'You have the Incapacitated condition.',
    ),
    Effect.constant(
      'Condition:Paralyzed:Speed 0',
      'Speed 0',
      "Your Speed is 0 and can't increase.",
    ),
    Effect.constant(
      'Condition:Paralyzed:Saving Throws Affected',
      'Saving Throws Affected',
      'You automatically fail Strength and Dexterity saving throws.',
    ),
    Effect.constant(
      'Condition:Paralyzed:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage.',
    ),
    Effect.constant(
      'Condition:Paralyzed:Automatic Critical Hits',
      'Automatic Critical Hits',
      'Any attack roll that hits you is a Critical Hit if the attacker is within 5 feet of you.',
    ),
  ]),

  petrified([
    Effect.constant(
      'Condition:Petrified:Turned to Inanimate Substance',
      'Turned to Inanimate Substance',
      'You are transformed, along with any nonmagical objects you are wearing and carrying, into a solid inanimate substance (usually stone). Your weight increases by a factor of ten, and you cease aging.',
    ),
    Effect.constant(
      'Condition:Petrified:Incapacitated',
      'Incapacitated',
      'You have the Incapacitated condition.',
    ),
    Effect.constant(
      'Condition:Petrified:Speed 0',
      'Speed 0',
      "Your Speed is 0 and can't increase.",
    ),
    Effect.constant(
      'Condition:Petrified:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage.',
    ),
    Effect.constant(
      'Condition:Petrified:Saving Throws Affected',
      'Saving Throws Affected',
      'You automatically fail Strength and Dexterity saving throws.',
    ),
    Effect.constant(
      'Condition:Petrified:Resist Damage',
      'Resist Damage',
      'You have Resistance to all damage.',
    ),
    Effect.constant(
      'Condition:Petrified:Poison Immunity',
      'Poison Immunity',
      'You have Immunity to the Poisoned condition.',
    ),
  ]),

  poisoned([
    Effect.constant(
      'Condition:Poisoned:Ability Checks and Attacks Affected',
      'Ability Checks and Attacks Affected',
      'You have Disadvantage on attack rolls and ability checks.',
    ),
  ]),

  prone([
    Effect.constant(
      'Condition:Prone:Restricted Movement',
      'Restricted Movement',
      "Your only movement options are to crawl or to spend an amount of movement equal to half your Speed (round down) to right yourself and thereby end the condition. If your Speed is 0, you can't right yourself.",
    ),
    Effect.constant(
      'Condition:Prone:Attacks Affected',
      'Attacks Affected',
      'You have Disadvantage on attack rolls. An attack roll against you has Advantage if the attacker is within 5 feet of you. Otherwise, that attack roll has Disadvantage.',
    ),
  ]),

  restrained([
    Effect.constant(
      'Condition:Restrained:Speed 0',
      'Speed 0',
      "Your Speed is 0 and can't increase.",
    ),
    Effect.constant(
      'Condition:Restrained:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage, and your attack rolls have Disadvantage.',
    ),
    Effect.constant(
      'Condition:Restrained:Saving Throws Affected',
      'Saving Throws Affected',
      'You have Disadvantage on Dexterity saving throws.',
    ),
  ]),

  stunned([
    Effect.constant(
      'Condition:Stunned:Incapacitated',
      'Incapacitated',
      'You have the Incapacitated condition.',
    ),
    Effect.constant(
      'Condition:Stunned:Saving Throws Affected',
      'Saving Throws Affected',
      'You automatically fail Strength and Dexterity saving throws.',
    ),
    Effect.constant(
      'Condition:Stunned:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage.',
    ),
  ]),

  unconscious([
    Effect.constant(
      'Condition:Unconscious:Inert',
      'Inert',
      "You have the Incapacitated and Prone conditions, and you drop whatever you're holding. When this condition ends, you remain Prone.",
    ),
    Effect.constant(
      'Condition:Unconscious:Speed 0',
      'Speed 0',
      "Your Speed is 0 and can't increase.",
    ),
    Effect.constant(
      'Condition:Unconscious:Attacks Affected',
      'Attacks Affected',
      'Attack rolls against you have Advantage.',
    ),
    Effect.constant(
      'Condition:Unconscious:Saving Throws Affected',
      'Saving Throws Affected',
      'You automatically fail Strength and Dexterity saving throws.',
    ),
    Effect.constant(
      'Condition:Unconscious:Automatic Critical Hits',
      'Automatic Critical Hits',
      'Any attack roll that hits you is a Critical Hit if the attacker is within 5 feet of you.',
    ),
    Effect.constant(
      'Condition:Unconscious:Unaware',
      'Unaware',
      "You're unaware of your surroundings.",
    ),
  ]);

  const _Condition(this.effects);

  @override
  String get name => EnumName(this).name;

  @override
  final List<Effect> effects;

  @override
  int compareTo(Condition other) => name.compareTo(other.name);
}

/// The exhaustion condition, which unlike other conditions, is cumulative.
///
/// Each time exhaustion is applied, the creature gains a level of exhaustion:
///
/// - You die if you reach level 6;
/// - When making a D20 test, the roll is reduced by 2 times your exhaustion;
/// - Your speed is reducedd by 5 feet per level of exhaustion.
///
/// Finishing a long rest reduces a creature's exhaustion level by 1.
@immutable
final class Exhaustion implements Condition {
  /// The minimum level of exhaustion.
  static const int minLevel = 1;

  /// The maximum level of exhaustion.
  static const int maxLevel = 5;

  /// Creates a new exhaustion condition.
  ///
  /// If [level] is omitted, the default level is 1.
  factory Exhaustion([int level = minLevel]) {
    return Exhaustion._(
      RangeError.checkValueInInterval(
        level,
        minLevel,
        maxLevel,
      ),
    );
  }

  const Exhaustion._(this.level);

  /// Level of exhaustion.
  ///
  /// Must be in the range 1 to 5.
  final int level;

  /// Returns a new exhaustion condition based on adding an additional level.
  ///
  /// If the level would exceed 5 (death), `null` is returned.
  Exhaustion? increase() {
    return level < 6 ? Exhaustion(level + 1) : null;
  }

  /// Returns a new exhaustion condition based on reducing the level by 1.
  ///
  /// If the level would be less than 1 (remove condition), `null` is returned.
  Exhaustion? reduce() {
    return level > 1 ? Exhaustion(level - 1) : null;
  }

  @override
  int compareTo(Condition other) {
    return switch (other) {
      Exhaustion(:final level) => this.level.compareTo(level),
      _ => name.compareTo(other.name),
    };
  }

  @override
  String get name => 'Exhaustion: $level';

  @override
  List<Effect> get effects {
    return const [
      Effect.constant(
        'Condition:Exhaustion:Exhaustion Levels',
        'This condition is cumulative. Each time you receive it, you gain 1 Exhaustion level. You die if your Exhaustion level is 6.',
        'You die if you reach level 6.',
      ),
      Effect.constant(
        'Condition:Exhaustion:D20 Tests Affected',
        'D20 Tests Affected',
        'When you make a D20 Test, the roll is reduced by 2 times your Exhaustion level.',
      ),
      Effect.constant(
        'Condition:Exhaustion:Speed Reduced',
        'Speed Reduced',
        'Your Speed is reduced by 5 feet per level of Exhaustion.',
      ),
      Effect.constant(
        'Condition:Exhaustion:Removing Exhaustion Levels',
        'Removing Exhaustion Levels',
        'Finishing a Long Rest removes 1 of your Exhaustion levels. When your Exhaustion level reaches 0, the condition ends.',
      ),
    ];
  }
}
