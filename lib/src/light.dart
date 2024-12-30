import 'package:faerun/src/obscured.dart';

/// Determines the category of illumnation in an area.
///
/// ## Comparison
///
/// Ordered by least to most light.
enum Light implements Comparable<Light> {
  /// Creates an [Obscured.heavily] obscured area.
  ///
  /// Characters face darkness outdoors at night (even most moonlit nights),
  /// within the confines of an unlit dungeon, or in an area of magical
  /// darkness.
  darkness(Obscured.heavily),

  /// Creates an [Obscured.lightly] obscured area.
  ///
  /// Dim lights, also called shadows, which is usually a boundary between
  /// [bright] and [darkness]. The soft light of twilight and dawn also counts
  /// as dim light, and a full moon might bathe the land in dim light.
  dim(Obscured.lightly),

  /// Most creatures see normally.
  ///
  /// Even gloomy days provide birght light, as do torches, lanterns, fires,
  /// and other sources of illumination within a specific radius.
  bright(null);

  const Light(this.obscured);

  /// The level of obscurity in this light, if any.
  final Obscured? obscured;

  @override
  int compareTo(Light other) => index.compareTo(other.index);
}
