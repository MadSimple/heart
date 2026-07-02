import 'helper.dart' as h;

/// Generates a List of integers.
/// range(n) is always in ascending order, doesn't include n itself.
/// range(3) returns (0, 1, 2).
/// range(-3) returns (-2, -1, 0).
/// range(0) returns ().
///
/// With two arguments, result doesn't include the second:
/// range(1, 3) returns (1, 2).
/// range(-3, -1) returns (-3, -2).
/// range(0, -3) returns (0, -1, -2).
/// range(1, 1) returns ().
///
/// Optional [step] must be positive if a < b, negative if a > b.
/// range(1, 3, 2) returns (1).
/// range(-2, 2, 2) returns (-2, 0).
/// range(-3, -7, -2) returns (-3, -5).
Iterable<int> range(int a, [int? b, int? step]) sync* {
  if (b == null) {
    if (a >= 0) {
      for (int i = 0; i < a; i++) {
        yield i;
      }
    } else {
      for (int i = a + 1; i <= 0; i++) {
        yield i;
      }
    }
    return;
  }

  if (a < b) {
    if (step != null && step <= 0) {
      throw ArgumentError('step must be positive if beginning < end');
    }
    for (int i = a; i < b; i += step ?? 1) {
      yield i;
    }
  } else if (a > b) {
    if (step != null && step >= 0) {
      throw ArgumentError('step must be negative if beginning > end');
    }
    for (int i = a; i > b; i += step ?? -1) {
      yield i;
    }
  }
}

/// Same as [range] but returns a List type.
List<int> rangeList(int a, [int? b, int? step]) {
  return range(a, b, step).toList();
}

/// Uses character codes and [range].
/// Strings must have exactly 1 character.
///
/// rangeString('a', 'f') returns 'abcde'
/// rangeString('c', 'a') returns 'cb'
/// rangeString('a', 'z', 2) returns 'acegikmoqsuwy'
String rangeString(String a, [String? b, int? step]) {
  if (a.length != 1 || (b != null && b.length != 1)) {
    throw ArgumentError('Strings must have exactly 1 character');
  }

  return h.chrs(range(a.codeUnits.first, b?.codeUnits.first, step));
}

/// Generates an inclusive List of integers.
/// inclusive(3) returns (0, 1, 2, 3).
/// inclusive(-3) returns (-3, -2, -1, 0).
///
/// inclusive(1, 3) returns (1, 2, 3).
/// inclusive(-3, -1) returns (-3, -2, -1).
/// inclusive(0, -3) returns (0, -1, -2, -3).
///
/// Optional [step] must be positive if a < b, negative if a > b.
/// inclusive(1, 3, 2) returns (1, 3).
/// inclusive(-3, 1, 2) returns (-3, -1, 1).
/// inclusive(1, -3, -2) returns (1, -1, -3).
Iterable<int> inclusive(int a, [int? b, int? step]) sync* {
  // Only one argument given
  if (b == null) {
    if (a >= 0) {
      for (int i = 0; i <= a; i++) {
        yield i;
      }
    } else {
      for (int i = a; i <= 0; i++) {
        yield i;
      }
    }
    return;
  }

  if (a < b) {
    if (step != null && step <= 0) {
      throw ArgumentError('step must be positive if beginning < end');
    }
    for (int i = a; i <= b; i += step ?? 1) {
      yield i;
    }
  } else if (a > b) {
    if (step != null && step >= 0) {
      throw ArgumentError('step must be negative if beginning > end');
    }
    for (int i = a; i >= b; i += step ?? -1) {
      yield i;
    }
  } else {
    yield a;
  }
}

/// Same as [inclusive] but returns a List type.
List<int> inclusiveList(int a, [int? b, int? step]) {
  return inclusive(a, b, step).toList();
}

/// Uses character codes and [inclusive].
/// Strings must have exactly 1 character.
///
/// inclusiveString('a', 'c') returns 'abc'
/// inclusiveString('c', 'a') returns 'cba'
/// inclusiveString('a', 'g', 2) returns 'aceg'
String inclusiveString(String a, [String? b, int? step]) {
  if (a.length != 1 || (b != null && b.length != 1)) {
    throw ArgumentError('Strings must have exactly 1 character');
  }

  return h.chrs(inclusive(a.codeUnits.first, b?.codeUnits.first, step));
}
