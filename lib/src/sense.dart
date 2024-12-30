import 'package:faerun/src/effect.dart';
import 'package:meta/meta.dart';

/// Special senses that help creatures perceive things in certain situations.
///
/// Some built-in senses are:
///
/// - [blindsight]
/// - [darkvision]
/// - [tremorsense]
/// - [truesight]
///
/// ## Equality
///
/// Senses are equal if their names are equal.
///
/// ## Comparison
///
/// Senses are compared by their names.
@immutable
final class Sense implements Comparable<Sense> {
  /// See within a specific range without relying on physical sight
  static const blindsight = Sense._(
    'Blindsight',
    [
      Effect.constant(
        'Sense:Blindsight:Ignores Partial Cover',
        'Ignores Partial Cover',
        'You can see anything that isn’t behind Total Cover even if you have the Blinded condition or are in Darkness within the Blindsight range.',
      ),
      Effect.constant(
        'Sense:Blindsight:Perceives Invisible Creatures',
        'Perceives Invisible Creatures',
        'You can see Invisible creatures and objects within the Blindsight range.',
      ),
    ],
  );

  /// See better in non-bright light.
  static const darkvision = Sense._(
    'Darkvision',
    [
      Effect.constant(
        'Sense:Darkvision:Sees Dim Light As Bright',
        'Sees Dim Light As Bright',
        'You can see in Dim Light within the Darkvision range as if it were Bright Light.',
      ),
      Effect.constant(
        'Sense:Darkvision:Sees Darkness As Dim Light',
        'Sees Darkness As Dim Light',
        'You can see in Darkness within the Darkvision range as if it were Dim Light, but discern color only as shades of gray.',
      ),
    ],
  );

  /// Can pinpoint the location of creatures and moving objects.
  static const tremorsense = Sense._(
    'Tremorsense',
    [
      Effect.constant(
        'Sense:Tremorsense:Perceives Vibrations',
        'Perceives Vibrations',
        'You can perceive the location of creatures and objects within the Tremorsense range that are in contact with the ground or samed liquid.',
      ),
    ],
  );

  /// See in normal and magical darkness.
  static const truesight = Sense._(
    'Truesight',
    [
      Effect.constant(
        'Sense:Truesight:Sees In Darkness',
        'Sees In Darkness',
        'You can see in Darkness, both magical and nonmagical, within the Truesight range.',
      ),
      Effect.constant(
        'Sense:Truesight:Perceives Invisible Creatures',
        'Perceives Invisible Creatures',
        'You can see Invisible creatures and objects within the Truesight range.',
      ),
      Effect.constant(
        'Sense:Truesight:Visual Illusions',
        'Visual Illusions',
        'Visual illusions appear transparent to you, and you automatically succeed on saving throws against them.',
      ),
      Effect.constant(
        'Sense:Truesight:Transformations',
        'Transformations',
        'You discern the true form of any creature or object you see that has been transformed by magic.',
      ),
      Effect.constant(
        'Sense:Truesight:Ethereal Plane',
        'Ethereal Plane',
        'You can see into the Ethereal Plane within the Truesight range.',
      ),
    ],
  );

  /// Creates a new sense with the given name and effects.
  factory Sense(String name, Iterable<Effect> effects) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must be non-empty.');
    }
    return Sense._(name, List.unmodifiable(effects));
  }

  const Sense._(this.name, this.effects);

  /// Effects that are associated with this condition.
  final List<Effect> effects;

  /// Name of the sense.
  ///
  /// Must be a non-empty string.
  final String name;

  @override
  int compareTo(Sense other) => name.compareTo(other.name);

  @override
  bool operator ==(Object other) => other is Sense && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'Sense<$name>';
}
