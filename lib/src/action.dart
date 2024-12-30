/// @docImport 'package:faerun/src/ability.dart';
/// @docImport 'package:faerun/src/circumstance.dart';
/// @docImport 'package:faerun/src/condition.dart';
/// @docImport 'package:faerun/src/skill.dart';
library;

import 'package:meta/meta.dart';

/// Doing something other than moving or communicating.
///
/// [main] lists the game's main actions; more can be defined with [Action.new].
///
/// ## Equality
///
/// Actions are compared based on their [name].
@immutable
final class Action implements Comparable<Action> {
  /// Attack with a weapon or unarmed strike.
  static const attack = Action._('Attack');

  /// Grant extra movement equal to your speed for the rest of the turn.
  static const dash = Action._('Dash');

  /// Movement doesn't provoke opportunity attacks for the rest of the turn.
  static const disengage = Action._('Disengage');

  /// Until the start of your next turn, attacks against you have
  /// [Circumstance.disadvantage].
  ///
  /// [Ability.dexterity] savings throws are made with [Circumstance.advantage].
  /// You lose this benefit if you have [Condition.incapacitated] or if your
  /// speed drops to 0.
  static const dodge = Action._('Dodge');

  /// Help another creature's ability check or attack roll, or administer first
  /// aid.
  static const help = Action._('Help');

  /// Make a [Ability.dexterity] ([Skill.stealth]) check.
  static const hide = Action._('Hide');

  /// Make a [Ability.charisma] ([Skill.deception], [Skill.intimidation],
  /// [Skill.performance], or [Skill.persuasion]) or [Ability.wisdom]
  /// ([Skill.animalHandling]) check to alter a creature's attitude.
  static const influence = Action._('Influence');

  /// Cast a spell, use a magic item, or use a magical feature.
  static const magic = Action._('Magic');

  /// Prepare to take an action in response to a trigger you define.
  static const ready = Action._('Ready');

  /// Make a [Ability.wisdom] ([Skill.insight], [Skill.medicine],
  /// [Skill.perception], or [Skill.survival]) check.
  static const search = Action._('Search');

  /// Make a [Ability.intelligence] ([Skill.arcana], [Skill.history],
  /// [Skill.investigation], [Skill.nature], or [Skill.religion]) check.
  static const study = Action._('Study');

  /// Use a non-magical item.
  static const utilize = Action._('Utilize');

  /// All main actions.
  static const main = [
    attack,
    dash,
    disengage,
    dodge,
    help,
    hide,
    influence,
    magic,
    ready,
    search,
    study,
    utilize,
  ];

  /// Creates a new action with the given [name].
  ///
  /// The name must be a non-empty string.
  factory Action(String name) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must be a non-empty');
    }
    return Action._(name);
  }

  const Action._(this.name);

  /// Name of the action.
  ///
  /// Must be a non-empty string.
  final String name;

  @override
  int compareTo(Action other) => name.compareTo(other.name);

  @override
  bool operator ==(Object other) => other is Action && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'Action($name)';
}
