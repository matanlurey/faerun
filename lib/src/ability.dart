import 'package:collection/collection.dart';
import 'package:faerun/faerun.dart';
import 'package:faerun/src/skill.dart';

/// Abilities that measure physical and mental characteristics.
///
/// For example, [strength] measures physical might:
///
/// ```dart
/// final ability = Ability.strength;
/// ```
///
/// For display and serialization purposes, each ability has a unique [name]
/// and three-letter [abbreviation]. The name is the same as the enum value, and
/// the abbreviation is the first three letters of the name in lowercase. Use
/// [byName] and [byAbbreviation] to look up abilities by name or abbreviation.
///
/// Tools can optionally provide additional information about each ability:
/// - [description] describes what the ability measures or its purpose;
/// - [checkExample] provides an example of using the ability for a check;
/// - [savingThrowExample] provides an example of using the ability for a saving
///   throw.
///
/// ... or provide their own interpretation of the abilities:
///
/// ```dart
/// extension AbilityExtensions on Ability {
///   String get customText {
///     return switch (this) {
///       Ability.strength => 'Be big and strong',
///       Ability.dexterity => 'Be quick and nimble',
///       Ability.constitution => 'Be tough and healthy',
///       Ability.intelligence => 'Be smart and knowledgeable',
///       Ability.wisdom => 'Be wise and perceptive',
///       Ability.charisma => 'Be charming and confident',
///     };
///   }
/// }
/// ```
///
/// ## Comparison
///
/// Abilities are ordered based on their enum value, with [strength] being the
/// lowest and [charisma] being the highest.
///
/// ## Example
///
/// To get the name and abbreviation of an ability:
///
/// ```dart
/// final ability = Ability.strength;
/// print(ability.name); // 'strength'
/// print(ability.abbreviation); // 'str'
/// ```
///
/// To get english textual descriptions and examples of using an ability:
///
/// ```dart
/// final ability = Ability.strength;
/// print(ability.measures); // 'Physical might'
/// print(ability.checkExample); // 'Lift, push, pull, or break something'
/// print(ability.savingThrowExample); // 'Physically resist direct force'
/// ```
///
/// To look up an ability by name or abbreviation:
///
/// ```dart
/// final a = Ability.byName('strength');
/// print(a); // 'Ability.strength'
///
/// final b = Ability.byAbbreviation('str');
/// print(b); // 'Ability.strength'
/// ```
enum Ability implements Comparable<Ability> {
  /// Physical might.
  strength(
    description: 'Physical might',
    checkExample: 'Lift, push, pull, or break something',
    savingThrowExample: 'Physically resist direct force',
  ),

  /// Agility, reflexes, and balance.
  dexterity(
    description: 'Agility, reflexes, and balance',
    checkExample: 'Move nimbly, quickly, or quietly',
    savingThrowExample: 'Dodge out of harm’s way',
  ),

  /// Health and stamina.
  constitution(
    description: 'Health and stamina',
    checkExample: 'Push your body beyond normal limits',
    savingThrowExample: 'Endure a toxic hazard',
  ),

  /// Reasoning and memory.
  intelligence(
    description: 'Reasoning and memory',
    checkExample: 'Reason or remember',
    savingThrowExample: 'Recognize an illusion as fake',
  ),

  /// Perceptiveness and mental fortitude.
  wisdom(
    description: 'Perceptiveness and mental fortitude',
    checkExample: 'Notice things in the environment or in creatures’ behavior',
    savingThrowExample: 'Resist a mental assault',
  ),

  /// Confidence, poise, and charm.
  charisma(
    description: 'Confidence, poise, and charm',
    checkExample: 'Influence, entertain, or deceive',
    savingThrowExample: 'Assert your identity',
  );

  const Ability({
    required this.description,
    required this.checkExample,
    required this.savingThrowExample,
  });

  /// Returns the ability with the exact [name], or `null` if none exists.
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [byName] instead.
  static Ability? tryByName(String name) {
    return values.firstWhereOrNull((ability) => ability.name == name);
  }

  /// Returns the ability with the given [name].
  ///
  /// [name] must be the exact name of an ability, such as `'strength'` or
  /// `'charisma'`, or an error is thrown.
  ///
  /// If you are unsure whether the name is valid, such as when the name comes
  /// from user input or an external source, use [tryByName] instead which
  /// returns `null` if the name is invalid.
  static Ability byName(String name) {
    final result = tryByName(name);
    if (result == null) {
      throw ArgumentError.value(name, 'name', 'not a valid ability name');
    }
    return result;
  }

  /// Returns the ability with the given [abbreviation], which must exist.
  ///
  /// [abbreviation] must be the three-letter abbreviation of an ability, such
  /// as `'str'` or `'cha'`, or an error is thrown.
  ///
  /// If you are unsure whether the abbreviation is valid, such as when the
  /// abbreviation comes from user input or an external source, use
  /// [tryByAbbreviation] instead which returns `null` if the abbreviation is
  /// invalid.
  static Ability byAbbreviation(String abbreviation) {
    final result = tryByAbbreviation(abbreviation);
    if (result == null) {
      throw ArgumentError.value(
        abbreviation,
        'abbreviation',
        'not a valid ability abbreviation',
      );
    }
    return result;
  }

  /// Returns the ability with the given [abbreviation], or `null` if none
  /// exists.
  ///
  /// This method is intended to be used with unvalidated input, such as user
  /// input or data from an external source. If you know the input is valid,
  /// consider using [byAbbreviation] instead.
  static Ability? tryByAbbreviation(String abbreviation) {
    return values.firstWhereOrNull(
      (ability) => ability.abbreviation == abbreviation,
    );
  }

  /// A description of what the ability measures, or its purpose.
  final String description;

  /// A description of what an ability check might use this ability for.
  final String checkExample;

  /// A description of what a savings throw might use this ability for.
  final String savingThrowExample;

  /// Three-letter abbreviation of the ability.
  ///
  /// For example, `Ability.strength.abbreviation` returns `'str'`.
  String get abbreviation => name.substring(0, 3);

  /// Skill checks that use this ability.
  Iterable<Skill> get skills {
    return Skill.values.where((skill) => skill.ability == this);
  }

  @override
  int compareTo(Ability other) => index.compareTo(other.index);
}
