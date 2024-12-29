@internal
library;

import 'package:meta/meta.dart';

/// Checks and returns the given [value] if it is positive.
int checkPositive(int value, [String? name, String? message]) {
  message ??= 'must be positive';
  if (value < 1) {
    throw RangeError.value(value, name, message);
  }
  return value;
}

/// Extension methods for [Iterable].
extension IterableExtension<T> on Iterable<T> {
  /// Like [Iterable.firstWhere], but returns `null` if no element is found.
  T? firstWhereOrNull(bool Function(T) predicate) {
    for (final element in this) {
      if (predicate(element)) {
        return element;
      }
    }
    return null;
  }
}
