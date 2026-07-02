/// Documentation for each method is for List type.
/// Methods may have unexpected behavior since Sets remove duplicates.
library;

import 'package:heart/heart.dart';

import 'helper.dart' as h;

/// Operators for Sets
extension HeartSetOperator<E> on Set<E> {
  /// Repeat n times.
  /// Dart already does this for Strings.
  /// [1, 2] * 3 returns [1, 2, 1, 2, 1, 2]
  Set<E> operator *(int n) {
    return h.cycleIterable(timesToRepeat: n, original: this).toSet();
  }
}

/// Extension methods for Sets
extension HeartSet<E> on Set<E> {
  /// Reverses a Set
  Set<E> get backwards => h.backwardsIterable(this).toSet();

  /// Returns a sorted iterable.
  ///
  /// [4, 1, 3].ascending returns [1, 3, 4].
  ///
  /// Uses .toString() as a fallback if Dart's .sort() method doesn't work.
  Set<E> get ascending => h.ascendingIterable(this).toSet();

  /// Returns a sorted iterable in reverse order.
  ///
  /// [1, 4, 3].descending returns [4, 3, 1].
  ///
  /// Uses .toString() as a fallback if Dart's .sort() method doesn't work.
  Set<E> get descending => h.descendingIterable(this).toSet();

  /// Returns a nested iterable by adding one element at a time, starting from the beginning.
  ///
  /// [1, 2, 3].inits returns [[], [1], [1, 2], [1, 2, 3]].
  ///
  /// [].inits returns [[]].
  Set<Set<E>> get inits => h.inits(this).toNestedSet();

  /// Removes the first element, keeps the "tail".
  ///
  /// [1, 2, 3].tail returns [2, 3].
  ///
  /// [1].tail returns [].
  ///
  /// [].tail returns null.
  Set<E>? get tail => h.tailIterable(this)?.toSet();

  /// Returns a nested iterable by removing one element at a time, starting from the beginning.
  ///
  /// [1, 2, 3].tails = ([1, 2, 3], [2, 3], [3], []).
  ///
  /// [].tails returns [[]].
  Set<Set<E>> get tails => h.tailsIterable(this).toNestedSet();

  /// Converts all elements to Strings.
  ///
  /// [1, 2, 3].toStrings() returns ['1', '2', '3'].
  Set<String> toStrings() {
    return h.toStringIterable(this).toSet();
  }

  /// Inserts an element in between each element.
  ///
  /// [1, 2, 3].intersperse([0]) returns [1, 0, 2, 0, 3].
  ///
  /// Optional [count] and [skip]:
  ///
  /// [1, 2, 3, 4].intersperse([0], count: 1) returns [1, 0, 2, 3, 4].
  ///
  /// [1, 2, 3, 4].intersperse([0], skip: 1) returns [1, 2, 0, 3, 0, 4].
  ///
  /// Returns original if [skip] is negative or too high, or if [count] <= 0.
  /// High [count] has no extra effect.
  ///
  /// Adds nothing if there are less than two elements.
  Set<E> intersperse(
    Iterable<E> elementsToAdd, {
    int? count,
    int skip = 0,
    bool reverse = false,
  }) {
    return h
        .intersperseIterable(
          elementsToAdd: elementsToAdd,
          original: this,
          count: count,
          skip: skip,
          reverse: reverse,
        )
        .toSet();
  }

  /// Splits into two after first [n] elements.
  ///
  /// [1, 2, 3].splitAt(1) = [[1], [2, 3]].
  ///
  /// If n <= 0, returns [[], this].
  ///
  /// If n >= this.length, returns [this, []].
  Set<Set<E>> splitAt(int n) {
    return h.splitAtIterable(index: n, original: this).toNestedSet();
  }

  /// Items are grouped together if they are equal to the one next to it.
  ///
  /// [1, 2, 3, 3, 1].group() returns [[1], [2], [3, 3], [1]].
  ///
  /// [1].group() returns [[1]].
  /// [].group() returns [].
  ///
  /// Default [h.symmetricDeepEquals] checks DeepCollectionEquality().equals in both directions since it is asymmetric,
  /// but [equalityFunction] allows a custom function to be used instead. For asymmetric
  /// equality functions, elements are compared left to right.
  Set<Set<E>> group(
      {bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals}) {
    return h
        .groupIterable(
          original: this,
          equalityFunction: equalityFunction,
        )
        .toNestedSet();
  }

  /// Items are grouped together if they meet the criteria
  /// that compares consecutive elements.
  ///
  /// [1, 2, 3, 2, 1].groupBy((a, b) => a < b) returns
  /// [[1, 2, 3], [2], [1]]. In this example, items are grouped together
  /// if they are less than the next one i.e. a < b.
  Set<Set<E>> groupBy(bool Function(dynamic a, dynamic b) groupFunction) {
    return h
        .groupByIterable(
          groupFunction: groupFunction,
          original: this,
        )
        .toNestedSet();
  }

  /// Removes the elements at the given indices.
  ///
  /// [10, 11, 12].dropIndices([0, 2]) returns [11].
  ///
  /// Invalid indices are ignored.
  Set<E> dropIndices(Iterable<int> indicesToDrop) {
    return h
        .dropIndicesIterable(
          original: this,
          indicesToDrop: indicesToDrop,
        )
        .toSet();
  }

  /// Removes duplicates.
  ///
  /// [1, 1, 2, 2, 3, 3].nub() returns [1, 2, 3].
  ///
  /// Optional parameter means .nub() will only
  /// apply to those elements:
  ///
  /// [1, 1, 1, 2, 2, 2, 3, 3, 3].nub([2, 3]) returns [1, 1, 1, 2, 3].
  ///
  /// Empty argument has no effect:
  /// [1, 1, 2, 2, 3, 3].nub([]) returns [1, 1, 2, 2, 3, 3].
  ///
  /// Nested lists:
  /// [[1,2], [1,2]].nub() returns [[1,2]].
  ///
  /// Default [h.symmetricDeepEquals] checks DeepCollectionEquality().equals in both directions since it is asymmetric,
  /// but [equalityFunction] allows a custom function to be used instead. For asymmetric
  /// equality functions, elements are compared left to right.
  Set<E> nub({
    Iterable<E>? elementsToNub,
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .nubIterable(
          original: this,
          elementsToNub: elementsToNub,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Adds elements from [elements] that are not in original value.
  ///
  /// [1, 2, 3].addMissing([2, 3, 4, 4]) returns [1, 2, 3, 4].
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from input value.
  ///
  /// Can use [nub] to remove duplicates, and can concatenate normally to keep duplicates.
  ///
  /// To check if an element is missing, default [h.symmetricDeepEquals] checks DeepCollectionEquality().equals in both directions since it is asymmetric,
  /// but [equalityFunction] allows a custom function to be used.
  /// For asymmetric equality functions, equality is checked from left to right.
  Set<E> addMissing(
    Iterable<E> elements, {
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .addMissingIterable(
          original: this,
          input: elements,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Keeps all elements that are also in [elementsToKeep].
  ///
  /// [1, 1, 2, 2].keep([1, 3, 5]) returns [1, 1].
  ///
  /// Keeps duplicates in original value. Duplicates in [elementsToKeep] have no effect.
  /// Can use [nub] to remove duplicates.
  ///
  /// Default [h.symmetricDeepEquals] uses DeepCollectionEquality().equals in both directions
  /// since it is normally asymmetric.
  /// Custom [equalityFunction] can be used to determine if elements are already present.
  /// Elements in [elementsToKeep] will be the second argument for asymmetric equality functions.
  Set<E> keep(
    Iterable<E> elementsToKeep, {
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .keepElements(
          original: this,
          input: elementsToKeep,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Returns elements at the given indices.
  ///
  /// [10, 11, 12].keepIndices([0, 2]) returns [10, 12].
  ///
  /// Invalid and repeat indices are ignored.
  Set<E> keepIndices(Iterable<int> indices) {
    return h.keepIndicesIterable(original: this, indices: indices).toSet();
  }

  /// Removes elements one at a time if they are present.
  ///
  /// [1, 2, 3, 1].subtract([1]) returns [2, 3, 1].
  ///
  /// [1, 2, 3, 1].subtract([1, 1]) returns [2, 3].
  ///
  /// [{1, 2}, {1, 2}, [3, 4]].subtract([{1, 2}]) returns [{1, 2}, [3, 4]].
  ///
  /// To determine which elements to subtract, [h.symmetricDeepEquals] uses DeepCollectionEquality().equals in both directions
  /// since normally it is asymmetrical.
  /// If using a custom [equalityFunction], elements are compared with the element in the original being the first argument,
  /// and element [elementsToSubtract] being the second.
  ///
  /// [subtractAll] can remove all occurrences of each element.
  Set<E> subtract(
    Iterable<E> elementsToSubtract, {
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .subtractIterable(
          original: this,
          elementsToRemove: elementsToSubtract,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Removes all elements if they are in [elementsToRemove].
  ///
  /// [1, 1, 2, 2, 3, 3].subtractAll([1, 2]) returns [3, 3].
  ///
  /// [{1,2}, {1,2}, [3,4]].subtractAll([{1,2}]) returns [[3,4]].
  ///
  /// To determine which elements to subtract, [h.symmetricDeepEquals] uses DeepCollectionEquality().equals
  /// in both directions since normally it is asymmetrical.
  /// If using a custom [equalityFunction], elements are compared with the element in the original
  /// being the first argument, and element in [elementsToSubtract] being the second.
  ///
  /// [subtract] would only remove one element at a time instead of all occurrences.
  Set<E> subtractAll(
    Iterable<E> elementsToRemove, {
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .iterableSubtractAll(
          original: this,
          elementsToRemove: elementsToRemove,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Replace [from] with [to].
  ///
  /// [1, 2, 1, 2, 3].replace([1, 2], []) returns [3].
  /// [1, 1, 1, 1].replace([1, 1], [4]) returns [4, 4].
  ///
  /// Optional [count] replaces that many occurrences:
  /// [1, 2, 1, 2].replace([1, 2], [], count: 1) returns [1, 2].
  ///
  /// High [count] replaces all occurrences:
  /// [1, 1, 1].replace([1], [2], count: 100) returns [2, 2, 2].
  /// [count] <= 0 returns original:
  /// [1, 1, 1].replace([1], [2], count: -100) returns [1, 1, 1].
  ///
  /// Empty [from] means [to] is inserted before and after each element:
  /// [1, 1, 1].replace([], [2]) returns [2, 1, 2, 1, 2, 1, 2].
  /// [].replace([], [1]) returns [1].
  ///
  /// Sometimes, removing elements can make the pattern reappear.
  /// [recursive] will cycle through to remove the pattern again, but will stop if number of occurrences
  /// or total length of iterable is not going down to avoid infinite loops:
  ///
  /// [3, 2, 2, 2, 1, 1, 1].replace([2, 1], [], recursive: true) returns [3].
  ///
  /// If [count] is not null, [recursive] will only apply until [count] occurrences are removed:
  /// [3, 2, 2, 2, 1, 1, 1].replace([2, 1], [], recursive: true, count: 2) returns [3, 2, 1].
  ///
  /// Default [h.symmetricDeepEquals] finds occurrences of [from] by checking DeepCollectionEquality().equals in
  /// both directions since it is normally asymmetric, but custom [equalityFunction]
  /// can be given that will compare elements in original to elements in [from].
  Set<E> replace(
    Iterable<E> from,
    Iterable<E> to, {
    int? count,
    int skip = 0,
    bool reverse = false,
    recursive = false,
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .replaceIterable(
          original: this,
          from: from,
          to: to,
          count: count,
          recursive: recursive,
          skip: skip,
          reverse: reverse,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Combines elements by taking turns.
  /// First element in original iterable is the first element of the result.
  ///
  /// [1, 2, 3].interleave([4, 5, 6]) returns [1, 4, 2, 5, 3, 6].
  ///
  /// Excess elements are added to the end:
  /// [1, 2, 3].interleave([4]) returns [1, 4, 2, 3].
  /// [4].interleave([1, 2, 3]) returns [4, 1, 2, 3].
  Set<E> interleave(Iterable<E> it) {
    return h.interleaveIterable(this, it).toSet();
  }

  /// Splits into two and uses [interleave] to combine, second half first.
  ///
  /// [1, 2, 3, 4, 5, 6].riffleIn() returns [4, 1, 5, 2, 6, 3].
  /// [1, 2, 3, 4, 5, 6].riffleOut() returns [1, 4, 2, 5, 3, 6].
  ///
  /// Odd number of elements:
  /// [1, 2, 3, 4, 5].riffleIn() returns [3, 1, 4, 2, 5].
  /// [1, 2, 3, 4, 5].riffleOut() returns [1, 4, 2, 5, 3].
  ///
  /// [inverse] goes back to original:
  /// [3, 1, 4, 2, 5].riffleIn(inverse: true) returns [1, 2, 3, 4, 5].
  Set<E> riffleIn({bool inverse = false}) {
    return h.riffleInIterable(original: this, inverse: inverse).toSet();
  }

  /// Splits into two and uses [interleave] to combine.
  ///
  /// [1, 2, 3, 4, 5, 6].riffleOut() returns [1, 4, 2, 5, 3, 6].
  /// [1, 2, 3, 4, 5, 6].riffleIn() returns [4, 1, 5, 2, 6, 3].
  ///
  /// Odd number of elements:
  /// [1, 2, 3, 4, 5].riffleOut() returns [1, 4, 2, 5, 3]
  /// [1, 2, 3, 4, 5].riffleIn() returns [3, 1, 4, 2, 5]
  ///
  /// [inverse] goes back to original:
  /// [1, 4, 2, 5, 3].riffleOut(inverse: true) returns [1, 2, 3, 4, 5].
  Set<E> riffleOut({bool inverse = false}) {
    return h.riffleOutIterable(original: this, inverse: inverse).toSet();
  }

  /// Returns everything before a given input:
  /// [1, 2, 3, 3].before([3, 3]) returns [1, 2].
  /// [1, 2, 3, 3].before([1]) returns [].
  /// [1, 2, 3, 3].before([]) returns [].
  ///
  /// Optional [skip] skips that many occurrences:
  /// [1, 2, 3, 3].before([3], skip: 1) returns [1, 2, 3].
  ///
  /// Returns first [skip] elements when [sub] is empty:
  /// [1, 2, 3, 4].before([], skip: 3) returns [1, 2, 3].
  ///
  /// [overlap] determines how occurrences are counted for [skip]:
  /// [1, 2, 1, 2, 1].before([1, 2, 1], skip: 1) returns the full list since there is only
  /// one non-overlapping occurrence of [1, 2, 1], but
  /// [1, 2, 1, 2, 1].before([1, 2, 1], skip: 1, overlap: true) returns [1, 2].
  ///
  /// If [sub] is present, [includeInResult] includes it at the end unless all occurrences are skipped:
  /// [1, 2, 3, 4, 5].before([3, 4], includeInResult: true) returns [1, 2, 3, 4].
  ///
  /// [reverse] counts occurrences from right to left:
  /// [1, 2, 1].before([1], reverse: true) returns [1, 2].
  ///
  /// Default [h.symmetricDeepEquals] counts occurrences by checking DeepCollectionEquality().equals in both
  /// directions since it is normally asymmetric, but custom [equalityFunction] can be given that will
  /// compare elements in original to elements in [sub].
  Set<E> before(
    Iterable<E> sub, {
    int skip = 0,
    bool overlap = false,
    bool includeInResult = false,
    bool reverse = false,
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .beforeIterable(
          original: this,
          sub: sub,
          skip: skip,
          overlap: overlap,
          includeInResult: includeInResult,
          reverse: reverse,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Return everything before a condition is met.
  /// [1, 2, 3].beforeWhere((e) => e == 3) returns [1, 2].
  ///
  /// Optional [skip] skips that many occurrences:
  /// [1, 2, 3, 4].beforeWhere((e) => e.isEven, skip: 1) returns [1, 2, 3].
  ///
  /// [reverse] counts occurrences from right to left:
  /// [1, 2, 3, 4].beforeWhere((e) => e.isEven, reverse: true) returns [1, 2, 3].
  ///
  /// [includeInResult] includes the target element in the result unless all occurrences were skipped:
  /// [1, 2, 3, 4].beforeWhere((e) => e.isEven, includeInResult: true) returns [1, 2].
  Set<E> beforeWhere(
    bool Function(E e) test, {
    int skip = 0,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h
        .beforeWhereIterable(
          original: this,
          test: test,
          skip: skip,
          reverse: reverse,
          includeInResult: includeInResult,
        )
        .toSet();
  }

  /// Returns everything after [sub].
  /// [1, 2, 3].after([1]) returns [2, 3].
  /// [1, 2, 3].after([1, 2]) returns [3].
  /// [1, 2, 3].after([]) returns [1, 2, 3].
  ///
  /// Optional [skip] skips that many occurrences:
  /// [1, 2, 1, 2, 3].after([1], skip: 1) returns [2, 3].
  /// [1, 2, 3].after([], skip: 1) returns [2, 3].
  ///
  /// If [sub] is present, [includeInResult] will include it at the beginning:
  /// [1, 2, 3].after([2], includeInResult: true) returns [2, 3].
  ///
  /// [overlap] determines how occurrences are counted for [skip]:
  /// [1, 2, 1, 2, 1, 2, 1].after([1, 2, 1], skip: 1) returns [], but
  /// [1, 2, 1, 2, 1, 2, 1].after([1, 2, 1], skip: 1, overlap: true) returns [2, 1].
  ///
  /// Default [h.symmetricDeepEquals] counts occurrences by checking DeepCollectionEquality().equals in both
  /// directions since it is normally asymmetric, but custom [equalityFunction] can be given that will
  /// compare elements in original to elements in [sub].
  Set<E> after(
    Iterable<E> sub, {
    int skip = 0,
    bool overlap = false,
    bool includeInResult = false,
    bool reverse = false,
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .afterIterable(
          original: this,
          sub: sub,
          skip: skip,
          overlap: overlap,
          reverse: reverse,
          includeInResult: includeInResult,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }

  /// Return everything after a condition is met.
  /// [1, 2, 3, 4].afterWhere((e) => e.isOdd) returns [2, 3, 4].
  ///
  /// Optional [skip] skips that many occurrences:
  /// [1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 1) returns [4].
  ///
  /// [reverse] counts occurrences from right to left:
  /// [1, 2, 3, 4].afterWhere((e) => e.isOdd, reverse: true) returns [4].
  ///
  /// [includeInResult] includes the target element in the result unless all occurrences were skipped:
  /// [1, 2, 3, 4].afterWhere((e) => e.isEven, includeInResult: true) returns [2, 3, 4].
  Set<E> afterWhere(
    bool Function(E e) test, {
    int skip = 0,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h
        .afterWhereIterable(
          original: this,
          test: test,
          skip: skip,
          reverse: reverse,
          includeInResult: includeInResult,
        )
        .toSet();
  }

  /// Returns the element(s) with the most occurrences.
  ///
  /// [1, 1, 2, 2, 3].mode() returns [1, 2].
  ///
  /// [].mode() returns [].
  ///
  /// Default [h.symmetricDeepEquals] compares DeepCollectionEquality().equals in both directions
  /// to count occurrences since it is normally asymmetric.
  /// Custom [equalityFunction] can be used which compares earlier elements to later elements.
  Set<E> mode({
    bool Function(E a, E b) equalityFunction = h.symmetricDeepEquals,
  }) {
    return h
        .modeIterable(
          original: this,
          equalityFunction: equalityFunction,
        )
        .toSet();
  }
}

/// Extension methods for a Set of Strings
extension HeartSetString on Set<String> {
  /// Pairs corresponding elements together.
  ///
  /// ['abc', '123'].zip() returns ['a1', 'b2', 'c3'].
  Set<String> zip() {
    return h.zipString(this).toSet();
  }

  /// Perform a function between corresponding characters.
  ///
  /// ['abc', 'axy'].zipWith((args) => args[0] == args[1]) returns [true, false, false].
  Set<R> zipWith<R>(R Function(List<String>) zipFunction) {
    return h.zipWithString(this, zipFunction).toSet();
  }
}

/// Extension methods for iterables inside of a Set
extension HeartSetIterable<E> on Set<Iterable<E>> {
  /// Pairs corresponding elements together.
  ///
  /// [['one', 'two', 'three'], [1, 2, 3]].zip() returns
  /// [['one', 1], ['two', 2], ['three', 3]].
  ///
  /// Sub-iterables must have same type of elements, or be the same type of iterable (List, Set, etc.)
  Set<Set<E>> zip() {
    return h.zipIterable(this).toNestedSet();
  }

  /// Returns an iterable by performing a function between corresponding elements
  /// of a nested iterable.
  ///
  /// [[1, 2, 3], [4, 5, 6]].zipWith((args) => args[0] + args[1]) returns [5, 7, 9].
  Set<R> zipWith<R>(R Function(List<E>) zipFunction) {
    return h.zipWithIterable(this, zipFunction).toSet();
  }

  /// Inserts an iterable in between iterables and concatenates the result.
  ///
  /// [[1], [2], [3], [4]].intercalate([0, 0]) returns [1, 0, 0, 2, 0, 0, 3, 0, 0, 4].
  ///
  /// Optional [count] and [skip]:
  /// [[1], [2], [3], [4]].intercalate([0, 0], count: 1) returns [1, 0, 0, 2, 3, 4].
  /// [[1], [2], [3], [4]].intercalate([0, 0], skip: 1) returns [1, 2, 0, 0, 3, 0, 0, 4].
  ///
  /// [reverse] starts the [count] from right to left:
  /// [[1], [2], [3], [4]].intercalate([0, 0], count: 1, reverse: true) returns [1, 2, 3, 0, 0, 4].
  ///
  /// Returns the original concatenated if [skip] is negative or too high, [count] <= 0, or
  /// original has less than two iterables.
  Set<E> intercalate(
    Iterable<E> input, {
    int? count,
    int skip = 0,
    bool reverse = false,
  }) {
    return h
        .intercalateIterable(
          sub: input,
          original: this,
          count: count,
          skip: skip,
          reverse: reverse,
        )
        .toSet();
  }

  /// Concatenate elements in nested iterable.
  ///
  /// [[1, 2], [3, 4]].concat() returns [1, 2, 3, 4].
  Set<E> concat() {
    return expand((e) => e).toSet();
  }
}

/// Extension methods for Set of numbers
extension HeartSetNum<N extends num> on Set<N> {
  /// Convert elements to truncated integers.
  ///
  /// [1.9, 2.9].toInts() returns [1, 2];
  /// [1.9, 2.9].toRounded() returns [2, 3].
  Set<int> toInts() {
    return h.toIntIterable(original: this).toSet();
  }

  /// Convert elements to rounded integers.
  ///
  /// [1.9, 2.9].toRounded() returns [2, 3].
  /// [1.9, 2.9].toInts() returns [1, 2].
  Set<int> toRounded() {
    return h.toRoundedIterable(original: this).toSet();
  }

  /// Convert elements to doubles.
  ///
  /// [1, 2].toDoubles() returns [1.0, 2.0].
  Set<double> toDoubles() {
    return h.toDoublesIterable(original: this).toSet();
  }

  /// Inserts each element in [numbersToInsert] before the first element that is >=
  ///
  /// [1.1, 4.4].insertInOrder([3.3, 2.2]) returns [1.1, 2.2, 3.3, 4.4].
  ///
  /// Does not sort the entire result. [ascending] or [descending] can sort.
  Set<N> insertInOrder(Iterable<N> numbersToInsert) {
    return h
        .insertInOrderNums(
          numbersToInsert: numbersToInsert,
          original: this,
        )
        .toSet();
  }

  /// Increment all values by [incrementAmount].
  ///
  /// [1, 2, 3].inc() returns [2, 3, 4].
  /// [1, 2, 3].inc(2) returns [3, 4, 5].
  /// [1, 2, 3].inc(-2) returns [-1, 0, 1].
  ///
  /// [incrementAmount] can be positive or negative.
  Set<N> inc([N? incrementAmount]) {
    return h
        .incrementIterable(
          original: this,
          increment: incrementAmount,
        )
        .toSet();
  }

  /// Decrement all values by [decrementAmount].
  ///
  /// [1, 2, 3].dec() returns [0, 1, 2].
  /// [1, 2, 3].dec(2) returns [-1, 0, 1].
  /// [1, 2, 3].dec(-2) returns [3, 4, 5].
  ///
  /// [decrementAmount] can be positive or negative.
  Set<N> dec([N? decrementAmount]) {
    return h
        .decrementIterable(
          original: this,
          decrement: decrementAmount,
        )
        .toSet();
  }

  /// Multiply all values by [multiplyBy]
  ///
  /// [1, 2, 3].mult(2) returns [2, 4, 6].
  Set<N> mult(N multiplyBy) {
    return h
        .multiplyIterable(
          original: this,
          n: multiplyBy,
        )
        .toSet();
  }

  /// Divide all values by [divideBy].
  ///
  /// [2, 4, 6].div(2) returns [1, 2, 3].
  ///
  /// If [N] is type int, resulting elements will be truncated.
  Set<N> div(N divideBy) {
    return h
        .divideIterable(
          original: this,
          n: divideBy,
          intsOnly: false,
        )
        .toSet();
  }
}

/// Extension methods for Set of integers
extension HeartSetInt on Set<int> {
  /// Divide all values by [divideBy].
  ///
  /// [2, 4, 6].div(2) returns [1, 2, 3].
  ///
  /// Resulting elements are truncated.
  Set<int> div(int divideBy) {
    return h
        .divideIterable(
          original: this,
          n: divideBy,
          intsOnly: true,
        )
        .toSet();
  }

  /// Inserts each element in [numbersToInsert] before the first element that is >=
  ///
  /// [1, 4].insertInOrder([3, 2]) returns [1, 2, 3, 4].
  ///
  /// Does not sort the entire result. [ascending] or [descending] can sort.
  Set<int> insertInOrder(Iterable<int> numbersToInsert) {
    return h
        .insertInOrderNums(
          numbersToInsert: numbersToInsert,
          original: this,
        )
        .toSet();
  }
}

/// Equivalents for Dart methods, but remain Set type when importing 'heart_types.dart'
extension HeartCollectionSet<E> on Set<E> {
  /// .map equivalent
  ///
  /// [10, 11, 12].transform((e) => e % 3) returns [1, 2, 0].
  Set<T> transform<T>(T Function(E e) toElement) => map(toElement).toSet();

  /// .mapIndexed equivalent
  ///
  /// [10, 11, 12].transformIndexed((index, element) => element + index) returns [10, 12, 14].
  Set<R> transformIndexed<R>(R Function(int index, E element) convert) =>
      mapIndexed(convert).toSet();

  /// .where equivalent
  ///
  /// [10, 11, 12].filter((e) => e.isEven) returns [10, 12].
  Set<E> filter(bool Function(E element) test) => where(test).toSet();

  /// .whereIndexed equivalent
  ///
  /// [2, 4].filterIndexed((index, element) => index.isEven && element.isEven) returns [2].
  Set<E> filterIndexed(bool Function(int index, E element) test) =>
      whereIndexed(test).toSet();

  /// .whereType equivalent.
  ///
  /// ```[2, '3', 4].filterType<int>()``` returns [2, 4].
  Set<T> filterType<T>() => whereType<T>().toSet();

  /// .whereNot equivalent
  ///
  /// [2, 3, 4].filterNot((e) => e.isEven) returns [3].
  Set<E> filterNot(bool Function(E element) test) => whereNot(test).toSet();

  /// .whereNotIndexed equivalent
  ///
  /// [0, 1, 2].filterNotIndexed((index, element) => element + index < 2) returns [1, 2].
  Set<E> filterNotIndexed(bool Function(int index, E element) test) =>
      whereNotIndexed(test).toSet();

  /// .expand equivalent
  ///
  /// [[1, 2], [3, 4]].flatMap((element) => element) returns [1, 2, 3, 4].
  Set<T> flatMap<T>(List<T> Function(E element) toElements) =>
      expand(toElements).toSet();

  /// .expandIndexed equivalent
  ///
  /// [[1, 2], [3, 4], [5, 6]].flatMapIndexed((index, element) => element * index)
  /// returns [3, 4, 5, 6, 5, 6].
  Set<R> flatMapIndexed<R>(Iterable<R> Function(int index, E element) expand) =>
      expandIndexed(expand).toSet();
}
