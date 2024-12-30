/// @docImport 'package:faerun/src/proficiency_bonus.dart';
library;

import 'package:faerun/src/ability.dart';

/// A category of things a creature or character might do with an ability check.
///
/// If a creature is proficient in a skill, it adds its [ProficiencyBonus] to
/// the ability check.
///
/// ## Comparison
///
/// Skills are ordered by their name.
enum Skill implements Comparable<Skill> {
  /// Stay on your feet in a tricky situation, or perform an acrobatic stunt.
  acrobatics(
    ability: Ability.dexterity,
    checkExample:
        'Stay on your feet in a tricky situation, or perform an acrobatic '
        'stunt.',
  ),

  /// Calm or train an animal, or get an animal to behave in a certain way.
  animalHandling(
    ability: Ability.wisdom,
    checkExample:
        'Calm or train an animal, or get an animal to behave in a certain way.',
  ),

  /// Recall lore about spells, magic items, and the planes of existence.
  arcana(
    ability: Ability.intelligence,
    checkExample:
        'Recall lore about spells, magic items, and the planes of existence.',
  ),

  /// Jump farther than normal, stay afloat in rough water, or break something.
  athletics(
    ability: Ability.strength,
    checkExample:
        'Jump farther than normal, stay afloat in rough water, or break '
        'something.',
  ),

  /// Tell a convincing lie, or wear a disguise convincingly.
  deception(
    ability: Ability.charisma,
    checkExample: 'Tell a convincing lie, or wear a disguise convincingly.',
  ),

  /// Recall lore about historical events, people, nations, and cultures.
  history(
    ability: Ability.intelligence,
    checkExample:
        'Recall lore about historical events, people, nations, and cultures.',
  ),

  /// Discern a person’s mood and intentions.
  insight(
    ability: Ability.wisdom,
    checkExample: 'Discern a person’s mood and intentions.',
  ),

  /// Awe or threaten someone into doing what you want.
  intimidation(
    ability: Ability.charisma,
    checkExample: 'Awe or threaten someone into doing what you want.',
  ),

  /// Find obscure information in books, or deduce how something works.
  investigation(
    ability: Ability.intelligence,
    checkExample:
        'Find obscure information in books, or deduce how something works.',
  ),

  /// Diagnose an illness, or determine what killed the recently slain.
  medicine(
    ability: Ability.wisdom,
    checkExample:
        'Diagnose an illness, or determine what killed the recently slain.',
  ),

  /// Recall lore about terrain, plants, animals, and weather.
  nature(
    ability: Ability.intelligence,
    checkExample: 'Recall lore about terrain, plants, animals, and weather.',
  ),

  /// Using a combination of senses, notice something that’s easy to miss.
  perception(
    ability: Ability.wisdom,
    checkExample:
        'Using a combination of senses, notice something that’s easy to miss.',
  ),

  /// Act, tell a story, perform music, or dance.
  performance(
    ability: Ability.charisma,
    checkExample: 'Act, tell a story, perform music, or dance.',
  ),

  /// Honestly and graciously convince someone of something.
  persuasion(
    ability: Ability.charisma,
    checkExample: 'Honestly and graciously convince someone of something.',
  ),

  /// Recall lore about gods, religious rituals, and holy symbols.
  religion(
    ability: Ability.intelligence,
    checkExample:
        'Recall lore about gods, religious rituals, and holy symbols.',
  ),

  /// Pick a pocket, conceal a handheld object, or perform legerdemain.
  sleightOfHand(
    ability: Ability.dexterity,
    checkExample:
        'Pick a pocket, conceal a handheld object, or perform legerdemain.',
  ),

  /// Escape notice by moving quietly and hiding behind things.
  stealth(
    ability: Ability.dexterity,
    checkExample: 'Escape notice by moving quietly and hiding behind things.',
  ),

  /// Follow tracks, forage, find a trail, or avoid natural hazards.
  survival(
    ability: Ability.wisdom,
    checkExample:
        'Follow tracks, forage, find a trail, or avoid natural hazards.',
  );

  const Skill({
    required this.ability,
    required this.checkExample,
  });

  /// Which base ability is used for the skill.
  final Ability ability;

  /// An example of a skill check that might use this skill.
  final String checkExample;

  @override
  int compareTo(Skill other) => index.compareTo(other.index);
}
