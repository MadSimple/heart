/// Extension methods, with extra functions at the bottom
library heart;

import 'helper/helper.dart' as h;

/// Compare dynamic iterables with deepEquals
extension HeartIterable on Iterable {
  ///Compare element by element.
  ///
  /// [1, 2, 3] > [1, 1, 5] returns true because 2 > 1.
  ///
  /// ['b', 1] > ['a', 1] returns true because 'b' > 'a'
  /// by [>] operator in [HeartString]
  ///
  /// [0, 0, 1] > [1, 1, 0] returns false.
  ///
  /// Also returns false if elements cannot be compared.
  bool operator >(Iterable it) {
    return h.greaterThanIterable(this, it);
  }

  ///Compare element by element.
  ///
  /// [1, 1, 2] >= [1, 1, 2] returns true.
  ///
  /// ['b', 1] >= ['a', 1] returns true.
  ///
  /// Returns false if elements cannot be compared.
  bool operator >=(Iterable it) {
    return h.greaterThanIterable(this, it) || h.deepEquals(this, it);
  }

  ///Compare element by element.
  ///
  /// [1, 2, 1] < [1, 1, 2] returns false.
  ///
  /// ['b', 1] < ['a', 1] returns false.
  ///
  /// Returns false if elements cannot be compared.
  bool operator <(Iterable it) {
    return h.greaterThanIterable(it, this);
  }

  ///Compare element by element.
  ///
  /// [1, 2, 1] <= [1, 1, 2] returns false.
  ///
  /// ['a', 1] <= ['b', 1] returns false.
  ///
  /// Returns false if elements cannot be compared.
  bool operator <=(Iterable it) {
    return h.greaterThanIterable(it, this) || h.deepEquals(it, this);
  }

  /// Returns true if iterable contains [element].
  ///
  /// By default, Dart does not check for nested iterables.
  /// [[1,2], [3,4]].contains([1,2]) returns false, however
  ///
  /// [[1,2], [3,4]].deepContains([1,2]) returns true.
  ///
  bool deepContains(var element) {
    return h.deepContains(this, element);
  }

  /// Returns true if iterable contains [element].
  ///
  /// By default, Dart does not check for nested iterables.
  /// [[1,2], [3,4]].contains([1,2]) returns false, however
  ///
  /// [[1,2], [3,4]].bigContains([1,2]) returns true.
  @Deprecated('Use \'deepContains\' instead.')
  bool bigContains(var element) {
    return h.bigContains(this, element);
  }

  /// Count number of occurrences in an iterable,
  /// using [deepEquals].
  ///
  /// [1, 2, 1].count(1) returns 2.
  ///
  /// [1, 2, {1, 2}].count({1, 2}) returns 1.
  int count(var element) {
    return h.countList(this, element);
  }
}

/// Extension methods that maintain types.
extension HeartIterableE<E> on Iterable<E> {
  /// Repeat elements n times.
  ///
  /// [1, 2] * 3 returns [1, 2, 1, 2, 1, 2]
  List<E> operator *(int n) {
    return h.cycleList(n, this);
  }

  /// Finds each index where element occurs.
  ///
  /// [1, 2, 1, 2, 1].elemIndices(1) returns [0, 2, 4].
  ///
  /// Uses [deepEquals] for nested iterables:
  /// [[1,2],[3,4]].elemIndices([1,2]) returns [0].
  List<int> elemIndices(E element) {
    return h.elemIndicesList(element, this);
  }

  /// Converts all elements to Strings.
  ///
  /// [1, 2, 3].toStringList() returns ['1','2','3'].
  List<String> toStringList() {
    return h.toStringList(this);
  }

  /// Returns the first element.
  ///
  /// Similar to .first, but returns null if there
  /// are no elements instead of throwing exception.
  E? head() {
    return h.headList(this);
  }

  /// Returns a List of Lists by adding one element at a time,
  /// starting from the beginning.
  ///
  /// [1,2,3,4].inits = [[], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4]]
  ///
  /// [].inits() returns [[]].
  List<List<E>> inits() {
    return h.initsList(this);
  }

  /// Removes the first element, keeps the "tail".
  ///
  /// [1, 2, 3].tail() returns [2, 3].
  ///
  /// [1].tail() returns [].
  ///
  /// [].tail() returns null.
  List<E>? tail() {
    return h.tailList(this);
  }

  /// Returns a List of Lists by removing one element at a time,
  /// starting from the beginning.
  ///
  /// [1,2,3].tails() = [[1, 2, 3], [2, 3], [3], []].
  ///
  /// [].tails() returns [[]].
  List<List<E>> tails() {
    return h.tailsList(this);
  }

  /// Inserts an element in between each element.
  ///
  /// [1, 2, 3].intersperse(0) returns [1, 0, 2, 0, 3].
  ///
  /// [1].intersperse(0) returns [1].
  List<E> intersperse(E element) {
    return h.intersperseList(element, this);
  }

  /// Splits into two Lists after first n elements.
  ///
  /// [1,2,3].splitAt(1) = [[1],[2,3]].
  ///
  /// If n<=0, returns [[], this].
  ///
  /// If n>= this.length, returns [this, []].
  ///
  /// [1,2,3].splitAt(4) = [[1, 2, 3], []].
  List<List<E>> splitAt(int n) {
    return h.splitAtList(n, this);
  }

  /// Items are in the same sublist if they are equal
  /// to the one next to it.
  ///
  /// [1, 2, 3, 3, 1].group() returns [[1], [2], [3, 3], [1]].
  ///
  /// [1].group() returns [[1]]
  /// Equivalent to .groupBy((a,b) => deepEquals(a,b)).
  List<List<E>> group() {
    return h.groupList(this);
  }

  /// Items are in the same sublist if they meet the criteria
  /// that compares consecutive elements.
  ///
  /// [1, 2, 3, 2, 1].groupBy((a, b) => a < b) returns
  /// [[1, 2, 3], [2], [1]]. In this example, items are in the same sublist
  /// if they are less than the next one i.e. a < b.
  List<List<E>> groupBy(bool Function(dynamic a, dynamic b) groupFunction) {
    return h.groupByList(groupFunction, this);
  }

  /// Returns a shuffled List.
  ///
  /// Dart's shuffle() method is void.
  ///
  /// Cryptographically secure option:
  /// [1,2,3,4,5].shuffled(cryptographicallySecure: true)
  List<E> shuffled({bool cryptographicallySecure = false}) {
    return h.shuffledList(this, cryptographicallySecure);
  }

  /// Removes first n elements.
  ///
  /// Similar to .sublist(), but won't give exception for
  /// invalid n. Returns empty List instead.
  List<E> drop(int n) {
    return h.dropList(n, this);
  }

  /// Removes elements until criteria not met.
  ///
  /// [1, 2, 3, 2, 1].dropWhile((element) => element < 3)
  /// returns [3, 2, 1]
  List<E> dropWhile(bool Function(E sub) dropFunction) {
    return h.dropWhileList(dropFunction, this);
  }

  /// Removes duplicates by using [deepEquals].
  ///
  /// [1, 1, 2, 2, 3, 3].nub() returns [1, 2, 3].
  ///
  /// Optional parameter means .nub() will only
  /// apply to those elements.
  ///
  /// [1, 1, 2, 2, 3, 3].nub([1, 3]) returns [1, 2, 2, 3]
  ///
  /// [[1,2], [1,2]].nub() returns [[1,2]]
  List<E> nub([Iterable<E>? it]) {
    return h.listNub(this, it);
  }

  /// Adds elements from input that aren't in original value.
  ///
  /// [1, 2, 3].union([2, 3, 4, 4]) returns [1, 2, 3, 4]
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from input value,
  ///
  /// Can use .nub() to remove duplicates,
  /// and can concatenate normally to keep duplicates.
  List<E> union(Iterable<E> l) {
    return h.unionList(this, l);
  }

  /// Keeps all values that are also in input String,
  /// using [deepEquals].
  ///
  /// [1, 1, 2, 2].intersect([1, 3, 5]) returns [1, 1].
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from input value.
  /// Can use .nub() to remove duplicates.
  ///
  /// [[1,2], 2, 3].intersect([[1,2]]) returns [[1,2]].
  ///
  List<E> intersect(Iterable<E> input) {
    return h.listIntersect(this, input);
  }

  /// Removes elements one at a time, using [deepEquals].
  ///
  /// [1, 2, 3, 1].subtract([1]) returns [2, 3, 1].
  ///
  /// [1, 2, 3, 1].subtract([1, 1]) returns [2, 3].
  ///
  /// [{1,2}, {1,2}, [3,4]].subtract([{1,2}])
  /// returns [{1,2}, [3,4]].
  List<E> subtract(Iterable<E> sublist) {
    return h.listSubtract(this, sublist);
  }

  /// Removes all elements if they are in [sublist].
  ///
  /// [1, 2, 3, 1, 2, 3].subtractAll([1, 2]) returns [3, 3].
  ///
  /// [{1,2}, {1,2}, [3,4]].subtractAll([{1,2}])
  /// returns [[3,4]], uses [deepEquals].
  List<E> subtractAll(Iterable<E> sublist) {
    return h.listSubtractAll(this, sublist);
  }

  /// Similar to .replaceFirst for Strings.
  ///
  /// [1, 1, 2, 3].replaceFirst(1, 99) returns [99, 1, 2, 3].
  ///
  /// [1, 1, 2, 3].replaceFirst(1, [99,100]) returns [99, 100, 1, 2, 3].
  ///
  /// [1, 1, 2, 3].replaceFirst(1) returns [1, 2, 3].
  List<E> replaceFirst(E from, [dynamic to]) {
    return h.replaceList(this, false, from, to);
  }

  /// Similar to .replaceAll for Strings.
  ///
  /// [1, 1, 2, 3].replaceAll(1, 99) returns [99, 99, 2, 3].
  ///
  /// [1, 1, 2, 3].replaceAll(1, [99, 100]) returns
  /// [99, 100, 99, 100, 2, 3].
  ///
  /// [1, 1, 2, 3].replaceAll(1) returns [2, 3].
  List<E> replaceAll(E from, [dynamic to]) {
    return h.replaceList(this, true, from, to);
  }

  /// Removes elements that don't meet criteria.
  ///
  /// [1, 2, 3, 3].filter((element) => element < 3)
  /// returns [1, 2].
  ///
  /// ['a1', 'a2', 'b1', 'b2'].filter((sub) => sub.startsWith('a'))
  /// returns ['a1', 'a2'].
  List<E> filter(bool Function(E element) filterFunction) {
    return h.filterList(filterFunction, this);
  }

  /// Reverses and returns a List.
  List<E> backwards() {
    return h.backwardsList(this);
  }

  /// Combines elements by taking turns.
  /// First element in original iterable is the first element of the result.
  ///
  /// [1, 2, 3].interleave([4, 5, 6])
  /// returns [1, 4, 2, 5, 3, 6].
  ///
  /// Excess elements are added to the end.
  ///
  /// [1, 2, 3].interleave([4])
  /// returns [1, 4, 2, 3]
  List<E> interleave(Iterable<E> it) {
    return h.interleaveList(this, it);
  }

  /// Splits into two and uses [interleave] to combine,
  /// second half first.
  ///
  /// [1, 2, 3, 4, 5, 6].riffleIn() returns
  /// [4, 1, 5, 2, 6, 3]
  List<E> riffleIn() {
    return h.riffleInList(this);
  }

  /// Splits into two and uses [interleave] to combine.
  ///
  /// [1, 2, 3, 4, 5, 6].riffleOut() returns
  /// [1, 4, 2, 5, 3, 6].
  List<E> riffleOut() {
    return h.riffleOutList(this);
  }
}

/// Extension methods that maintain types for nested iterables.
extension HeartIterableIterable<E> on Iterable<Iterable<E>> {
  /// Inserts an iterable in between iterables and
  /// concatenates the result.
  ///
  /// [[1, 2], [3, 4], [5, 6]].intercalate([0, 0])
  /// returns [1, 2, 0, 0, 3, 4, 0, 0, 5, 6].
  List<E> intercalate(Iterable<E> input) {
    return h.intercalateList(input, this);
  }

  /// Concatenate nested iterables.
  ///
  /// Creates a new List with all the elements combined.
  ///
  /// [[1, 2], [3, 4]].concat() returns [1, 2, 3, 4]
  List<E> concat() {
    return h.concatLists(this);
  }
}

/// Extension methods for collection of doubles
extension HeartIterableNum on Iterable<num> {
  /// Adds all the elements
  ///
  /// [1.1, 2.2, 3.3].sum() returns 6.6
  double sum() {
    return h.sumNum(this).toDouble();
  }

  /// Multiplies all numbers together
  double product() {
    return h.productNum(this).toDouble();
  }

  /// Returns a double even if inputs are ints.
  double average() {
    return h.listAverage(this);
  }

  /// Inserts [value] before the first element that is greater.
  ///
  /// [0, 5, 3].insertInOrder(4) returns [0, 4, 5, 3]
  ///
  /// Does not sort.
  /// Can use .ascending() or .descending() to sort.
  List<double> insertInOrder(double value) {
    return h.insertInOrder(value, this as List<double>);
  }

  ///Returns a List using Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// [1.1, 0.1, 3.1].ascending() returns [0.1, 1.1, 3.1].
  List<double> ascending() {
    return h.ascendingList(this as List<double>);
  }

  ///Returns a List that is the reverse of Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// [1.1, 0.1, 3.1].descending() returns [3.1, 1.1, 0.1].
  List<double> descending() {
    return h.descendingList(this as List<double>);
  }
}

/// Extension methods for collection of integers
extension HeartIterableInt on Iterable<int> {
  /// Sum integers.
  ///
  /// [1, 2, 3].sum() returns 6
  int sum() {
    return h.sumNum(this);
  }

  /// Returns a String from character codes.
  String chrs() {
    return h.chrs(this);
  }

  ///Returns a List using Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// [1, 0, 3].ascending() returns [0, 1, 3].
  List<int> ascending() {
    return h.ascendingList(this);
  }

  ///Returns the reverse of Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// [1, 0, 3].descending() returns [3, 1, 0]
  List<int> descending() {
    return h.descendingList(this);
  }

  /// Inserts [value] before the first element that is greater.
  ///
  /// [0, 5, 3].insertInOrder(4) returns [0, 4, 5, 3]
  ///
  /// Does not sort.
  /// Can use .ascending() or .descending() to sort.
  List<int> insertInOrder(int value) {
    return h.insertInOrder(value, this);
  }

  /// Multiplies elements together.
  int product() {
    return h.productNum(this).toInt();
  }
}

/// Extension methods for collection of Strings
extension HeartIterableString on Iterable<String> {
  /// Combines Strings with [substring] in between them.
  ///
  /// ['one', 'two', 'three'].intercalate('-')
  /// returns 'one-two-three'.
  String intercalate(String s) {
    return h.intercalateString(s, this);
  }

  /// Combines Strings into one.
  ///
  /// ['h', 'i'].concat() returns 'hi'
  String concat() {
    return h.concatStrings(this);
  }

  /// Combines separate Strings into one String, separated by spaces.
  ///
  /// ['hello','world'].unwords() returns 'hello world'
  String unwords() {
    return h.unwords(this);
  }

  ///Returns a List using Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// ['bravo', 'alpha', 'charlie'].ascending()
  /// returns ['alpha', 'bravo', 'charlie'].
  List<String> ascending() {
    return h.ascendingList(this as List<String>);
  }

  ///Returns the reverse of Dart's sort() method.
  ///
  /// Dart's sort() method by itself is void.
  ///
  /// ['bravo', 'alpha', 'charlie'].descending()
  /// returns ['charlie', 'bravo', 'alpha'].
  List<String> descending() {
    return h.descendingList(this as List<String>);
  }
}

/// Extension methods for Strings
extension HeartString on String {
  /// Increase each character by n code units.
  ///
  /// 'abc' ^ 1 returns 'bcd'.
  ///
  /// 'bcd' ^ (-1) returns 'abc'.
  String operator ^(int n) {
    return h.incrementString(this, n);
  }

  /// Average character based on character codes.
  /// 'abc'.average() returns 'b'.
  String average() {
    return h.averageString(this);
  }

  /// Sort a String based on character codes
  ///
  /// 'Hello, World!'.ascending() = ' !,HWdellloor'
  String ascending() {
    return h.sortedString(this);
  }

  /// Sort a String based on character codes in reverse order
  ///
  /// 'Hello, World!'.descending() = 'roollledWH,! '
  String descending() {
    return h.reversedSortedString(this);
  }

  /// By default, returns true if String contains no lowercase letters.
  ///
  /// (ignoreSymbols: false) will return false for any spaces,
  /// symbols, empty Strings, etc.
  ///
  /// 'HELLO WORLD'.isUpperCase() returns true;
  ///
  /// 'HELLO WORLD'.isUpperCase(ignoreSymbols: false)
  /// returns false because of space.
  ///
  /// 'Á'.isUpperCase(ignoreSymbols: false) returns true.
  /// Accented letters don't count as symbols.
  ///
  /// Empty String returns false if ignoreSymbols is false.
  bool isUpperCase({ignoreSymbols = true}) {
    return h.isUpperCase(this, ignoreSymbols);
  }

  /// By default, returns true if String contains no uppercase letters.
  ///
  /// (ignoreSymbols: false) will return false for any spaces,
  /// symbols, empty Strings, etc.
  ///
  /// 'hello world'.isLowerCase() returns true;
  ///
  /// 'hello world'.isLowerCase(ignoreSymbols: false) returns false.
  ///
  /// 'á'.isLowerCase(ignoreSymbols: false) returns true.
  /// Accented letters don't count as symbols.
  ///
  /// Empty String returns false if ignoreSymbols is false.
  bool isLowerCase({ignoreSymbols = true}) {
    return h.isLowerCase(this, ignoreSymbols);
  }

  /// Splits after n characters, returns a List of substrings
  ///
  /// 'hello'.splitAt(3) = ['hel', 'lo']
  ///
  /// Returns ['', this] for n<=0.
  /// 'hello'.splitAt(0) = ['', 'hello']
  ///
  /// Returns [this, ''] for n >= this.length
  /// 'hello'.splitAt(13) = ['hello', '']
  List<String> splitAt(int n) {
    return h.splitAtString(n, this);
  }

  /// Remove all whitespace from a String.
  ///
  /// .trim() only removes whitespace at beginning or end.
  ///
  /// 'hello world'.removeWhitespace()
  /// returns 'helloworld'.
  String removeWhitespace() {
    return h.removeWhitespace(this);
  }

  /// Returns a List of Strings that groups characters together
  /// if consecutive elements meet criteria.
  ///
  /// 'helloworld!'.groupBy((a, b) => a <= b)
  /// returns ['h', 'ellow', 'or', 'l', 'd', '!'],
  /// where each element is sorted by character codes.
  List<String> groupBy(bool Function(String a, String b) groupFunction) {
    return h.groupByString(groupFunction, this);
  }

  /// Returns a List of Strings that groups characters together
  /// if consecutive elements are equal
  ///
  /// Equivalent to groupBy((a, b) => a == b)
  ///
  /// 'aabbccabc'.group() returns ['aa', 'bb', 'cc', 'a', 'b', 'c']
  List<String> group() {
    return h.groupString(this);
  }

  /// Removes characters from a String until criteria not met.
  ///
  /// 'lowerUPPERlower'.dropWhile((char) =>
  /// char.isLowerCase())
  /// returns 'UPPERlower'.
  String dropWhile(bool Function(String sub) dropFunction) {
    return h.dropWhileString(dropFunction, this);
  }

  /// Removes repeat characters.
  ///
  /// 'Mississippi'.nub() returns 'Misp'
  ///
  /// Optional parameter will only apply
  /// .nub() function to those individual characters.
  ///
  /// 'Mississippi'.nub('is') returns 'Mispp'.
  /// Only 1 'i' and 1 's' are in return value.
  ///
  /// .nub('') will have no effect.
  String nub([String? charsToNub]) {
    return h.stringNub(this, charsToNub);
  }

  /// Separates the words in a String, and
  /// returns them in a List.
  ///
  /// Ignores whitespace.
  ///
  /// 'hello \n world'.words() returns ['hello', 'world']
  List<String> words() {
    return h.words(this);
  }

  /// Returns a List of all characters from a String.
  ///
  /// 'hello world'.letters() returns
  /// ['h', 'e', 'l', 'l', 'o', 'w', 'o', 'r', 'l', 'd'] without the space.
  ///
  /// 'hello world'.letters(keepWhitespace: true)
  /// returns ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
  List<String> letters({bool keepWhitespace = false}) {
    return h.letters(this, keepWhitespace);
  }

  /// Returns total number of characters in a String.
  /// Ignores whitespace by default.
  ///
  /// 'hello world'.letterCount() returns 10.
  ///
  /// 'hello world'.letterCount(keepWhitespace: false)
  /// returns 11, equivalent to .length
  ///
  /// If there is a substring, returns number of
  /// occurrences after [keepWhitespace] is applied.
  ///
  /// 'hello world'.letterCount(substring: 'o w')
  /// returns 0, but
  /// 'hello world'.letterCount(keepWhitespace: true,substring: 'o w')
  /// returns 1.
  int letterCount({bool keepWhitespace = false}) {
    return h.letterCount(this, keepWhitespace);
  }

  /// Returns numbers of words in String separated by whitespace.
  ///
  /// 'hello, world!'.wordCount() returns 2
  ///
  /// ''.wordCount() returns 0
  int wordCount() {
    return h.wordCount(this);
  }

  /// Count occurrences of a substring in a String.
  ///
  /// 'hello world'.count('l') returns 3.
  ///
  /// 'hello world'.count('ll') returns 1.
  int count(String substring) {
    return h.countString(substring, this);
  }

  /// Adds elements from [input] that aren't in original value.
  ///
  /// 'abc'.union('123') returns 'abc123'.
  ///
  /// 'hello'.union('hello') returns 'hello'.
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from [input],
  ///
  /// Can use .nub() to remove duplicates,
  /// and can concatenate normally to keep duplicates.
  String union(String input) {
    return h.unionString(this, input);
  }

  /// Keeps all values from original String that are also in [input].
  ///
  /// 'hello'.intersect('lo') returns 'llo'.
  ///
  /// Doesn't remove duplicates in original value, but doesn't add
  /// duplicates from input value.
  ///
  /// Can use .nub() to remove duplicates.
  String intersect(String input) {
    return h.stringIntersection(this, input);
  }

  /// Returns true if any of the characters meet criteria.
  ///
  /// 'hello'.any((character) => character == 'e') returns true.
  ///
  /// 'hello'.any((character) => character == 'a') returns false.
  bool any(bool Function(String substring) anyFunction) {
    return h.stringAny(anyFunction, this);
  }

  /// Returns true if all characters meet criteria.
  ///
  /// 'abab'.all((char) => char == 'a' || char == 'b')
  /// returns true.
  ///
  /// Returns false for empty Strings.
  bool every(bool Function(String element) allFunction) {
    return h.stringEvery(allFunction, this);
  }

  /// Shuffle a String, with option to make it
  /// cryptographically secure.
  String shuffled({cryptographicallySecure = false}) {
    return h.shuffledString(this, cryptographicallySecure);
  }

  /// Keeps characters of a String that meet criteria.
  ///
  /// 'hello'.filter((char) => char < 'i') returns 'he'.
  ///
  /// Only checks one character at a time, so this returns empty:
  /// 'hello'.filter((char) => char == 'llo').
  String filter(bool Function(String substring) filterFunction) {
    return h.filterString(filterFunction, this);
  }

  /// Puts a substring in between each character of a String.
  ///
  /// 'hello'.intersperse('-') returns 'h-e-l-l-o'
  ///
  /// '<' + 'hello'.intersperse('><') + '>'
  /// returns '<h><e><l><l><o>'
  String intersperse(String i) {
    return h.intersperseString(i, this);
  }

  /// Returns a List of all occurrences of [substring].
  ///
  /// 'hello'.elemIndices('l') returns [2, 3].
  ///
  /// 'hello'.elemIndices('ll') returns [2].
  ///
  /// 'hellllo'.elemIndices('ll') returns [2, 3, 4].
  ///
  /// 'hello'.elemIndices('a') returns [].
  List<int> elemIndices(String substring) {
    return h.elemIndicesString(substring, this);
  }

  /// Drops first n characters.
  ///
  /// Similar to .substring(n), but returns empty String
  /// for invalid n instead of throwing exception.
  String drop(int n) {
    return h.dropString(n, this);
  }

  /// Returns the first character.
  ///
  /// Same as .substring(0, 1), except returns null
  /// for empty String instead of error.
  String? head() {
    return h.headString(this);
  }

  /// Returns a List of Strings by adding one element
  /// at a time, starting from the beginning.
  ///
  /// 'hi'.inits() returns ['', 'h', 'hi'].
  ///
  /// ''.inits() returns [''].
  List<String>? inits() {
    return h.initsString(this);
  }

  /// Removes the first character, keeps the "tail".
  ///
  /// 'hello'.tail() returns 'ello'
  ///
  /// 'h'.tail() returns ''
  ///
  /// ''.tail() returns null
  ///
  /// Equivalent to .substring(1) except returns
  /// null for empty String instead of error.
  String? tail() {
    return h.tailString(this);
  }

  /// Returns a List of Strings by removing one character at a time,
  /// starting from the beginning.
  ///
  /// 'hello'.tails() returns
  /// ['hello', 'ello', 'llo', 'lo', 'o', '']
  List<String> tails() {
    return h.tailsString(this);
  }

  /// Returns last character of a String.
  ///
  /// 'hello'.last() returns 'o'.
  ///
  /// Returns null for empty String.
  String? last() {
    return h.lastString(this);
  }

  /// Removes each character in [charsToDelete] one time.
  ///
  /// 'hello'.subtract('l') returns 'helo'.
  ///
  /// Characters can be added multiple times to delete
  /// multiple characters.
  ///
  /// 'hello'.subtract('lol') returns 'he'.
  ///
  /// Use [subtractAll] to remove all instances.
  String subtract(String charsToDelete) {
    return h.stringSubtract(this, charsToDelete);
  }

  /// Removes all occurrences of each character in [charsToDelete].
  ///
  /// 'hello'.subtractAll('lo') returns 'he'.
  String subtractAll(String charsToDelete) {
    return h.stringSubtractAll(this, charsToDelete);
  }

  /// Adds characters from two Strings together by taking turns.
  /// First character in original String is first character
  /// in new String.
  ///
  /// 'one'.interleave('TWO')
  /// returns 'oTnWeO'.
  ///
  /// Excess characters are added to the end.
  ///
  /// 'one'.interleave('SEVEN')
  /// returns 'oSnEeVEN'.
  String interleave(String s) {
    return h.interleaveString(this, s);
  }

  /// Splits in half and interleaves together.
  ///
  /// '123456'.riffleOut() returns '142536'
  String riffleOut() {
    return h.riffleOutString(this);
  }

  /// Splits in half and interleaves second half first.
  ///
  /// '123456'.riffleIn() returns '412536'
  String riffleIn() {
    return h.riffleInString(this);
  }

  /// Inserts [substring] before the first character that is greater.
  ///
  /// 'hello'.insertInOrder('i') returns 'heillo'.
  ///
  /// If [substring] is more than one character, the first
  /// character is used to insert.
  ///
  /// 'hello'.insertInOrder('ice') returns 'heicello'.
  ///
  /// Does not sort.
  /// Can use .ascending() or .descending() to sort.
  String insertInOrder(String substring) {
    return h.insertInOrderString(substring, this);
  }

  /// Reverse a String.
  ///
  /// 'hello'.backwards() returns 'olleh'
  String backwards() {
    return h.backwardsString(this);
  }

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
    return h.greaterThanString(this, s) || this == s;
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
    return h.lessThanString(this, s) || this == s;
  }
}

/// Extension methods for integers
extension HeartInt on int {
  /// Returns character from character code.
  ///
  /// 97.chr() returns 'a'.
  String chr() {
    return h.chr(this);
  }
}

/// Generates a List of integers
///
/// For n>0,
/// nums(n) generates a List of n integers [0..n-1]
/// nums(5) = [0, 1, 2, 3, 4]
///
/// nums(-n) generates [-n+1..0]
/// nums(-5) = [-4, -3, -2, -1, 0]

/// nums(p,q) generates [p..q]
/// nums(1,5) = [1,2,3,4,5]
/// nums(1,-3) = [1, 0, -1, -2, -3]
///
/// nums (p,q,r) generates [p..q] with a step counter r.
/// Step counter must be positive.
/// nums(1, 5, 2) = [1, 3, 5]
///
/// nums(0) = []
List<int> nums(int a, [int? b, int? step]) {
  return h.nums(a, b, step);
}

/// Checks for equality of multiple data types, including nested iterables.
///
/// By default, [1, 2] == [1, 2] returns false.
/// Dart's separate listEquals doesn't work for
/// nested lists.
///
/// deepEquals([[1,2], {3,4}], [[1,2], {3,4}]) returns true.
bool deepEquals(var a, var b) {
  return h.deepEquals(a, b);
}

/// Checks for equality for nested iterables, Strings, and numbers.
///
/// By default, [1, 2] == [1, 2] returns false.
/// Dart's separate listEquals doesn't work for
/// nested lists.
///
/// bigEquals([[1,2], {3,4}], [[1,2], {3,4}]) returns true.
@Deprecated('Use \'deepEquals\' instead.')
bool bigEquals(var a, var b) {
  return h.bigEquals(a, b);
}

/// Takes in iterables, returns a list of lists where
/// corresponding elements are paired together.
///
/// zip([['one','two','three'], [1,2,3]])
/// returns [['one', 1], ['two', 2], ['three', 3]].
///
/// zip([['one','two','three'], [1]]) returns [['one', 1]].
/// Only one pair since [1] only has one element.
List<List<T>> zip<T>(Iterable<Iterable<T>> it) {
  return h.zipList(it);
}

/// Takes in an iterable of 2 iterables and performs a
/// function between corresponding elements.
///
/// zip2([[1,2,3],[4,5,6]], (a,b) => a+b)
/// returns [5, 7, 9].
///
/// May have to cast to another data type to use other methods:
/// zip2([[1,2,3],[4,5,6]], (a,b) => a+b).cast<int>().sum() = 21.
List zip2<T>(Iterable<Iterable<T>> it, dynamic Function(T a, T b) zipFunction) {
  return h.zip2(it, zipFunction);
}

/// Takes in an iterable with 3 iterables and performs a
/// function between corresponding elements.
///
/// zip3([[0,0,0],[1,1,1],[2,2,2]], (a,b,c) => a+b+c)
/// returns [3,3,3].
///
/// May have to cast to another data type to use other methods:
/// zip3([[0,0,0],[1,1,1],[2,2,2]], (a,b,c) => a+b+c).cast<int>().sum() = 9.
List zip3<T>(
    Iterable<Iterable<T>> it, dynamic Function(T a, T b, T c) zipFunction) {
  return h.zip3(it, zipFunction);
}

/// Takes in an iterable with 4 iterables and performs a
/// function between corresponding elements.
///
/// zip4([[0,0],[5,5],[10,10],[15,15]], (a,b,c,d) => a+b+c+d)
/// returns [30,30].
///
/// May have to cast to another data type to use other methods:
/// zip4([[0,0],[5,5],[10,10],[15,15]], (a,b,c,d) => a+b+c+d).cast<int>().sum() = 60.
List zip4<T>(Iterable<Iterable<T>> it,
    dynamic Function(T a, T b, T c, T d) zipFunction) {
  return h.zip4(it, zipFunction);
}
