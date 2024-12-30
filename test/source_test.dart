import 'package:faerun/faerun.dart';

import '_prelude.dart';

void main() {
  test('freeResults is a valid Source', () {
    check(() => Source.freeRules).returnsNormally();
  });

  group('latest source', () {
    test('should have a null version', () {
      final source = Source.latest('Latest');
      check(source.version).isNull();
    });

    test('should be equivalent to itself', () {
      final source = Source.latest('Latest');
      check(source).isEquivalentTo(Source.latest('Latest'));
    });

    test('should be represented in toString', () {
      final source = Source.latest('Latest');
      check(source).hasToString.equals('Source.latest(Latest)');
    });
  });

  group('with explicit version', () {
    test('should have a version', () {
      final source = Source('Explicit', version: 42);
      check(source.version).equals(42);
    });

    test('should be equivalent to itself', () {
      final source = Source('Explicit', version: 42);
      check(source).isEquivalentTo(Source('Explicit', version: 42));
    });

    test('should be represented in toString', () {
      final source = Source('Explicit', version: 42);
      check(source).hasToString.equals('Source(Explicit, version: 42)');
    });

    test('cannot be 0', () {
      check(() => Source('Explicit', version: 0)).throws<RangeError>();
    });

    test('cannot be negative', () {
      check(() => Source('Explicit', version: -42)).throws<RangeError>();
    });
  });

  test('URL is not considered for equality', () {
    final source1 = Source(
      'URL',
      version: 1,
      url: Uri.parse('https://example.com'),
    );
    final source2 = Source(
      'URL',
      version: 1,
      url: Uri.parse('https://example.org'),
    );
    check(source1).isEquivalentTo(source2);
  });
}
