import 'package:meta/meta.dart';

/// Represents a non-canonical example of a [value] type with a textual [name].
///
/// Examples are intended to be used in user interfaces to provide a human-
/// readable selection of values. For example, a dropdown menu of difficulty
/// classes might include examples like "Easy", "Medium", and "Hard"; the name
/// itself is not typically stored after selection.
///
/// A value with a _canonical_ example should provide that information itself.
///
/// ## Equality
///
/// Two examples are considered equal if their values _and_ names are equal.
@immutable
final class Example<T> {
  /// Creates a new example with the given [value] and [name].
  ///
  /// By convention, the [name] should be a non-empty string that describes the
  /// example. For example, `Example(42, 'The answer to life, the universe, and
  /// everything')`.
  const Example(this.value, this.name);

  /// Value of the example.
  final T value;

  /// Name of the example.
  final String name;

  @override
  bool operator ==(Object other) {
    return other is Example<T> && value == other.value && name == other.name;
  }

  @override
  int get hashCode => Object.hash(value, name);

  @override
  String toString() => 'Example($value, $name)';
}
