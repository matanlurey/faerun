import 'package:meta/meta.dart';

/// Reflects a temporary or permanent change in a creature's capabilities.
///
/// Each effect has a canonical [name] and an optional [description].
@immutable
final class Effect {
  /// Creates a new effect.
  factory Effect(String id, String name, [String? description]) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must not be empty');
    }
    return Effect._(id, name, description);
  }

  /// Creates a new effect from compile-time constants.
  ///
  /// This constructor is intended for use in constant expressions, such as
  /// defining default effects for an enum; in most cases the default
  /// constructor ([Effect.new]) should be used instead.
  const factory Effect.constant(
    @mustBeConst String id,
    @mustBeConst String name, [
    @mustBeConst String? description,
  ]) = Effect._;

  const Effect._(
    this.id,
    this.name, [
    this.description,
  ])  : assert(id.length > 0, 'id must not be empty'),
        assert(name.length > 0, 'name must not be empty');

  /// Unique string identifier for the effect.
  ///
  /// This field should be reserved for persistence purposes.
  ///
  /// Must be non-empty.
  final String id;

  /// Name of the effect.
  ///
  /// Must be non-empty.
  final String name;

  /// Description of the effect.
  final String? description;

  @override
  String toString() {
    return switch (description) {
      null => 'Effect($id, $name)',
      _ => 'Effect($id, $name, $description)',
    };
  }
}
