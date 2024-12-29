import 'package:faerun/src/internal.dart';
import 'package:meta/meta.dart';

/// A source provides a canonical representation of game specifications.
///
/// Where not specified, a source-less object is considered to be a part of the
/// core game specification (i.e. implicitly part of the game engine, which is
/// mostly defined in [freeRules]).
///
/// ## Equality
///
/// Two sources are considered equal if they have the same [name] and [version].
@immutable
final class Source {
  /// Everything you need to get started playing D&D!
  ///
  /// See <https://www.dndbeyond.com/sources/dnd/free-rules>.
  static final freeRules = Source(
    'Free Rules',
    version: 2024,
    url: Uri(
      scheme: 'https',
      host: 'www.dndbeyond.com',
      path: '/sources/dnd/free-rules',
    ),
  );

  /// Creates a new source with the given name and version.
  Source(
    this.name, {
    required int version,
    this.url,
    // Defines a type signature for the constructor.
    // See https://github.com/dart-lang/sdk/issues/58607.
    // ignore: prefer_initializing_formals
  }) : version = version {
    checkPositive(version, 'version');
  }

  /// Creates a new source with the given name.
  ///
  /// The version is considered to be the latest version.
  Source.latest(this.name, {this.url}) : version = null;

  /// The name of the source.
  final String name;

  /// An optional link to the source as a URL.
  ///
  /// This can be a link to a website, a PDF, or any other online resource.
  ///
  /// URL is not considered when comparing sources for equality.
  final Uri? url;

  /// The version of the source.
  ///
  /// The number should be a positive integer, and guarantee that newer versions
  /// have a higher number. For example, version `2` is newer than version `1`,
  /// and `2024` is newer than `2014`.
  ///
  /// If not specified, the source is considered to be the latest version.
  final int? version;

  @override
  bool operator ==(Object other) {
    return other is Source && name == other.name && version == other.version;
  }

  @override
  int get hashCode => Object.hash(name, version);

  @override
  String toString() {
    return switch (version) {
      null => 'Source.latest($name)',
      _ => 'Source($name, version: $version)',
    };
  }
}
