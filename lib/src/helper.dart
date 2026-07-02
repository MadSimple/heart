/// Helper functions used for extension methods.
/// See heart.dart for more extensive documentation.
library;

import 'dart:collection';
import 'dart:math' show min, Random, max;

import 'package:collection/collection.dart';

import 'other_functions.dart' show inclusive, range;

/// To make iterable methods return correct iterable type.
extension HeartIterableType<E> on Iterable<E> {
  Queue<E> toQueue() => Queue.of(this);

  QueueList<E> toQueueList() => QueueList.from(this);
}

/// To make iterable methods return correct iterable type.
extension HeartIterableTypes<E> on Iterable<Iterable<E>> {
  /// Converts sub-iterables to List type
  List<List<E>> toNestedList() {
    return map((element) => element.toList()).toList();
  }

  /// Converts sub-iterables to List type
  QueueList<QueueList<E>> toNestedQueueList() {
    return QueueList.from(map((element) => QueueList.from(element)));
  }

  /// Converts sub-iterables to List type
  Queue<Queue<E>> toNestedQueue() {
    return Queue.of(map((element) => Queue.of(element)));
  }

  /// Converts sub-iterables to List type
  Set<Set<E>> toNestedSet() {
    return map((element) => element.toSet()).toSet();
  }
}

/// Increment or decrement Strings
String incrementString({required String original, required int increment}) {
  if (original.isEmpty) return '';

  final List<int> codes = original.codeUnits.toList();
  for (int i = 0; i < original.length; i++) {
    codes[i] += increment;
  }

  return chrs(codes);
}

/// Increment numbers in an iterable
Iterable<N> incrementIterable<N extends num>(
    {required Iterable<N> original, required N? increment}) {
  return original.map((element) => (element + (increment ?? 1)) as N);
}

/// Increment numbers in an iterable
Iterable<N> decrementIterable<N extends num>(
    {required Iterable<N> original, required N? decrement}) {
  return original.map((element) => N is int
      ? (element - (decrement ?? 1)).toInt() as N
      : (element - (decrement ?? 1)) as N);
}

/// Multiply all numbers in an iterable
Iterable<N> multiplyIterable<N extends num>(
    {required Iterable<N> original, required N n}) {
  return original.map((element) => (element * n) as N);
}

/// Multiply code units of characters in a String
String multiplyString({required String original, required num n}) {
  return chrs(original.codeUnits.map((element) => (element * n).round()));
}

/// Divide code units of characters in a String
String divideString({required String original, required num n}) {
  return chrs(original.codeUnits.map((element) => (element / n).round()));
}

/// Divide all numbers in an iterable
Iterable<N> divideIterable<N extends num>(
    {required Iterable<N> original, required num n, required bool intsOnly}) {
  return original
      .map((element) => intsOnly ? (element ~/ n) as N : (element / n) as N);
}

/// Insert a String between other Strings and concatenate
String intercalateString({
  required String substring,
  required Iterable<String> original,
  required int? count,
  required int skip,
  required bool reverse,
}) {
  List<List<int>> originalCopy = [];
  for (String s in original) {
    originalCopy.add(s.codeUnits);
  }

  List<int> subCodes = substring.codeUnits;

  return chrs(intercalateIterable(
    sub: subCodes,
    original: originalCopy,
    count: count,
    skip: skip,
    reverse: reverse,
  ));
}

/// Insert element between other elements and concatenate.
Iterable<T> intercalateIterable<T>({
  required Iterable<T> sub,
  required Iterable<Iterable<T>> original,
  required int? count,
  required int skip,
  required bool reverse,
}) sync* {
  if (skip < 0 ||
      original.length <= 1 ||
      sub.isEmpty ||
      (skip >= original.length - 1) ||
      (count != null && count <= 0)) {
    yield* original.flattened;
    return;
  }

  final List<Iterable<T>> originalCopy = original.toList();
  if (reverse) {
    int maxCount = originalCopy.length - 1 - skip;
    int actualCount = count == null ? maxCount : min(maxCount, count);
    int currentIndex = 0;
    for (int i = 0; i < originalCopy.length - skip - actualCount; i++) {
      yield* originalCopy[i];
      currentIndex = i;
    }

    for (int i = currentIndex + 1; i < originalCopy.length - skip; i++) {
      yield* sub;
      yield* originalCopy[i];
      if (i == originalCopy.length - 1) return;
      if (i == originalCopy.length - skip - 1) {
        yield* originalCopy.sublist(i + 1).flattened;
        return;
      }
    }
    return;
  } else {
    for (int i = 0; i < skip + 1; i++) {
      yield* originalCopy[i];
    }

    int? countRemaining = count;
    for (int i = skip + 1; i < original.length; i++) {
      yield* sub;
      yield* originalCopy[i];
      if (i == original.length - 1) return;

      if (countRemaining != null) countRemaining--;
      if (countRemaining == 0) {
        for (int j = i + 1; j < original.length; j++) {
          yield* originalCopy[j];
        }
        return;
      }
    }
  }
}

/// Combine Strings together
String concatString(Iterable<String> original) {
  StringBuffer result = StringBuffer();
  List<String> originalCopy = original.toList();
  for (int i = 0; i < originalCopy.length; i++) {
    result.write(originalCopy[i]);
  }

  return result.toString();
}

/// Split a String into a List of characters.
List<String> toChars({required String original, required bool whitespace}) {
  if (whitespace) {
    return original.split('');
  } else {
    return original
        .replaceAll(RegExp(r'\p{White_Space}', unicode: true), '')
        .split((''));
  }
}

/// Returns a List of Lists by adding one element at a time.
Iterable<Iterable<T>> inits<T>(Iterable<T> original) sync* {
  final list = original.toList();

  yield Iterable<T>.empty();

  for (int i = 1; i <= list.length; i++) {
    yield list.take(i).map((e) => e);
  }
}

/// Returns a List of Strings by adding one character at a time.
List<String> initsString(String original) {
  if (original.isEmpty) {
    return [''];
  }

  List<String> result = [''];
  List<int> codes = original.codeUnits;
  for (int i = 0; i < codes.length; i++) {
    result.add(chrs(codes.sublist(0, i + 1)));
  }
  return result;
}

/// Returns last character.
String? lastString(String original) {
  if (original.isEmpty) return null;

  return original.substring(original.length - 1, original.length);
}

/// Returns first element.
T? headList<T>(Iterable<T> original) {
  if (original.isEmpty) return null;

  return original.first!;
}

/// Returns first character.
String? headString(String original) {
  if (original.isEmpty) {
    return null;
  }
  return original.substring(0, 1);
}

/// Returns everything but the first element.
Iterable<T>? tailIterable<T>(Iterable<T> original) {
  if (original.isEmpty) return null;

  return original.skip(1);
}

/// Returns everything but the first character.
String? tailString(String original) {
  if (original.isEmpty) {
    return null;
  }
  return original.substring(1);
}

/// Returns everything but first element.
Iterable<Iterable<T>> tailsIterable<T>(Iterable<T> original) sync* {
  for (int i = 0; i < original.length; i++) {
    yield original.skip(i);
  }
  yield Iterable<T>.empty();
}

/// Returns a list of lists by removing one character at a time.
List<String> tailsString(String original) {
  String copy = original;
  List<String> result = [];
  for (int i = 0; i < original.length; i++) {
    result.add(copy);
    copy = copy.substring(1);
  }
  result.add('');
  return result;
}

/// Compare iterables by comparing each element
int? compareIterables({required Iterable it1, required Iterable it2}) {
  int minLength = min(it1.length, it2.length);

  for (int i = 0; i < minLength; i++) {
    var first = it1.elementAt(i);
    var second = it2.elementAt(i);
    int? compare;
    if (first is Iterable && second is Iterable) {
      compare = compareIterables(it1: first, it2: second);
    } else {
      try {
        compare = first.compareTo(second);
      } catch (_) {
        return null;
      }
    }

    if (compare == null) return null;
    if (compare > 0) return 1;
    if (compare < 0) return -1;
    // if (compare == 0) continue;
  }

  if (it1.length > it2.length) {
    return 1;
  } else if (it1.length < it2.length) {
    return -1;
  } else {
    return 0;
  }
}

/// Compare iterables
bool greaterThanIterable({
  required Iterable it1,
  required Iterable it2,
  required bool equalsReturnsTrue,
}) {
  int? compareValue = compareIterables(it1: it1, it2: it2);
  return equalsReturnsTrue
      ? compareValue == 0 || compareValue == 1
      : compareValue == 1;
}

/// Compare iterables
bool lessThanList({
  required Iterable it1,
  required Iterable it2,
  required bool equalsReturnsTrue,
}) {
  int? compareValue = compareIterables(it1: it1, it2: it2);
  return equalsReturnsTrue
      ? compareValue == 0 || compareValue == -1
      : compareValue == -1;
}

/// Compare Strings
bool greaterThanString(String s1, String s2) {
  return s1.compareTo(s2) > 0;
}

/// Compare Strings
bool lessThanString(String s1, String s2) {
  return s1.compareTo(s2) < 0;
}

/// Remove all whitespace from a String
String removeWhitespace(String original) {
  return original.replaceAll(RegExp(r'\p{White_Space}', unicode: true), '');
}

/// Split string into two.
List<String> splitAtString({required int index, required String original}) {
  if (index <= 0) return ['', original];
  if (index >= original.length) return [original, ''];

  return [
    original.substring(0, index),
    original.substring(index, original.length)
  ];
}

/// Split iterable into two.
Iterable<Iterable<T>> splitAtIterable<T>({
  required int index,
  required Iterable<T> original,
}) sync* {
  if (index <= 0) {
    yield Iterable<T>.empty();
    yield () sync* {
      yield* original;
    }();
    return;
  }

  final first = original.take(index);
  final second = original.skip(index);

  if (second.isEmpty) {
    yield () sync* {
      yield* original;
    }();
    yield Iterable<T>.empty();
    return;
  }

  yield first;
  yield second;
}

/// Return a shuffled String.
String shuffledString({required String original, required Random? random}) {
  return String.fromCharCodes(original.codeUnits.shuffled(random));
}

/// Join two iterables by taking turns.
Iterable<T> interleaveIterable<T>(Iterable<T> it1, Iterable<T> it2) sync* {
  final iterator1 = it1.iterator;
  final iterator2 = it2.iterator;

  bool hasNext1 = iterator1.moveNext();
  bool hasNext2 = iterator2.moveNext();

  while (hasNext1 && hasNext2) {
    yield iterator1.current;
    yield iterator2.current;

    hasNext1 = iterator1.moveNext();
    hasNext2 = iterator2.moveNext();
  }

  while (hasNext1) {
    yield iterator1.current;
    hasNext1 = iterator1.moveNext();
  }

  while (hasNext2) {
    yield iterator2.current;
    hasNext2 = iterator2.moveNext();
  }
}

/// Join two Strings by taking turns.
String interleaveString(String s1, String s2) {
  final buffer = StringBuffer();
  final len1 = s1.length;
  final len2 = s2.length;

  int i = 0;
  while (i < len1 && i < len2) {
    buffer.writeCharCode(s1.codeUnitAt(i));
    buffer.writeCharCode(s2.codeUnitAt(i));
    i++;
  }

  if (i < len1) {
    buffer.write(s1.substring(i));
  } else if (i < len2) {
    buffer.write(s2.substring(i));
  }

  return buffer.toString();
}

/// Split in half, interleave second half first.
Iterable<T> riffleInIterable<T>({
  required Iterable<T> original,
  required bool inverse,
}) sync* {
  if (original.isEmpty) return;

  final originalCopy = original.toList();
  if (inverse) {
    for (int i = 1; i < originalCopy.length; i += 2) {
      yield originalCopy[i];
    }
    for (int i = 0; i < originalCopy.length; i += 2) {
      yield originalCopy[i];
    }
    return;
  } else {
    final midpoint = originalCopy.length ~/ 2;

    final right = originalCopy.skip(midpoint);
    final left = originalCopy.take(midpoint);

    yield* interleaveIterable(right, left);
  }
}

/// Split in half, interleave together.
Iterable<T> riffleOutIterable<T>({
  required Iterable<T> original,
  required bool inverse,
}) sync* {
  if (original.isEmpty) return;

  final originalCopy = original.toList();
  if (inverse) {
    for (int i = 0; i < originalCopy.length; i += 2) {
      yield originalCopy[i];
    }
    for (int i = 1; i < originalCopy.length; i += 2) {
      yield originalCopy[i];
    }
    return;
  } else {
    final int midpoint = (originalCopy.length / 2).round();

    final right = originalCopy.skip(midpoint);
    final left = originalCopy.take(midpoint);

    yield* interleaveIterable(left, right);
  }
}

/// Split in half, interleave second half first.
String riffleInString({
  required String original,
  required bool inverse,
}) {
  if (original.isEmpty) return '';

  return String.fromCharCodes(riffleInIterable(
    original: original.codeUnits,
    inverse: inverse,
  ));
}

/// Split in half, interleave together.
String riffleOutString({
  required String original,
  required bool inverse,
}) {
  if (original.isEmpty) return '';

  return String.fromCharCodes(
      riffleOutIterable(original: original.codeUnits, inverse: inverse));
}

/// Group consecutive equal elements together.
Iterable<Iterable<T>> groupIterable<T>({
  required Iterable<T> original,
  required bool Function(T e1, T e2) equalityFunction,
}) {
  return groupByIterable(
      groupFunction: (a, b) => equalityFunction(a, b), original: original);
}

/// Group consecutive elements together if they meet criteria.
Iterable<Iterable<T>> groupByIterable<T>({
  required bool Function(T a, T b) groupFunction,
  required Iterable<T> original,
}) sync* {
  final iterator = original.iterator;
  if (!iterator.moveNext()) return;

  T previous = iterator.current;
  List<T> currentGroup = [previous];

  while (iterator.moveNext()) {
    final current = iterator.current;

    if (groupFunction(previous, current)) {
      currentGroup.add(current);
    } else {
      yield currentGroup.map((e) => e);

      currentGroup = [current];
    }

    previous = current;
  }

  yield currentGroup.map((e) => e);
}

/// Group characters together if they meet criteria.
List<String> groupByString(
    {required bool Function(String a, String b) groupFunction,
    required String original}) {
  if (original.isEmpty) {
    return [];
  }
  List<String> groups = [];
  String currentGroup = original.substring(0, 1);
  for (int i = 1; i < original.length; i++) {
    if (groupFunction(
        original.substring(i - 1, i), original.substring(i, i + 1))) {
      currentGroup += (original.substring(i, i + 1));
      if (i == original.length - 1) {
        groups.add(currentGroup);
      }
    } else {
      groups.add(currentGroup);
      currentGroup = original.substring(i, i + 1);
      if (i == original.length - 1) {
        groups.add(currentGroup);
      }
      continue;
    }
  }
  return groups;
}

/// Group consecutive characters together if they are equal.
List<String> groupString(String original) {
  return groupByString(groupFunction: normalEquals, original: original);
}

/// Returns false for lowercase letters
bool isUpper(String original) {
  return original.toUpperCase() == original;
}

/// Returns false for uppercase letters
bool isLower(String original) {
  return original.toLowerCase() == original;
}

/// Non-letter characters and lowercase letters return false
bool isStrictlyUpper(String original) {
  for (int i = 0; i < original.length; i++) {
    if (!(original[i].toUpperCase() == original[i] &&
        original[i] != original[i].toLowerCase())) {
      return false;
    }
  }

  return true;
}

/// Non-letter characters and uppercase letters return false
bool isStrictlyLower(String original) {
  for (int i = 0; i < original.length; i++) {
    if (!(original[i].toLowerCase() == original[i] &&
        original[i] != original[i].toUpperCase())) {
      return false;
    }
  }

  return true;
}

/// Remove the given indices
Iterable<T> dropIndicesIterable<T>({
  required Iterable<T> original,
  required Iterable<int> indicesToDrop,
}) sync* {
  if (indicesToDrop.isEmpty) {
    yield* original;
    return;
  }

  final indicesCopy = indicesToDrop.toSet();

  int currentIndex = 0;
  for (final element in original) {
    if (!indicesCopy.contains(currentIndex)) {
      yield element;
    }
    currentIndex++;
  }
}

/// Remove the given indices
String dropIndicesString(
    {required String original, required Iterable<int> indicesToDrop}) {
  if (indicesToDrop.isEmpty) {
    return original;
  } else if (original.isEmpty) {
    return '';
  }

  List<int> indicesToKeep = subtractIterable(
          original: Iterable<int>.generate(original.length),
          elementsToRemove: indicesToDrop,
          equalityFunction: normalEquals)
      .toList();

  return keepIndicesString(original: original, indices: indicesToKeep);
}

/// Drop first n elements that meet criteria.
List<T> dropWhileList<T>(
    {required bool Function(T sub) dropFunction,
    required Iterable<T> original}) {
  final List<T> copy = original.toList();
  for (int i = 0; i < copy.length; i++) {
    if (!dropFunction(copy[i])) {
      return copy.sublist(i, copy.length);
    }
  }

  return [];
}

/// Sort string by character codes.
String ascendingString(String original) {
  final List<int> chars = original.codeUnits.toList();
  chars.sort();
  return String.fromCharCodes(chars);
}

/// Sort String in descending order.
String descendingString(String original) {
  final List<int> chars = original.codeUnits.toList();
  chars.sort();
  return String.fromCharCodes(chars.reversed);
}

/// Sort iterable
Iterable<T> ascendingIterable<T>(Iterable<T> original) sync* {
  final List<T> result = original.toList();

  try {
    result.sort();
  } catch (_) {
    try {
      result.sort((a, b) {
        try {
          if (a is Iterable && b is Iterable) {
            return compareIterables(it1: a, it2: b)!;
          } else {
            return a.toString().compareTo(b.toString());
          }
        } catch (_) {
          return 0;
        }
      });
    } catch (_) {
      yield* result;
    }
  }

  yield* result;
}

/// Reverse sorted list
Iterable<T> descendingIterable<T>(Iterable<T> original) sync* {
  yield* backwardsIterable(ascendingIterable(original));
}

/// Sum elements
double? sumDouble(Iterable<num> original) {
  if (original.isEmpty) {
    return null;
  }

  double result = 0;

  for (num n in original) {
    result += n;
  }

  return result;
}

/// Multiply all elements.
T? productOrNull<T extends num>(Iterable<T> original) {
  if (original.isEmpty) return null;

  T result = 1 as T;

  for (T n in original) {
    result = (result * n as T);
  }

  return result;
}

/// Remove duplicate characters
String nubString({required String original, required String? charsToNub}) {
  if (original.isEmpty) return '';
  if (charsToNub != null && charsToNub.isEmpty) return original;

  final Set<String>? nubSet = charsToNub?.split('').toSet();

  final Set<String> seen = {};
  final StringBuffer result = StringBuffer();

  for (final char in original.split('')) {
    if (nubSet != null && !nubSet.contains(char)) {
      result.write(char);
    } else if (seen.add(char)) {
      result.write(char);
    }
  }

  return result.toString();
}

/// Remove duplicate elements
Iterable<T> nubIterable<T>({
  required Iterable<T> original,
  required Iterable<T>? elementsToNub,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (original.isEmpty) return;

  final List<T> seenElements = [];

  for (final current in original) {
    final bool seen =
        seenElements.any((item) => equalityFunction(item, current));

    if (!seen) {
      seenElements.add(current);
      yield current;
    } else if (elementsToNub != null) {
      final bool inNubList =
          elementsToNub.any((item) => equalityFunction(item, current));

      if (!inNubList) {
        yield current;
      }
    }
  }
}

/// Reversed, return List
Iterable<T> backwardsIterable<T>(Iterable<T> original) {
  return original.toList().reversed;
}

/// Reverse a String
String backwardsString(String original) {
  final StringBuffer result = StringBuffer();
  for (int i = original.length - 1; i >= 0; i--) {
    result.write(original[i]);
  }

  return result.toString();
}

/// Convert all elements to Strings.
Iterable<String> toStringIterable<T>(Iterable<T> original) {
  return original.map((element) => element.toString());
}

/// Separate a String into a List of words.
List<String> words(String original) {
  List<String> result = [];

  List<Match> matches = RegExp(r'[^\p{White_Space}]+', unicode: true)
      .allMatches(original)
      .toList();

  for (int i = 0; i < matches.length; i++) {
    result.add(matches[i].groups([0]).first!);
  }

  return result;
}

/// Count number of words separated by whitespace.
int wordCount(String original) {
  return RegExp(r'[^\p{White_Space}]+', unicode: true)
      .allMatches(original)
      .length;
}

/// Get new characters from [input].
String addMissingString({required String original, required String input}) {
  return String.fromCharCodes(addMissingIterable(
      original: original.codeUnits,
      input: input.codeUnits,
      equalityFunction: normalEquals));
}

/// Get new elements from [input]
Iterable<T> addMissingIterable<T>({
  required Iterable<T> original,
  required Iterable<T> input,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  yield* original;

  final List<T> originalCopy = original.toList();

  for (final element in input) {
    if (!originalCopy
        .any((originalElement) => equalityFunction(originalElement, element))) {
      originalCopy.add(element);
      yield element;
    }
  }
}

/// Keep only characters from [input]
String keepString({required String original, required String input}) {
  return String.fromCharCodes(
    keepElements(
      original: original.codeUnits,
      input: input.codeUnits,
      equalityFunction: normalEquals,
    ),
  );
}

/// Keep only elements from [input]
Iterable<T> keepElements<T>({
  required Iterable<T> original,
  required Iterable<T> input,
  required bool Function(T a, T b) equalityFunction,
}) {
  return original.where((element) => deepContains(
      original: input,
      candidate: [element],
      equalityFunction: equalityFunction));
}

/// Check if any characters meet criteria
bool stringAny({
  required bool Function(String sub) anyFunction,
  required String original,
}) {
  if (original.isEmpty) return false;

  for (int i in original.codeUnits) {
    if (anyFunction(String.fromCharCode(i))) {
      return true;
    }
  }
  return false;
}

/// Check if every character meets criteria
bool stringEvery({
  required bool Function(String element) allFunction,
  required String original,
}) {
  for (int i in original.codeUnits) {
    if (!allFunction(String.fromCharCode(i))) {
      return false;
    }
  }
  return true;
}

/// Only keep characters that meet criteria
String filterString({
  required bool Function(String sub) test,
  required String original,
}) {
  return original.split('').where(test).join();
}

/// Get character from character code
String chr(int code) {
  try {
    return String.fromCharCode(code);
  } catch (_) {
    return '';
  }
}

/// Get a String from character codes
String chrs(Iterable<int> characterCodes) {
  StringBuffer result = StringBuffer();

  for (int code in characterCodes) {
    result.write(chr(code));
  }

  return result.toString();
}

/// Insert an element between other elements
Iterable<T> intersperseIterable<T>({
  required Iterable<T> original,
  required Iterable<T> elementsToAdd,
  required int? count,
  required int skip,
  required bool reverse,
}) sync* {
  final originalCopy = original.toList();
  final len = originalCopy.length;
  final possibleSlots = len - 1;

  if (skip < 0 ||
      len <= 1 ||
      elementsToAdd.isEmpty ||
      skip >= possibleSlots ||
      (count != null && count <= 0)) {
    yield* original;
    return;
  }

  final insertions = count == null
      ? possibleSlots - skip
      : (count < possibleSlots - skip ? count : possibleSlots - skip);

  int startAfterIndex;
  int endAfterIndex;

  if (reverse) {
    endAfterIndex = possibleSlots - 1 - skip;
    startAfterIndex = endAfterIndex - insertions + 1;
  } else {
    startAfterIndex = skip;
    endAfterIndex = skip + insertions - 1;
  }

  for (int i = 0; i < len; i++) {
    yield originalCopy[i];

    if (i >= startAfterIndex && i <= endAfterIndex) {
      yield* elementsToAdd;
    }
  }
}

/// Insert character between other characters
String intersperseString({
  required String substring,
  required String original,
  required int? count,
  required int skip,
  required bool reverse,
}) {
  if (original.length <= 1) return original;

  return intercalateString(
    substring: substring,
    original: toChars(original: original, whitespace: true),
    count: count,
    skip: skip,
    reverse: reverse,
  );
}

/// Subtract characters one at at ime from [charsToRemove]
String stringSubtract(
    {required String original, required String charsToRemove}) {
  if (original.isEmpty) {
    return '';
  }
  if (charsToRemove.isEmpty) {
    return original;
  }

  List<int> originalCodes = original.codeUnits;
  List<int> deleteCodes = charsToRemove.codeUnits;
  return String.fromCharCodes(
    subtractIterable(
      original: originalCodes,
      elementsToRemove: deleteCodes,
      equalityFunction: normalEquals,
    ),
  );
}

/// Subtract all characters that are in [charsToRemove]
String stringSubtractAll(
    {required String original, required String charsToRemove}) {
  if (original.isEmpty) {
    return '';
  }
  if (charsToRemove.isEmpty) {
    return original;
  }

  final originalCodes = original.codeUnits;
  final deleteCodes = charsToRemove.codeUnits;
  return String.fromCharCodes(
    iterableSubtractAll(
      original: originalCodes,
      elementsToRemove: deleteCodes,
      equalityFunction: normalEquals,
    ),
  );
}

/// Subtract elements one at a time
Iterable<T> subtractIterable<T>({
  required Iterable<T> original,
  required Iterable<T> elementsToRemove,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (original.isEmpty) return;
  if (elementsToRemove.isEmpty) {
    yield* original;
    return;
  }

  final removeCopy = elementsToRemove.toList();

  for (final element in original) {
    bool shouldRemove = false;

    for (int i = 0; i < removeCopy.length; i++) {
      if (equalityFunction(element, removeCopy[i])) {
        removeCopy.removeAt(i);
        shouldRemove = true;
        break;
      }
    }

    if (!shouldRemove) {
      yield element;
    }
  }
}

/// Subtract all elements that are in [elementsToRemove]
Iterable<T> iterableSubtractAll<T>({
  required Iterable<T> original,
  required Iterable<T> elementsToRemove,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (original.isEmpty) return;
  if (elementsToRemove.isEmpty) {
    yield* original;
    return;
  }

  for (final element in original) {
    if (!elementsToRemove.any((e) => equalityFunction(element, e))) {
      yield element;
    }
  }
}

/// List of every index of [char] in [original]
int? countChar({
  required String original,
  required String char,
}) {
  if (char.length != 1) {
    return null;
  }

  int result = 0;

  for (int i = 0; i < original.length; i++) {
    if (original[i] == char) {
      result += 1;
    }
  }

  return result;
}

/// Count number of occurrences of an element in a list.
int countElement<T>({
  required T element,
  required Iterable<T> original,
}) {
  int result = 0;
  List<T> copy = original.toList();
  for (int i = 0; i < original.length; i++) {
    if (symmetricDeepEquals(element, copy[i])) {
      result++;
    }
  }

  return result;
}

/// Count number of occurrences of a sublist in a list.
int countIterable<T>({
  required Iterable<T> sublist,
  required Iterable<T> original,
  required bool overlap,
  required bool Function(T a, T b) equalityFunction,
}) {
  return indicesOfIterable(
    original: original,
    sub: sublist,
    overlap: overlap,
    reverse: false,
    maxCount: null,
    equalityFunction: equalityFunction,
  ).length;
}

/// Count number of occurrences in a String.
int countSubstring({
  required Pattern sub,
  required String original,
  required bool overlap,
  required bool reverse,
}) {
  return indicesOfString(
    original: original,
    sub: sub,
    overlap: overlap,
    maxCount: null,
    reverse: reverse,
  ).length;
}

/// List of every index of [sub] in [original]
List<int> indicesOfString({
  required String original,
  required Pattern sub,
  required bool overlap,
  required int? maxCount,
  required bool reverse,
}) {
  RegExp subCopy = sub is RegExp ? sub : RegExp(RegExp.escape(sub.toString()));

  List<Match> matches = getMatchesString(
    original: original,
    sub: subCopy,
    maxCount: maxCount,
    reverse: reverse,
    overlap: overlap,
  );

  return matches.map((m) => m.start).toList();
}

/// Used in [indicesOfString]
List<Match> getMatchesString({
  required String original,
  required RegExp sub,
  required int? maxCount,
  required bool reverse,
  required bool overlap,
}) {
  if (reverse) {
    return getBackwardMatchesString(
        original: original, sub: sub, overlap: overlap, maxCount: maxCount);
  } else {
    return getForwardMatchesString(
        original: original, sub: sub, overlap: overlap, maxCount: maxCount);
  }
}

/// Return a subset of RegExp matches
List<Match> getForwardMatchesString({
  required String original,
  required RegExp sub,
  required bool overlap,
  required int? maxCount,
}) {
  if (maxCount != null && maxCount <= 0) return [];
  if (overlap) {
    return getOverlappingMatchesString(
        original: original, regEx: sub, maxCount: maxCount, reverse: false);
  }
  return maxCount == null
      ? sub.allMatches(original).toList()
      : sub.allMatches(original).take(maxCount).toList();
}

/// .allMatches does not get overlapping matches
List<Match> getOverlappingMatchesString({
  required String original,
  required RegExp regEx,
  required int? maxCount,
  required reverse,
}) {
  if (maxCount != null && maxCount <= 0) {
    return [];
  }

  final List<Match> result = [];

  for (int i = !reverse ? 0 : original.length;
      !reverse ? i <= original.length : i >= 0;
      !reverse ? i++ : i--) {
    Match? currentMatch = regEx.matchAsPrefix(original, i);

    if (currentMatch != null) {
      result.add(currentMatch);
      if (maxCount != null && result.length == maxCount) return result;
    }
  }

  return result;
}

/// Get RegExp matches starting from the end, since the indices could be different than going forward.
List<Match> getBackwardMatchesString({
  required String original,
  required RegExp sub,
  required overlap,
  required int? maxCount,
}) {
  if (maxCount != null && maxCount <= 0) return [];

  if (overlap) {
    return getOverlappingMatchesString(
        original: original, regEx: sub, maxCount: maxCount, reverse: true);
  }

  List<Match> result = [];

  int greatestCandidateIndex = original.length;
  List<int> allUsedIndices = [];

  while (greatestCandidateIndex >= 0) {
    int foundIndex = original.lastIndexOf(sub, greatestCandidateIndex);

    if (foundIndex == -1) {
      break;
    }

    Match match = sub.matchAsPrefix(original, foundIndex)!;
    int matchLength = match.groups([0]).first!.length;
    Iterable<int> currentUsedIndices =
        range(match.start, match.start + max(1, matchLength));

    if (keepElements(
            original: allUsedIndices,
            input: currentUsedIndices,
            equalityFunction: normalEquals)
        .isEmpty) {
      result.add(match);
      if (result.length == maxCount) return result;
      allUsedIndices.addAll(currentUsedIndices);
    }

    greatestCandidateIndex = match.start - 1;
  }

  return result;
}

/// Return all indices of a sub-iterable
Iterable<int> indicesOfIterable<T>({
  required Iterable<T> original,
  required Iterable<T> sub,
  required bool overlap,
  required int? maxCount,
  required bool reverse,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (maxCount != null && maxCount <= 0) return;

  final originalCopy = original.toList();
  final subCopy = sub.toList();

  if (subCopy.isEmpty) {
    int foundCount = 0;
    final n = originalCopy.length;

    if (reverse) {
      for (int i = n; i >= 0; i--) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    } else {
      for (int i = 0; i <= n; i++) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    }
    return;
  }

  if (subCopy.length > originalCopy.length) return;

  int foundCount = 0;
  final step = overlap ? 1 : subCopy.length;
  final subLen = subCopy.length;

  bool windowMatches(int i) {
    for (int j = 0; j < subLen; j++) {
      if (!equalityFunction(originalCopy[i + j], subCopy[j])) {
        return false;
      }
    }
    return true;
  }

  if (reverse) {
    int i = originalCopy.length - subLen;
    while (i >= 0) {
      if (windowMatches(i)) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
        i -= step;
      } else {
        i--;
      }
    }
  } else {
    int i = 0;
    final maxIndex = originalCopy.length - subLen;
    while (i <= maxIndex) {
      if (windowMatches(i)) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
        i += step;
      } else {
        i++;
      }
    }
  }
}

Iterable<int> indicesElement<T>({
  required Iterable<T> original,
  required T candidate,
  required int? maxCount,
  required bool reverse,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (maxCount != null && maxCount <= 0) return;

  final list = original.toList();
  int foundCount = 0;

  if (reverse) {
    for (int i = list.length - 1; i >= 0; i--) {
      if (equalityFunction(list[i], candidate)) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    }
  } else {
    for (int i = 0; i < list.length; i++) {
      if (equalityFunction(list[i], candidate)) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    }
  }
}

/// Return all of the given indices of a String
String keepIndicesString(
    {required String original, required Iterable<int> indices}) {
  return nubIterable(
          original: indices,
          elementsToNub: null,
          equalityFunction: DeepCollectionEquality().equals)
      .where((i) => i >= 0 && i < original.length)
      .map((i) => original[i])
      .join();
}

/// Return given indices
Iterable<T> keepIndicesIterable<T>(
    {required Iterable<T> original, required Iterable<int> indices}) {
  return nubIterable(
          original: indices,
          elementsToNub: null,
          equalityFunction: DeepCollectionEquality().equals)
      .where((i) => i >= 0 && i < original.length)
      .map((i) => original.elementAt(i));
}

/// Insert each element from numsToInsert before the first element that is >=
Iterable<T> insertInOrderNums<T extends num>({
  required Iterable<T> original,
  required Iterable<num> numbersToInsert,
}) sync* {
  final result = original.toList();

  for (final numToInsert in numbersToInsert) {
    int insertionIndex = result.length;

    for (int i = 0; i < result.length; i++) {
      if (result[i] >= numToInsert) {
        insertionIndex = i;
        break;
      }
    }

    result.insert(insertionIndex, numToInsert as T);
  }

  yield* result;
}

/// Insert a character before the first greater character
String insertInOrderString(
    {required String charsToInsert, required String original}) {
  return chrs(insertInOrderNums(
      original: original.codeUnits, numbersToInsert: charsToInsert.codeUnits));
}

/// Repeat elements of a list [timesToRepeat] times
Iterable<T> cycleIterable<T>(
    {required int timesToRepeat, required Iterable<T> original}) sync* {
  if (timesToRepeat <= 0 || original.isEmpty) return;

  for (var i = 0; i < timesToRepeat; i++) {
    yield* original;
  }
}

/// Multiply elements together
num productOfElements(Iterable<num> original) {
  num result = 1;
  for (num n in original) {
    result *= n;
  }
  return result;
}

/// Used in [symmetricDeepEquals]
bool iterableEquals(Iterable it1, Iterable it2) {
  if (it1.length != it2.length) return false;

  final iter1 = it1.iterator;
  final iter2 = it2.iterator;

  while (iter1.moveNext() && iter2.moveNext()) {
    final e1 = iter1.current;
    final e2 = iter2.current;

    if (e1 is Iterable && e2 is Iterable) {
      if (!iterableEquals(e1, e2)) return false;
    } else if (!DeepCollectionEquality().equals(e1, e2)) {
      return false;
    }
  }

  return true;
}

/// Check if iterable contains a sub-iterable
bool deepContains<T>({
  required Iterable<T> original,
  required Iterable<T> candidate,
  required bool Function(T a, T b) equalityFunction,
}) {
  if (candidate.isEmpty) return true;

  final originalList = original.toList();
  final candidateList = candidate.toList();

  final maxSearchIndex = originalList.length - candidateList.length;

  for (int i = 0; i <= maxSearchIndex; i++) {
    bool matchFound = true;

    for (int j = 0; j < candidateList.length; j++) {
      if (!equalityFunction(originalList[i + j], candidateList[j])) {
        matchFound = false;
        break;
      }
    }

    if (matchFound) {
      return true;
    }
  }

  return false;
}

/// Combine corresponding elements of separate iterables together
Iterable<Iterable<T>> zipIterable<T>(
    Iterable<Iterable<T>> nestedIterable) sync* {
  if (nestedIterable.isEmpty) return;

  final iterators = nestedIterable.map((e) => e.iterator).toList();

  while (true) {
    final List<T> current = [];

    for (final iterator in iterators) {
      if (!iterator.moveNext()) {
        return;
      }
      current.add(iterator.current);
    }

    yield () sync* {
      yield* current;
    }();
  }
}

/// Equivalent to [zipIterable]
Iterable<String> zipString(Iterable<String> original) sync* {
  if (original.isEmpty) return;

  List<String> originalCopy = original.toList();
  int minLength = originalCopy.map((element) => element.length).min;

  for (int i = 0; i < minLength; i++) {
    StringBuffer current = StringBuffer();
    for (int j = 0; j < originalCopy.length; j++) {
      current.write(originalCopy[j][i]);
    }
    yield current.toString();
  }
}

/// Combine corresponding elements of iterables and perform a function between them.
Iterable<R> zipWithIterable<E, T extends Iterable<E>, R>(
  Iterable<T> iterables,
  R Function(List<E>) zipFunction,
) sync* {
  if (iterables.isEmpty) return;

  final iterators = iterables.map((e) => e.iterator).toList();

  while (true) {
    final List<E> currentValues = [];

    for (final iterator in iterators) {
      if (!iterator.moveNext()) return;
      currentValues.add(iterator.current);
    }

    yield zipFunction(currentValues);
  }
}

/// Combine corresponding elements of characters and perform a function between them.
Iterable<R> zipWithString<T extends Iterable<String>, R>(
  Iterable<String> iterables,
  R Function(List<String>) zipFunction,
) sync* {
  if (iterables.isEmpty) return;

  final iterators = iterables.map((e) => e.split('').iterator).toList();

  while (true) {
    final List<String> currentValues = [];

    for (final iterator in iterators) {
      if (!iterator.moveNext()) return;
      currentValues.add(iterator.current);
    }

    yield zipFunction(currentValues);
  }
}

/// Get all the characters after a given substring
String afterSubstring({
  required String original,
  required Pattern sub,
  required int skip,
  required bool reverse,
  required bool overlap,
  required bool includeInResult,
}) {
  if (original.isEmpty) return '';
  if (skip < 0) return reverse ? '' : original;

  RegExp regex = sub is RegExp ? sub : RegExp(RegExp.escape(sub.toString()));

  final List<Match> matches = getMatchesString(
    original: original,
    sub: regex,
    maxCount: skip + 1,
    reverse: reverse,
    overlap: overlap,
  );

  if (skip >= matches.length) {
    return reverse ? original : '';
  }

  Match targetMatch = matches[skip];

  int startIndex = includeInResult
      ? targetMatch.start
      : (targetMatch.start + targetMatch.groups([0]).first!.length);

  return original.substring(startIndex);
}

/// Used in [afterIterable]. Assumed no overlap.
List<int> getBackwardIndicesList<T>({
  required Iterable<T> original,
  required Iterable<T> sublist,
  required overlap,
  required int? maxCount,
  required bool Function(Object? e1, Object? e2) equalityFunction,
}) {
  if (overlap) {
    return backwardsIterable(
      indicesOfIterable(
        original: original,
        sub: sublist,
        overlap: true,
        maxCount: maxCount,
        reverse: true,
        equalityFunction: equalityFunction,
      ),
    ).toList();
  } else if (sublist.isEmpty) {
    return inclusive(original.length,
            maxCount != null ? (original.length - maxCount) : 0)
        .toList();
  } else if (original.isEmpty) {
    return [];
  }

  final originalCopy = original.toList();
  final subCopy = sublist.toList();

  final List<int> result = [];
  int maxIndex = original.length - sublist.length;
  int currentIndex = maxIndex;
  while (currentIndex >= 0) {
    if (symmetricDeepEquals(
        originalCopy.sublist(currentIndex, currentIndex + sublist.length),
        subCopy)) {
      result.add(currentIndex);
      currentIndex -= sublist.length;
    } else {
      currentIndex--;
    }
  }

  return result;
}

/// Return elements after a given sublist
Iterable<T> afterIterable<T>({
  required Iterable<T> original,
  required Iterable<T> sub,
  required int skip,
  required bool reverse,
  required bool overlap,
  required bool includeInResult,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  final List<T> originalCopy = original.toList();

  if (originalCopy.isEmpty) return;

  if (skip < 0) {
    if (!reverse) yield* originalCopy;

    return;
  }

  final List<int> indices = indicesOfIterable(
    original: original,
    sub: sub,
    overlap: overlap,
    maxCount: skip + 1,
    reverse: reverse,
    equalityFunction: equalityFunction,
  ).toList();

  if (skip >= indices.length) {
    if (reverse) yield* originalCopy;

    return;
  }

  int targetIndex;
  if (includeInResult) {
    targetIndex = indices[skip];
  } else {
    targetIndex = indices[skip] + sub.length;
  }

  yield* originalCopy.sublist(targetIndex);
}

/// Get all the characters before a substring
String beforeSubstring({
  required String original,
  required Pattern sub,
  required int skip,
  required bool reverse,
  required bool overlap,
  required bool includeInResult,
}) {
  if (original.isEmpty) return '';
  if (skip < 0) return reverse ? original : '';

  RegExp regex = sub is RegExp ? sub : RegExp(RegExp.escape(sub.toString()));

  List<Match> matches = getMatchesString(
    original: original,
    sub: regex,
    maxCount: skip + 1,
    reverse: reverse,
    overlap: overlap,
  );

  if (skip >= matches.length) {
    return reverse ? '' : original;
  }

  int endIndex;
  if (includeInResult) {
    endIndex = matches[skip].start + matches[skip].groups([0]).first!.length;
  } else {
    endIndex = matches[skip].start;
  }

  return original.substring(0, endIndex);
}

/// Return elements before a given sublist
Iterable<T> beforeIterable<T>({
  required Iterable<T> original,
  required Iterable<T> sub,
  required int skip,
  required bool reverse,
  required bool overlap,
  required bool includeInResult,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  final List<T> originalCopy = original.toList();

  if (originalCopy.isEmpty) {
    return;
  }

  if (skip < 0) {
    if (reverse) yield* originalCopy;

    return;
  }

  final List<int> indices = indicesOfIterable(
    original: original,
    sub: sub,
    overlap: overlap,
    maxCount: skip + 1,
    reverse: reverse,
    equalityFunction: equalityFunction,
  ).toList();

  if (skip >= indices.length) {
    if (!reverse) yield* originalCopy;

    return;
  }

  int endIndex;
  if (includeInResult) {
    endIndex = indices[skip] + sub.length;
  } else {
    endIndex = indices[skip];
  }

  yield* originalCopy.sublist(0, endIndex);
}

/// Return everything before a condition is met
Iterable<T> beforeWhereIterable<T>({
  required Iterable<T> original,
  required bool Function(T element) test,
  required int skip,
  required bool reverse,
  required bool includeInResult,
}) sync* {
  final List<T> originalCopy = original.toList();

  if (originalCopy.isEmpty) return;

  if (skip < 0) {
    if (reverse) yield* originalCopy;

    return;
  }

  final List<int> indices = indicesWhere(
          original: original,
          testFunction: test,
          maxCount: skip + 1,
          reverse: reverse)
      .toList();

  if (skip >= indices.length) {
    if (!reverse) yield* originalCopy;

    return;
  }

  int endIndex;
  if (includeInResult) {
    endIndex = indices[skip] + 1;
  } else {
    endIndex = indices[skip];
  }

  yield* originalCopy.sublist(0, endIndex);
}

/// Return characters before a condition is met
String beforeWhereString({
  required String original,
  required bool Function(String char) test,
  required int skip,
  required bool reverse,
  required bool includeInResult,
}) {
  if (original.isEmpty) return '';

  if (skip < 0) return reverse ? original : '';

  List<int> indices = indicesWhereString(
    original: original,
    testFunction: test,
    maxCount: skip + 1,
    reverse: reverse,
  );

  if (skip >= indices.length) return reverse ? '' : original;

  int endIndex;
  if (includeInResult) {
    endIndex = indices[skip] + 1;
  } else {
    endIndex = indices[skip];
  }

  return original.substring(0, endIndex);
}

/// Return everything after a condition is met
Iterable<T> afterWhereIterable<T>({
  required Iterable<T> original,
  required bool Function(T element) test,
  required int skip,
  required bool reverse,
  required bool includeInResult,
}) sync* {
  final List<T> originalCopy = original.toList();
  if (originalCopy.isEmpty) return;

  if (skip < 0) {
    if (!reverse) yield* original;

    return;
  }

  final List<int> indices = indicesWhere(
          original: original,
          testFunction: test,
          maxCount: skip + 1,
          reverse: reverse)
      .toList();

  if (skip >= indices.length) {
    if (reverse) yield* original;

    return;
  }

  int targetIndex;
  if (includeInResult) {
    targetIndex = indices[skip];
  } else {
    targetIndex = indices[skip] + 1;
  }

  yield* originalCopy.sublist(targetIndex);
}

/// Return all characters after a condition is met
String afterWhereString({
  required String original,
  required bool Function(String element) test,
  required int skip,
  required bool reverse,
  required bool includeInResult,
}) {
  if (original.isEmpty) return '';

  if (skip < 0) return reverse ? '' : original;

  List<int> indices = indicesWhereString(
    original: original,
    testFunction: test,
    maxCount: skip + 1,
    reverse: reverse,
  );

  if (skip >= indices.length) return reverse ? original : '';

  int targetIndex;
  if (includeInResult) {
    targetIndex = indices[skip];
  } else {
    targetIndex = indices[skip] + 1;
  }

  return original.substring(targetIndex);
}

/// Analogous to String.startsWith
bool startsWithList<T>(
    {required Iterable<T> original,
    required Iterable<T> sub,
    required bool Function(T a, T b) equalityFunction}) {
  int len = original.length;
  int subLen = sub.length;
  if (subLen > len) {
    return false;
  }

  return deepContains(
    original: original.take(subLen),
    candidate: sub,
    equalityFunction: equalityFunction,
  );
}

/// Replace one sublist with another, any or all occurrences.
Iterable<T> replaceIterable<T>({
  required Iterable<T> original,
  required Iterable<T> from,
  required Iterable<T> to,
  required int? count,
  required int skip,
  required bool recursive,
  required bool reverse,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (recursive) {
    yield* replaceSublist(
      original: original,
      from: from,
      to: to,
      count: count,
      skip: skip,
      recursive: recursive,
      reverse: reverse,
      equalityFunction: equalityFunction,
    );
    return;
  }

  if (skip < 0 || (count != null && count <= 0)) {
    yield* original;
    return;
  }

  List<int> indices = indicesOfIterable(
    original: original,
    sub: from,
    overlap: false,
    reverse: reverse,
    maxCount: count == null ? null : skip + count,
    equalityFunction: equalityFunction,
  ).toList();

  if (skip >= indices.length) {
    yield* original;
    return;
  }

  List<T> originalCopy = original.toList();
  List<T> fromCopy = from.toList();
  // int? countCopy = count;

  if (reverse) {
    indices = backwardsIterable(indices.sublist(skip)).toList();
  }

  yield* original.take(indices[reverse ? 0 : skip]);

  for (int i = reverse ? 0 : skip; i < indices.length; i++) {
    yield* to;
    if (i == indices.length - 1) {
      yield* originalCopy.sublist(indices[i] + fromCopy.length);
      return;
    } else {
      yield* originalCopy.sublist(indices[i] + fromCopy.length, indices[i + 1]);
    }
    // if (countCopy != null) countCopy--;
    // if (countCopy != null && countCopy == 0) {
    //   yield* originalCopy.sublist(indices[i + 1] + fromCopy.length);
    //   return;
    // }
  }
}

/// Replace one sublist with another, any or all occurrences.
List<T> replaceSublist<T>({
  required Iterable<T> original,
  required Iterable<T> from,
  required Iterable<T> to,
  required int? count,
  required int skip,
  required bool recursive,
  required bool reverse,
  required bool Function(T a, T b) equalityFunction,
}) {
  if (skip < 0 || (count != null && count <= 0)) {
    return original.toList();
  }

  final List<int> indices = indicesOfIterable(
    original: original,
    sub: from,
    overlap: false,
    reverse: reverse,
    maxCount: count == null ? null : skip + count,
    equalityFunction: equalityFunction,
  ).toList();

  if (skip >= indices.length) {
    return original.toList();
  }

  List<T> result = [];

  int? countCopy = count;
  int lastIndexReplaced = 0;
  final List<T> originalCopy = original.toList();
  final List<T> toCopy = to.toList();

  if (!reverse) {
    for (int i = skip; i < indices.length; i++) {
      result += originalCopy.sublist(
          i == skip ? 0 : indices[i - 1] + from.length, indices[i]);

      result += toCopy;

      lastIndexReplaced = indices[i];
      if (countCopy != null) countCopy--;
      if (countCopy != null && countCopy == 0) break;
    }

    result += originalCopy.sublist(lastIndexReplaced + from.length);
  } else {
    for (int i = skip; i < indices.length; i++) {
      if (i == skip) {
        result += originalCopy.sublist(indices[i] + from.length);
      } else {
        result =
            originalCopy.sublist(indices[i] + from.length, indices[i - 1]) +
                result;
      }

      result = toCopy + result;

      lastIndexReplaced = indices[i];
      if (countCopy != null) countCopy--;
      if (countCopy != null && countCopy == 0) break;
    }

    result = originalCopy.sublist(0, lastIndexReplaced) + result;
  }

  if (recursive && (countCopy == null || countCopy > 0)) {
    if (result.length < original.length ||
        countIterable(
                original: original,
                sublist: from,
                overlap: false,
                equalityFunction: equalityFunction) <
            indices.length) {
      return replaceSublist(
        original: result,
        from: from,
        to: to,
        count: countCopy,
        skip: skip,
        recursive: recursive,
        reverse: reverse,
        equalityFunction: equalityFunction,
      );
    }
  }

  return result;
}

/// Replace a substring with another, any or all occurrences
String replaceSubstring({
  required String original,
  required Pattern from,
  required String to,
  required int? count,
  required int skip,
  required bool recursive,
  required bool reverse,
}) {
  if (skip < 0 || (count != null && count <= 0)) {
    return original;
  }

  RegExp regex = from is RegExp ? from : RegExp(RegExp.escape(from.toString()));

  List<Match> matches = getMatchesString(
    original: original,
    sub: regex,
    overlap: false,
    reverse: reverse,
    maxCount: count == null ? null : skip + count,
  );

  if (skip >= matches.length) {
    return original;
  }

  List<String> resultAsList = [];

  int? countCopy = count;
  int lastIndexReplaced = 0;

  if (!reverse) {
    for (int i = skip; i < matches.length; i++) {
      resultAsList.add(original.substring(
          i == skip
              ? 0
              : matches[i - 1].start + matches[i - 1].groups([0]).first!.length,
          matches[i].start));

      resultAsList.add(to);

      lastIndexReplaced = i;
      if (countCopy != null) countCopy--;
      if (countCopy != null && countCopy == 0) break;
    }

    resultAsList.add(original.substring(matches[lastIndexReplaced].start +
        matches[lastIndexReplaced].groups([0]).first!.length));
  } else {
    for (int i = skip; i < matches.length; i++) {
      if (i == skip) {
        resultAsList.add(original.substring(
            matches[i].start + matches[i].groups([0]).first!.length));
      } else {
        resultAsList.insert(
            0,
            original.substring(
                matches[i].start + matches[i].groups([0]).first!.length,
                matches[i - 1].start));
      }

      resultAsList.insert(0, to);

      lastIndexReplaced = i;
      if (countCopy != null) countCopy--;
      if (countCopy != null && countCopy == 0) break;
    }

    resultAsList.insert(
        0, original.substring(0, matches[lastIndexReplaced].start));
  }

  String result = resultAsList.join();
  if (recursive && (countCopy == null || countCopy > 0)) {
    if (result.length < original.length ||
        countSubstring(
              original: original,
              sub: from,
              overlap: false,
              reverse: reverse,
            ) <
            matches.length) {
      return replaceSubstring(
        original: result,
        from: from,
        to: to,
        count: countCopy,
        skip: skip,
        recursive: recursive,
        reverse: reverse,
      );
    }
  }

  return result;
}

/// Convert all numbers to int type
Iterable<int> toIntIterable({required Iterable<num> original}) {
  return original.map((element) => element.toInt());
}

/// Convert all numbers to rounded ints
Iterable<int> toRoundedIterable({required Iterable<num> original}) {
  return original.map((element) => element.round());
}

/// Convert all numbers to double type
Iterable<double> toDoublesIterable({required Iterable<num> original}) {
  return original.map((element) => element.toDouble());
}

/// Average (mean) of numbers.
double? averageOrNull(Iterable<num> original) {
  if (original.isEmpty) return null;

  return original.average;
}

/// Sum of all numbers
N? sumOrNull<N extends num>(Iterable<N> original) {
  if (original.isEmpty) return null;

  return original.sum as N;
}

/// String from average of character codes.
String averageString(String original) {
  if (original.isEmpty) {
    return '';
  }

  return chr(averageOrNull(original.codeUnits)!.round());
}

/// Sum based on character codes
String sumString(String original) {
  if (original.isEmpty) {
    return '';
  }

  return chr(sumOrNull(original.codeUnits)!);
}

/// Product based on character codes
String productString(String original) {
  if (original.isEmpty) {
    return '';
  }

  return chr(productOrNull(original.codeUnits)!);
}

/// Median of a list of numbers
double? medianOrNull({required Iterable<num> original}) {
  if (original.isEmpty) return null;

  final List<double> originalSorted =
      toDoublesIterable(original: original).toList();
  originalSorted.sort();
  final int len = originalSorted.length;

  if (originalSorted.length.isOdd) {
    return originalSorted[len ~/ 2];
  } else {
    return (originalSorted[len ~/ 2 - 1] + originalSorted[len ~/ 2]) / 2;
  }
}

/// Median of a String based on character codes
String medianString({required String original}) {
  if (original.isEmpty) {
    return '';
  }

  return chr(medianOrNull(original: original.codeUnits)!.round());
}

/// Show the frequency of each element
Map<T, int> frequenciesList<T>({
  required Iterable<T> original,
  required bool Function(T a, T b) equalityFunction,
}) {
  Map<T, int> result = {};

  final List<T> originalCopy = original.toList();

  List<int> indicesIncluded = [];
  for (int i = 0; i < original.length; i++) {
    if (indicesIncluded.contains(i)) continue;
    int occurrences = 1;
    for (int j = i + 1; j < original.length; j++) {
      if (indicesIncluded.contains(j)) continue;
      if (equalityFunction(originalCopy[i], originalCopy[j])) {
        occurrences++;
        indicesIncluded.add(j);
      }
    }
    result[originalCopy[i]] = occurrences;
  }

  return result;
}

/// Show the frequency of each character in a String
Map<String, int> frequenciesString(String original) {
  Map<String, int> result = {};

  String copy = nubString(original: original, charsToNub: null);
  for (int i = 0; i < copy.length; i++) {
    String current = copy[i];
    result.addAll({
      current: countSubstring(
        sub: current,
        original: original,
        overlap: false,
        reverse: false,
      )
    });
  }

  return result;
}

/// Sort map by ascending values
Map<K, V> ascendingValuesMap<K, V>(Map<K, V> data) {
  final sortedEntries = data.entries.toList()
    ..sort((a, b) {
      int valComparison;

      try {
        valComparison =
            (a.value as Comparable).compareTo((b.value as Comparable));
      } catch (_) {
        try {
          valComparison = '${a.value} ${a.runtimeType}'
              .compareTo('${b.value} ${b.runtimeType}');
        } catch (_) {
          valComparison = 0;
        }
      }

      if (valComparison != 0) {
        return valComparison;
      }

      int keyComparison = 0;

      try {
        keyComparison = (a.key as Comparable).compareTo((b.key as Comparable));
      } catch (_) {
        try {
          keyComparison = '${a.value} ${a.runtimeType}'
              .compareTo('${b.value} ${b.runtimeType}');
        } catch (_) {
          keyComparison = 0;
        }
      }

      return keyComparison;
    });

  return Map.fromEntries(sortedEntries);
}

/// Sort map by descending values
Map<K, V> descendingValuesMap<K, V>(Map<K, V> data) {
  final sortedEntries = data.entries.toList()
    ..sort((a, b) {
      int valComparison;

      try {
        valComparison =
            (b.value as Comparable).compareTo((a.value as Comparable));
      } catch (_) {
        try {
          valComparison = '${b.value} ${b.runtimeType}'
              .compareTo('${a.value} ${a.runtimeType}');
        } catch (_) {
          valComparison = 0;
        }
      }

      if (valComparison != 0) {
        return valComparison;
      }

      int keyComparison = 0;

      try {
        keyComparison = (a.key as Comparable).compareTo((b.key as Comparable));
      } catch (_) {
        try {
          keyComparison = '${a.value} ${a.runtimeType}'
              .compareTo('${b.value} ${b.runtimeType}');
        } catch (_) {
          keyComparison = 0;
        }
      }

      return keyComparison;
    });

  return Map.fromEntries(sortedEntries);
}

/// Sort map by ascending keys
Map<K, V> ascendingKeysMap<K, V>(Map<K, V> data) {
  final sortedEntries = data.entries.toList()
    ..sort((a, b) {
      int keyComparison;

      try {
        keyComparison = (a.key as Comparable).compareTo((b.key as Comparable));
      } catch (_) {
        try {
          keyComparison = '${a.value} ${a.runtimeType}'
              .compareTo('${b.value} ${b.runtimeType}');
        } catch (_) {
          keyComparison = 0;
        }
      }

      return keyComparison;
    });

  return Map.fromEntries(sortedEntries);
}

/// Sort map by descending keys
Map<K, V> descendingKeysMap<K, V>(Map<K, V> data) {
  final sortedEntries = data.entries.toList()
    ..sort((a, b) {
      int keyComparison;

      try {
        keyComparison = (b.key as Comparable).compareTo((a.key as Comparable));
      } catch (_) {
        try {
          keyComparison = '${b.value} ${b.runtimeType}'
              .compareTo('${a.value} ${a.runtimeType}');
        } catch (_) {
          keyComparison = 0;
        }
      }

      return keyComparison;
    });

  return Map.fromEntries(sortedEntries);
}

/// Maximum character in a String based on character codes
String maxString(String original) {
  return chr(original.codeUnits.maxOrNull?.round() ?? -1);
}

/// Minimum character in a String based on character codes
String minString(String original) {
  return chr(original.codeUnits.minOrNull?.round() ?? -1);
}

/// Most frequently occurring character.
Iterable<T> modeIterable<T>({
  required Iterable<T> original,
  required bool Function(T a, T b) equalityFunction,
}) sync* {
  if (original.isEmpty) return;

  Map<T, int> frequencies = frequenciesList(
    original: original,
    equalityFunction: equalityFunction,
  );
  int maxFrequency = frequencies.values.maxOrNull!.round();

  frequencies.removeWhere((key, value) => value != maxFrequency);
  yield* frequencies.keys;
}

/// Returns the most used characters
String modeString(String original) {
  return chrs(modeIterable(
    original: original.codeUnits,
    equalityFunction: normalEquals,
  ));
}

/// Returns all indices that meet given criteria
Iterable<int> indicesWhere<T>({
  required Iterable<T> original,
  required bool Function(T element) testFunction,
  required int? maxCount,
  required bool reverse,
}) sync* {
  if (maxCount != null && maxCount <= 0) return;

  final list = original.toList();
  int foundCount = 0;

  if (reverse) {
    for (int i = list.length - 1; i >= 0; i--) {
      if (testFunction(list[i])) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    }
  } else {
    for (int i = 0; i < list.length; i++) {
      if (testFunction(list[i])) {
        yield i;
        foundCount++;
        if (maxCount != null && foundCount >= maxCount) return;
      }
    }
  }
}

/// Returns all indices that meet given criteria
List<int> indicesWhereString({
  required String original,
  required bool Function(String char) testFunction,
  required int? maxCount,
  required bool reverse,
}) {
  List<int> result = [];

  int? countCopy = maxCount;
  for (int i = reverse ? original.length - 1 : 0;
      reverse ? i >= 0 : i < original.length;
      reverse ? i-- : i++) {
    if (testFunction(original[i])) {
      result.add(i);
      if (countCopy != null) countCopy--;
      if (countCopy == 0) return result;
    }
  }

  return result;
}

/// Checks for equality of multiple data types, including nested iterables.
///
/// By default, [1, 2] == [1, 2] returns false.
///
/// This checks DeepCollectionEquality().equals in both directions since
/// it is asymmetric.
bool symmetricDeepEquals(Object? e1, Object? e2) {
  return deepEquality.equals(e1, e2) && deepEquality.equals(e2, e1);
}

/// DeepCollectionEquality().equals
bool deepEquals(Object? e1, Object? e2) {
  return deepEquality.equals(e1, e2);
}

/// DeepCollectionEquality().equals in reverse since it is asymmetric
bool reverseDeepEquals(Object? e1, Object? e2) {
  return deepEquality.equals(e2, e1);
}

/// This would return false for iterables
bool normalEquals(Object? e1, Object? e2) {
  return e1 == e2;
}

const deepEquality = DeepCollectionEquality();
