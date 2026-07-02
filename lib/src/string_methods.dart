import 'dart:math';

import 'package:collection/collection.dart';

import 'helper.dart' as h;

/// Operators for Strings
extension HeartOperatorString on String {
  /// Compares code units character by character.
  ///
  /// 'h' > 'a' returns true.
  ///
  /// 'a' > 'b' returns false.
  ///
  /// 'hi' > 'hello' returns true.
  bool operator >(String s) {
    return h.greaterThanString(this, s);
  }

  /// Compares code units character by character.
  ///
  /// 'h' >= 'h' returns true.
  ///
  /// 'a' >= 'b' returns false.
  ///
  /// 'hi' >= 'hello' returns true.
  bool operator >=(String s) {
    return this == s || h.greaterThanString(this, s);
  }

  /// Compares code units character by character.
  ///
  /// 'h' < 'i' returns true.
  ///
  /// 'b' < 'a' returns false.
  ///
  /// 'hello' < 'hi' returns true.
  bool operator <(String s) {
    return h.lessThanString(this, s);
  }

  /// Compares code units character by character.
  ///
  /// 'h' <= 'h' returns true.
  ///
  /// 'b' <= 'a' returns false.
  ///
  /// 'hello' <= 'hi' returns true.
  bool operator <=(String s) {
    return this == s || h.lessThanString(this, s);
  }
}

/// Extension methods for Strings
extension HeartString on String {
  /// Returns character based on average of character codes.
  ///
  /// 'ac'.average returns 'b'.
  ///
  /// Empty string returns empty.
  String get average => h.averageString(this);

  /// Return character based on sum of character codes.
  ///
  /// '12'.sum returns 'c'.
  ///
  /// Empty string returns empty.
  String get sum => h.sumString(this);

  /// Return character based on product of character codes.
  ///
  /// 'ac'.product returns '▃'
  ///
  /// Empty string returns empty.
  String get product => h.productString(this);

  /// Returns the median of String by character codes:
  ///
  /// '401'.median returns '1'.
  ///
  /// Empty string returns empty.
  String get median => h.medianString(original: this);

  /// Returns a String that contains all of the most used characters.
  ///
  /// 'hello'.mode returns 'l'.
  ///
  /// ''.mode returns ''.
  String get mode => h.modeString(this);

  /// Return the character with greatest character code.
  ///
  /// 'hello'.max returns 'o'.
  ///
  /// Empty string returns empty.
  String get max => h.maxString(this);

  /// Return the character with lowest character code.
  ///
  /// 'hello'.min returns 'e'.
  ///
  /// Empty string returns empty.
  String get min => h.minString(this);

  /// Reverse a String.
  ///
  /// 'hello'.backwards returns 'olleh'
  String get backwards => h.backwardsString(this);

  /// Sort a String based on character codes.
  ///
  /// 'Hello, World!'.ascending = ' !,HWdellloor'
  String get ascending => h.ascendingString(this);

  /// Sort a String based on character codes in reverse order
  ///
  /// 'Hello, World!'.descending = 'roollledWH,! '
  String get descending => h.descendingString(this);

  /// Returns the first character. Same as .substring(0, 1),
  /// except returns null for empty String instead of error.
  String? get head => h.headString(this);

  /// Returns a List of Strings by adding one element at a time, starting from the beginning.
  ///
  /// 'hi'.inits() returns ['', 'h', 'hi'].
  ///
  /// ''.inits() returns [''].
  List<String> get inits => h.initsString(this);

  /// Removes the first character, keeps the "tail".
  ///
  /// 'hello'.tail returns 'ello'
  ///
  /// 'h'.tail returns ''
  ///
  /// ''.tail returns null
  ///
  /// Equivalent to .substring(1) except returns null for empty String instead of error.
  String? get tail => h.tailString(this);

  /// Returns a List of Strings by removing one character at a time, starting from the beginning.
  ///
  /// 'hello'.tails returns ['hello', 'ello', 'llo', 'lo', 'o', ''].
  ///
  /// ''.tails returns [''].
  List<String> get tails => h.tailsString(this);

  /// Returns last character of a String.
  ///
  /// 'hello'.last returns 'o'.
  ///
  /// Returns null for empty String.
  String? get last => h.lastString(this);

  /// Returns false if there are lowercase letters.
  ///
  /// 'HELLO'.isUpper returns true.
  ///
  /// 'HELLO '.isUpper returns true.
  /// 'HELLO '.isStrictlyUpper returns false.
  ///
  /// Empty strings return true.
  bool get isUpper => h.isUpper(this);

  /// Returns false if there are lowercase letters or non-letter characters.
  ///
  /// 'HELLO'.isStrictlyUpper returns true, but
  /// 'HELLO '.isStrictlyUpper returns false.
  /// 'HELLO '.isUpper returns true.
  ///
  /// Empty strings return true.
  bool get isStrictlyUpper => h.isStrictlyUpper(this);

  /// Returns false if there are uppercase letters.
  ///
  /// 'hello'.isLower returns true.
  ///
  /// 'hello '.isLower returns true.
  /// 'hello '.isStrictlyLower returns false.
  ///
  /// Empty strings return true.
  bool get isLower => h.isLower(this);

  /// Returns false if there are uppercase letters or non-letter characters.
  ///
  /// 'hello'.isStrictlyLower returns true.
  ///
  /// 'hello '.isStrictlyLower returns false.
  /// 'hello '.isLower returns true.
  ///
  /// Empty strings return true.
  bool get isStrictlyLower => h.isStrictlyLower(this);

  /// Returns a List of words in a String separated by whitespace.
  ///
  /// 'hello \n world!'.words returns ['hello', 'world!']
  List<String> get words => h.words(this);

  /// Returns numbers of words in String separated by whitespace.
  ///
  /// 'hello, world!'.wordCount returns 2.
  /// 'hello-world!'.wordCount returns 1.
  int get wordCount => h.words(this).length;

  /// Returns every index of [pattern], with option to include [overlap].
  ///
  /// 'ababa'.indicesOf('aba') returns [0].
  /// 'ababa'.indicesOf('aba', overlap: true) returns [0, 2] since the second 'a' can be reused.
  ///
  /// [reverse] checks from right to left:
  /// 'ababa'.indicesOf('aba', reverse: true) returns [2].
  /// 'ababa'.indicesOf('aba', reverse: true, overlap: true) returns [2, 0].
  List<int> indicesOf(
    Pattern pattern, {
    bool overlap = false,
    bool reverse = false,
  }) {
    return h.indicesOfString(
      original: this,
      sub: pattern,
      overlap: overlap,
      maxCount: null,
      reverse: reverse,
    );
  }

  /// Find all indices where a given condition is true. Only tests one character at a time.
  ///
  /// 'ONEtwo'.indicesWhere((char) => char.isUpper) returns [0, 1, 2].
  List<int> indicesWhere(bool Function(String element) testFunction) {
    return h.indicesWhereString(
      original: this,
      testFunction: testFunction,
      maxCount: null,
      reverse: false,
    );
  }

  /// Count occurrences of [pattern] in a String, with option to include [overlap].
  ///
  /// 'ababa'.count('a') returns 3.
  /// 'ababa'.count('aba') returns 1.
  /// 'ababa'.count('aba', overlap: true) returns 2 since the second 'a' can be reused.
  ///
  /// [reverse] checks matches starting from the end, which may give different answers for RegExp:
  /// '12121'.count(RegExp(r'12121|1')) returns 1, but
  /// '12121'.count(RegExp(r'12121|1'), reverse: true) returns 2.
  ///
  /// [indicesOf] shows where they occur.
  int count(
    Pattern pattern, {
    bool overlap = false,
    bool reverse = false,
  }) {
    return h.countSubstring(
      sub: pattern,
      original: this,
      overlap: overlap,
      reverse: reverse,
    );
  }

  /// Puts a substring in between each character of a String.
  ///
  /// 'hello'.intersperse('-') returns 'h-e-l-l-o'
  ///
  /// '(' + 'hello'.intersperse(')(') + ')'
  /// returns '(h)(e)(l)(l)(o)'
  ///
  /// Optional [skip], [count], and [reverse]:
  /// '1234'.intersperse('-', skip: 1) returns '12-3-4'.
  /// '1234'.intersperse('-', count: 1) returns '1-234'.
  /// '1234'.intersperse('-', skip: 1, count: 1) returns '12-34'.
  /// '1234'.intersperse('-', count: 1, reverse: true) returns '123-4'.
  ///
  /// Returns original String for skip < 0, or count <= 0.
  String intersperse(
    String substring, {
    int? count,
    int skip = 0,
    bool reverse = false,
  }) {
    return h.intersperseString(
      substring: substring,
      original: this,
      count: count,
      skip: skip,
      reverse: reverse,
    );
  }

  /// Splits after n characters, returns a List of substrings.
  ///
  /// 'hello'.splitAt(3) = ['hel', 'lo']
  ///
  /// Returns ['', this] for n <= 0.
  /// 'hello'.splitAt(0) = ['', 'hello']
  ///
  /// Returns [this, ''] for n >= this.length:
  /// 'hello'.splitAt(13) = ['hello', '']
  List<String> splitAt(int n) {
    return h.splitAtString(index: n, original: this);
  }

  /// Returns a List of Strings that groups characters together
  /// if consecutive elements are equal.
  ///
  /// 'aabbccabc'.group() returns ['aa', 'bb', 'cc', 'a', 'b', 'c'].
  ///
  /// Equivalent to groupBy((a, b) => a == b).
  List<String> group() {
    return h.groupString(this);
  }

  /// Returns a List of Strings that groups characters together
  /// if consecutive elements meet criteria.
  ///
  /// 'helloworld!'.groupBy((a, b) => a <= b) returns ['h', 'ellow', 'or', 'l', 'd', '!'],
  /// where each element is sorted by character codes.
  List<String> groupBy(bool Function(String a, String b) groupFunction) {
    return h.groupByString(groupFunction: groupFunction, original: this);
  }

  /// Removes the characters at the given indices.
  ///
  /// '01234'.dropIndices([0, 2, 4]) returns '13'.
  ///
  /// Invalid and repeat indices are ignored.
  String dropIndices(Iterable<int> indicesToDrop) {
    return h.dropIndicesString(original: this, indicesToDrop: indicesToDrop);
  }

  /// Removes repeat characters.
  ///
  /// 'Mississippi'.nub() returns 'Misp'
  ///
  /// Optional parameter will only apply
  /// .nub() to those individual characters.
  ///
  /// 'Mississippi'.nub('is') returns 'Mispp'. Only 1 'i' and 1 's' are in result.
  ///
  /// .nub('') will have no effect.
  ///
  /// [replace] can be used to remove the pattern 'is' instead
  /// of removing individual characters.
  String nub([String? charsToNub]) {
    return h.nubString(original: this, charsToNub: charsToNub);
  }

  /// Adds elements from [input] that aren't in original value.
  ///
  /// 'abc'.addMissing('a123') returns 'abc123'.
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from [input],
  ///
  /// Can use [nub] to remove duplicates, or concatenate normally to keep duplicates.
  String addMissing(String input) {
    return h.addMissingString(original: this, input: input);
  }

  /// Keeps all values from original String that are also in [input].
  ///
  /// 'hello'.keep('lo') returns 'llo'.
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from input value.
  ///
  /// Can use [nub] to remove duplicates.
  String keep(String input) {
    return h.keepString(original: this, input: input);
  }

  /// Returns the characters at the given indices.
  ///
  /// '0123'.keepIndices([0, 2]) returns '02'.
  ///
  /// Invalid and repeat indices are ignored.
  String keepIndices(Iterable<int> indices) {
    return h.keepIndicesString(original: this, indices: indices);
  }

  /// Removes each character in [charsToRemove] one time.
  ///
  /// 'hello'.subtract('l') returns 'helo'.
  ///
  /// Characters can be added multiple times to delete multiple characters.
  /// Extra characters in [charsToRemove] have no effect.
  ///
  /// 'hello'.subtract('lol') returns 'he'.
  ///
  /// Use [subtractAll] to remove all occurrences.
  ///
  /// [replace] can be used to remove a specific pattern instead of characters one at a time.
  String subtract(String charsToRemove) {
    return h.stringSubtract(original: this, charsToRemove: charsToRemove);
  }

  /// Removes all occurrences of each character in [charsToDelete].
  ///
  /// 'hello'.subtractAll('lo') returns 'he'.
  ///
  /// 'hello'.subtractAll('x') returns 'hello'.
  String subtractAll(String charsToDelete) {
    return h.stringSubtractAll(original: this, charsToRemove: charsToDelete);
  }

  /// Alternative to [replaceFirst] and [replaceAll].
  /// '111'.replace('1', '3') returns '333'.
  /// '1111'.replace('11', '3') returns '33'.
  /// '1212'.replace('1', '') returns '22'.
  ///
  /// Optional [count] replaces that many occurrences:
  /// '111'.replace('1', '3', count: 1) returns '311'.
  ///
  /// High [count] does not add more characters:
  /// '111'.replace('1', '2', count: 100) returns '222'.
  /// [count] negative or 0 returns the same String:
  ///
  /// [skip] skips occurrences: Negative skip has no effect.
  /// '111'.replace('1', '2', skip: 1) returns '122'.
  ///
  /// Replacing empty String inserts substring before and after each character:
  /// '111'.replace('', '2') returns '2121212'
  /// ''.replace('', '1') returns '1'
  ///
  /// Since replacing a pattern can make it reappear, [recursive] loops through again
  /// until [count] is satisfied or all occurrences are removed, but stops if result length
  /// and number of occurrences are not decreasing to prevent infinite loops.
  /// '01112220'.replace('12', '', recursive: true) returns '00'.
  /// '01112220'.replace('12', '', recursive: true, count: 2) returns '0120'.
  /// '01112220'.replace('12', '12', recursive: true) does nothing to prevent infinite loop.
  String replace(
    Pattern from,
    String to, {
    int? count,
    bool recursive = false,
    int skip = 0,
    bool reverse = false,
  }) {
    return h.replaceSubstring(
      original: this,
      from: from,
      to: to,
      count: count,
      recursive: recursive,
      reverse: reverse,
      skip: skip,
    );
  }

  /// Adds characters from two Strings together by taking turns.
  /// First character in original String is first character in result.
  ///
  /// '123'.interleave('456') returns '142536'.
  ///
  /// Excess characters are added to the end:
  /// 'one'.interleave('SEVEN') returns 'oSnEeVEN'.
  String interleave(String s) {
    return h.interleaveString(this, s);
  }

  /// Splits in half and interleaves second half first.
  /// First character in original String is second character in new String.
  ///
  /// '123456'.riffleIn() returns '415263'.
  /// '123456'.riffleOut() returns '142536'.
  ///
  /// For odd number of elements:
  /// '12345'.riffleIn() returns '31425'.
  /// '12345'.riffleOut() returns '14253'.
  ///
  /// [inverse] goes back to original:
  /// '31425'.riffleIn(inverse: true) returns '12345'.
  String riffleIn({bool inverse = false}) {
    return h.riffleInString(original: this, inverse: inverse);
  }

  /// Splits in half and interleaves together.
  /// First character in original String is first character in new String.
  ///
  /// '123456'.riffleOut() returns '142536'.
  /// '123456'.riffleIn() returns '415263'.
  ///
  /// For odd number of elements:
  /// '12345'.riffleOut() returns '14253'.
  /// '12345'.riffleIn() returns '31425'.
  ///
  /// [inverse] goes back to original:
  /// '14253'.riffleOut(inverse: true) returns '12345'.
  String riffleOut({bool inverse = false}) {
    return h.riffleOutString(original: this, inverse: inverse);
  }

  /// Returns all characters before [pattern].
  /// '1233'.before('33') returns '12'.
  /// '1233'.before('1') returns ''.
  /// '1233'.before('') returns ''.
  ///
  /// [reverse] starts from the end:
  /// '1020'.before('0', reverse: true) returns '102'.
  ///
  /// Optional [skip] skips that many occurrences:
  /// '1233'.before('3', skip: 1) returns '123'.
  ///
  /// Returns first [skip] elements when [sub] is empty:
  /// '1234'.before('', skip: 3) returns '123'.
  ///
  /// [overlap] determines how elements are counted:
  /// '12121'.before('121', skip: 1) returns the full String since there is only
  /// one non-overlapping occurrence of '121', but
  /// '12121'.before('121', skip: 1, overlap: true) returns '12'.
  ///
  /// If [sub] is present and not skipped, [includeInResult] includes it at the end:
  /// '12345'.before('34', includeInResult: true) returns '1234'.
  String before(
    Pattern sub, {
    int skip = 0,
    bool overlap = false,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h.beforeSubstring(
        original: this,
        sub: sub,
        skip: skip,
        overlap: overlap,
        reverse: reverse,
        includeInResult: includeInResult);
  }

  /// Returns all elements before a condition is met.
  /// '123'.beforeWhere((c) => c == '3') returns '12'.
  ///
  /// [reverse] checks occurrences starting from the end:
  /// '1232'.beforeWhere((c) => c == '2', reverse: true) returns '123'.
  ///
  /// Optional [skip] skips that many occurrences:
  /// '1232'.beforeWhere((c) => c == '2', skip: 1) returns '123'.
  ///
  /// Occurrences are only checked one character at at time, so this test would be false everywhere:
  /// '1234'.beforeWhere((c) => c == '23') returns '1234'.
  ///
  /// [includeInResult] includes element at the end of the result unless all occurrences were skipped:
  /// '123'.beforeWhere((c) => c == '2', includeInResult: true) returns '12'.
  String beforeWhere(
    bool Function(String e) test, {
    int skip = 0,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h.beforeWhereString(
      original: this,
      test: test,
      skip: skip,
      includeInResult: includeInResult,
      reverse: reverse,
    );
  }

  /// Returns all characters after [pattern].
  /// 'abc'.after('a') returns 'bc'.
  /// 'abc'.after('ab') returns 'c'.
  /// 'abc'.after('') returns 'abc'.
  ///
  /// [reverse] starts from the end:
  /// '0102'.after('0', reverse: true) returns '2'.
  ///
  /// Optional [skip] skips that many occurrences:
  /// '123145'.after('1', skip: 1) returns '45'.
  ///
  /// [overlap] changes how occurrences are counted:
  /// '121212145'.after('121', skip: 1) returns '45'.
  /// '121212145'.after('121', skip: 1, overlap: true) returns '2145'.
  ///
  /// [includeInResult] includes [sub] in result unless all occurrences were skipped:
  /// '123'.after('2', includeInResult: true) returns '23'
  String after(
    Pattern sub, {
    int skip = 0,
    bool overlap = false,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h.afterSubstring(
      original: this,
      sub: sub,
      skip: skip,
      overlap: overlap,
      reverse: reverse,
      includeInResult: includeInResult,
    );
  }

  /// Return everything after a condition is met.
  /// '12324'.afterWhere((char) => char == '2') returns '324'.
  ///
  /// [reverse] checks occurrences starting from the end:
  /// '12324'.afterWhere((char) => char == '2', reverse: true) returns '4'.
  ///
  /// Optional [skip] skips that many occurrences:
  /// '12324'.afterWhere((char) => char == '2', skip: 1) returns '4'.
  ///
  /// [test] only checks one character at at time, so this test would return false and have no effect:
  /// '1234'.afterWhere((char) => char == '23') returns ''.
  ///
  /// [includeInResult] includes element in the result unless all occurrences were skipped:
  /// '123'.afterWhere((char) => char == '2', includeInResult: true) returns '23'.
  String afterWhere(
    bool Function(String e) test, {
    int skip = 0,
    bool includeInResult = false,
    bool reverse = false,
  }) {
    return h.afterWhereString(
        original: this,
        test: test,
        skip: skip,
        reverse: reverse,
        includeInResult: includeInResult);
  }

  /// Return a Map that shows the frequencies of each character:
  ///
  /// '622'.frequencies() returns {'6': 1, '2': 2}.
  Map<String, int> frequencies({
    bool Function(String a, String b) equalityFunction = h.normalEquals,
  }) {
    return h.frequenciesList(
        original: split(''), equalityFunction: equalityFunction);
  }

  /// Inserts each character in [charsToInsert] before the first character
  /// that has a greater character code.
  ///
  /// 'MA'.insertInOrder('aJbc') returns 'JMAabc'.
  ///
  /// Does not sort the entire String. [ascending] or [descending] can sort.
  String insertInOrder(String charsToInsert) {
    return h.insertInOrderString(
      charsToInsert: charsToInsert,
      original: this,
    );
  }

  /// Increase each character by [n] code units.
  ///
  /// 'abc'.inc() returns 'bcd'.
  ///
  /// 'bcd'.inc(-1) returns 'abc'.
  String inc([int n = 1]) {
    return h.incrementString(original: this, increment: n);
  }

  /// Decrease each character by [n] code units.
  ///
  /// 'bcd'.dec() returns 'abc'.
  ///
  /// 'bcd'.dec(-1) returns 'cde'.
  String dec([int n = 1]) {
    return h.incrementString(original: this, increment: -n);
  }

  /// Multiply all values by [multiplyBy].
  ///
  /// '2'.mult(2) returns 'd' since '2' code unit is 50, 'd' is 100.
  String mult(num multiplyBy) {
    return h.multiplyString(
      original: this,
      n: multiplyBy,
    );
  }

  /// Divide character codes by [divideBy].
  ///
  /// 'ac'.div(2) returns '12'.
  String div(num divideBy) {
    return h.divideString(
      original: this,
      n: divideBy,
    );
  }

  /// Remove all whitespace from a String.
  ///
  /// 'hello world'.removeWhitespace() returns 'helloworld'.
  String removeWhitespace() {
    return h.removeWhitespace(this);
  }

  /// Returns true if any of the characters meet criteria.
  ///
  /// 'hello'.any((char) => char == 'e') returns true.
  ///
  /// 'hello'.any((char) => char == 'a') returns false.
  ///
  /// Returns false for empty Strings.
  bool any(bool Function(String substring) anyFunction) {
    return h.stringAny(anyFunction: anyFunction, original: this);
  }

  /// Returns true if all characters meet criteria.
  ///
  /// 'abab'.every((char) => char == 'a' || char == 'b')
  /// returns true.
  ///
  /// Returns true for empty Strings.
  bool every(bool Function(String element) allFunction) {
    return h.stringEvery(allFunction: allFunction, original: this);
  }

  /// Returns a shuffled String.
  ///
  /// Can specify a Random object:

  /// 'hello'.shuffled(Random.secure())
  String shuffled([Random? random]) {
    return h.shuffledString(original: this, random: random);
  }
}

/// Equivalents for Dart collection methods applied to Strings
extension HeartCollectionString on String {
  /// .map equivalent
  ///
  /// '12'.transform((c) => c * 2), '1122'.
  String transform(String Function(String e) toElement) =>
      split('').map(toElement).join('');

  /// .mapIndexed equivalent
  ///
  /// 'hi'.transformIndexed((index, char) => '$index$char') returns '0h1i'.
  String transformIndexed<R>(R Function(int index, String element) convert) =>
      split('').mapIndexed(convert).join('');

  /// .where equivalent
  ///
  /// 'ONEtwo'.filter((char) => char.isUpper) returns 'ONE'.
  String filter(bool Function(String element) test) =>
      split('').where(test).join('');

  /// .whereIndexed equivalent
  ///
  /// 'ONEtwo'.filterIndexed((index, char) => char.isUpper && index.isEven) returns 'OE'.
  String filterIndexed(bool Function(int index, String element) test) =>
      split('').whereIndexed(test).join('');

  /// .whereNot equivalent
  ///
  /// 'hello'.filterNot((char) => char == 'h') returns 'ello'.
  String filterNot(bool Function(String element) test) =>
      split('').whereNot(test).join('');

  /// .whereNotIndexed equivalent
  ///
  /// 'ONEtwo'.filterNotIndexed((index, char) => char.isUpper || index.isEven) returns 'to'.
  String filterNotIndexed(bool Function(int index, String element) test) =>
      split('').whereNotIndexed(test).join('');
}
