# Heart


Extension methods for strings and iterables (lists, sets, etc.), inspired by Haskell.

Strings are treated as lists, and have many of the same functions.
###
Alphabetical list of features:
[addMissing](#keep-addMissing)
[after](#before-after-beforeWhere-afterWhere),
[afterWhere](#before-after-beforeWhere-afterWhere),
[any](#any-every),
[ascending](#ascending-descending),
[ascendingKeys](#methods-for-sorting-maps),
[ascendingValues](#methods-for-sorting-maps),
[average(orNull)](#Methods-for-numbers),
[backwards](#backwards),
[before](#before-after-beforeWhere-afterWhere),
[beforeWhere](#before-after-beforeWhere-afterWhere),
[chr](#chr-chrs),
[chrs](#chr-chrs),
[concat](#concat),
[count](#count),
[dec](#Methods-for-numbers),
[deepContains](#heart),
[descending](#ascending-descending),
[descendingKeys](#methods-for-sorting-maps),
[descendingValues](#methods-for-sorting-maps),
[div](#Methods-for-numbers),
[dropIndices](#keepIndices-dropIndices),
[every](#any-every),
[filter](#Equivalents-for-Dart-collection-methods),
[flatMap](#Equivalents-for-Dart-collection-methods),
[frequencies](#frequencies)
[group](#group-groupby),
[groupBy](#group-groupby),
[head](#head-tails-last-inits),
[inc](#Methods-for-numbers),
[inclusive](#rangelist-inclusivelist),
[inclusiveString](#rangestring-inclusivestring),
[indicesOf](#indicesOf-indicesWhere),
[indicesWhere](#indicesOf-indicesWhere),
[inits](#head-tails-last-inits),
[insertInOrder](#methods-for-numbers),
[intercalate](#intercalate-in-ter-kuh-late),
[interleave](#interleave),
[intersperse](#intersperse),
[is(Strictly)Lower](#isstrictlyupper-isstrictlylower),
[is(Strictly)Upper](#isstrictlyupper-isstrictlylower),
[keep](#keep-addMissing),
[keepIndices](#keepIndices-dropIndices),
[last](#head-tails-last-inits),
[max](#Methods-for-numbers),
[median(orNull)](#Methods-for-numbers),
[min](#Methods-for-numbers),
[mode](#mode),
[mult](#Methods-for-numbers),
[nub](#nub),
[product(OrNull)](#Methods-for-numbers),
[range](#rangelist-inclusivelist),
[rangeString](#rangestring-inclusivestring),
[removeWhitespace](#removewhitespace),
[replace](#replace),
[riffleIn](#rifflein-riffleout),
[riffleOut](#rifflein-riffleout),
[shuffled](#shuffled)
[splitAt](#splitat),
[startsWith](#startswith),
[subtract](#subtract-subtractall),
[subtractAll](#subtract-subtractall),
[sum(OrNull)](#Methods-for-numbers),
[tail](#head-tails-last-inits),
[tails](#head-tails-last-inits),
[toInts](#Methods-for-numbers),
[toDoubles](#Methods-for-numbers),
[toRounded](#Methods-for-numbers),
[toStrings](#tostrings),
[transform](#Equivalents-for-Dart-collection-methods),
[wordCount](#words-wordcount),
[words](#words-wordcount),
[zip(With)](#zip-zipWith),
[>, >=, <, <=, *](#operators-for-strings-and-iterables)


## Directions:

For methods that return lazy iterables, import ```heart.dart```.

For methods that return the same type (either List, Queue, QueueList, or Set), import ```heart_types.dart```. Examples below show List type. Sets may have unexpected behavior since they remove duplicates.

Note: For methods that check occurrences of elements in an iterable, the default in this package is to apply Dart's ```DeepCollectionEquality().equals``` in both directions since it is normally asymmetric (different answers are possible depending on the order of the arguments), but a custom ```equalityFunction``` can be used for these methods, such as:

```dart
[1, {2}, 3].deepContains([1, {2}]) // true

[1, {2}, 3].deepContains([1, {2}], equalityFunction: (a, b) => a == b) // false
/// Iterables are not equal with == operator
```

## Equivalents for Dart collection methods
Dart has methods that always return lazy iterables. The methods here can maintain their types if importing ```heart_types.dart```, and can apply to Strings.

The equivalents for ```map```, ```where```, and ```expand``` are ```transform```, ```filter```, and ```flatMap```, respectively.
```dart
[10, 11, 12].transform((e) => e % 3) // [1, 2, 0]
'abc'.transform((char) => char * 2) // 'aabbcc'

[10, 11, 12].filter((e) => e.isEven) // [10, 12]
'abc'.filter((char) => char < 'c') // 'ab'

[[1, 2], [3, 4]].flatMap((e) => e) // [1, 2, 3, 4]
```
(There is also ```filterIndexed```, ```filterType```, ```filterNot```, ```filterNotIndexed```, ```flatMapIndexed```)

```flatMapString``` and ```flatMapStringIndexed``` apply to an iterable of Strings and return a String:
```dart
['hello', 'world'].flatMapString((element) => [element]) // 'helloworld'
['hello', 'world'].flatMapStringIndexed((index, element) => [index.toString(), element]) // '0hello1world'
```
## Methods for numbers

To complement Dart's ```maxOrNull``` and ```minOrNull``` for iterables.

These return null if empty:
```dart
[4, 5, 6].sumOrNull // 15
[4, 5, 6].productOrNull // 120
[2, 2, 3, 9].averageOrNull // 4.0
[2, 2, 3, 9].medianOrNull // 2.5
```

Increment, decrement, multiply and divide each element:
```dart
[1, 2, 3].inc() // [2, 3, 4]
[1, 2, 3].inc(5) // [6, 7, 8]
[1, 2, 3].dec() // [0, 1, 2]
[1, 2, 3].dec(2) // [-1, 0, 1]
[1, 2, 3].mult(2) // [2, 4, 6]
[1, 2, 3].div(2) // [0, 1, 1]
<double>[1, 2, 3].div(2) // [0.5, 1.0, 1.5]
```
```insertInOrder``` inserts each new element before the first element that is greater than or equal:
```dart
[5, 3].insertInOrder([2, 1]) // [1, 2, 5, 3];
```
For Strings, ```sum```, ```product```, ```average```, ```median```, ```max```, ```min```, ```inc```, ```dec```, ```mult```, ```div```, and ```insertInOrder``` work by using character codes:

```dart
'abc'.inc() // 'bcd'
'abc'.average // 'b'
'MA'.insertInOrder('aJbc') // 'JMAabc'
```

Truncate, round, or convert to doubles:
```dart
[1.9, 2.9].toInts() // [1, 2]
[1.9, 2.9].toRounded() // [2, 3]
[1, 2].toDoubles() // [1.0, 2.0]
```

## Other methods
### mode
```mode``` returns all of the most common elements:
```dart
[2, 2, 3, 3, 9].mode() // [2, 3]
'aabbc'.mode // 'ab'
```



### ascending, descending
Sorting:
```dart
List<int> l = [4, 5, 1, 2, 3].ascending; // [1, 2, 3, 4, 5]
List<int> l2 = [4, 5, 1, 2, 3].descending; // [5, 4, 3, 2, 1]

String s = 'hello'.ascending; // 'ehllo'
String s2 = 'hello'.descending; // 'ollhe'
```

### backwards
Reverse a String or iterable:
```dart
List<int> l = [1, 2, 3].backwards; // [3, 2, 1]
String s = 'hello'.backwards; // 'olleh'
```

### indicesOf, indicesWhere
```indicesOf``` finds every index where a pattern occurs:
```dart
[1, 2, 1, 2, 1].indicesOf([1, 2, 1]) // [0]
// To include overlap:
[1, 2, 1, 2, 1].indicesOf([1, 2, 1], overlap: true) // [0, 2]
// To start from the right:
[1, 2, 1, 2, 1].indicesOf([1, 2, 1], reverse: true) // [2]

'hello'.indicesOf('ll') // [2]
```

```indicesWhere``` finds indices where a condition is true:
```dart
[1, 2, 3].indicesWhere((e) => e.isEven) // [1]
'oneTWO'.indicesWhere((c) => c.isUpper) // [3, 4, 5]
```
### count
Count occurrences of a pattern, with option to include overlap:
```dart
[1, 2, 1, 2, 1].count([1, 2, 1]) // 1
[1, 2, 1, 2, 1].count([1, 2, 1], overlap: true) // 2
'12121'.count('121', overlap: true) // 2
```

### frequencies
Map of frequencies of each element:
```dart
[1, 2, 3].frequencies() // {1: 1, 2: 1, 3: 1}
'aabc'.frequencies() // {'a': 2, 'b': 1, 'c': 1}
```


### before, after, beforeWhere, afterWhere
Get everything before or after input:
```dart
[1, 2, 3].before([2, 3]) // [1]
[1, 2, 3].beforeWhere((e) => e.isEven) // [1]

[1, 2, 3, 4].after([3]) // [4]
[1, 2, 3, 4].afterWhere((e) => e.isEven) // [3, 4]

'hello'.before('l') // 'he'
```
Optional parameters:
```dart
// Skip the first occurrence:
[1, 2, 3, 4, 3].before([3], skip: 1) // [1, 2, 3, 4]
// Include 3 in result:
[1, 2, 3, 4, 3].before([3], includeInResult: true) // [1, 2, 3]
// Start from the right:
[1, 2, 3, 4, 3].before([3], reverse: true) // [1, 2, 3, 4]
```

### startsWith
Dart already has this for Strings.
```dart
bool b = [1, 2, 3].startsWith([1, 2]); // true
```
### nub
Remove duplicates:
```dart
List<int> l = [1, 2, 1, 2].nub(); // [1, 2]
String s = 'hello'.nub(); // 'helo'
```
Optional paramater only nubs those elements:
```dart
[1, 1, 2, 2, 3, 3].nub([1, 2]) // [1, 2, 3, 3]
'aaabbbcc'.nub('ab') // 'abcc'
```


### intersperse
Inserts an item in between all other elements:
```dart
[1, 2, 3].intersperse([0, 0]) // [1, 0, 0, 2, 0, 0, 3]
'hello'.intersperse('-') // 'h-e-l-l-o'

// Note: 'replace' method with empty first argument has similar behavior:
'hello'.replace('', '-') // '-h-e-l-l-o-'
```
Optional parameters:

```dart
[1, 2, 3, 4].intersperse([0, 0], count: 1) // [1, 0, 0, 2, 3, 4]
[1, 2, 3, 4].intersperse([0, 0], count: 1, reverse: true) // [1, 2, 3, 0, 0, 4]
[1, 2, 3, 4].intersperse([0, 0], skip: 1) // [1, 2, 0, 0, 3, 0, 0, 4]
```
### any, every
(These already exist for iterables)
```dart
bool b = 'hello'.any((char) => char == 'h'); // true
bool b2 = 'hello'.every((char) => char == 'h'); // false
```

### replace
Remove all occurrences or replace with something else:
```dart
[1, 1, 2, 3].replace([1], []); // [2, 3]
[1, 1, 2, 3].replace([1, 1], [99]) // [99, 2, 3]

'aaaa'.replace('a', 'b') // 'bbbb'
```
Optional paramaters:
```dart
[1, 1, 1].replace([1], [3], count: 2) // [3, 3, 1]
[1, 1, 1].replace([1], [3], count: 1, reverse: true) // [1, 1, 3]
[1, 1, 1].replace([1], [3], skip: 1) // [1, 3, 3]
```
```recursive``` parameter will keep cycling through to remove the pattern again (but may stop to avoid infinite loops):
```dart
[3, 2, 2, 2, 1, 1, 1].replace([2, 1], [], recursive: true) // [3]
```

### keep, addMissing
```keep``` keeps all elements from the original that are also in input.
```dart
[1, 1, 2, 3].keep([1, 2]) // [1, 1, 2]
'hello'.keep('world'); // 'llo'
```
(Remove duplicates with ```nub```)

```addMissing``` adds elements that aren't already present.
It doesn't remove duplicates from original, but doesn't add duplicates from input.

```dart
[1, 1, 2, 3].addMissing([2, 3, 4, 4]) // [1, 1, 2, 3, 4]
'hello'.addMissing(' world') // 'hello wrd'
```
(Use ```nub``` to remove duplicates, and concatenate normally to keep duplicates.)

### keepIndices, dropIndices
```dart
[10, 11, 12].keepIndices([0, 2]) // [10, 12]
[10, 11, 12].dropIndices([0, 2]) // [11]
'123'.keepIndices([0, 2]) // '13'
'123'.dropIndices([0, 2]) // '2'
```

###  subtract, subtractAll
```subtract``` removes elements one at a time (like Haskell's \\\\):
```dart
[1, 1, 2, 2, 3].subtract([1, 3]) // [1, 2, 2]
[1, 1, 2, 2].subtract([1, 2, 3]) // [1, 2]
// ignores 3 since it is not in original list

'hello'.subtract('eo'); // 'hll'
```
```subtractAll``` removes all occurrences:
```dart
[1, 1, 2, 2].subtractAll([1]) // [2, 2]
'hello'.subtractAll('lo'); // 'he'
```

### head, tail(s), last, inits,
```head``` returns first element.

```tail``` returns everything but the first element.

```last``` returns the last element (Dart has this for iterables but not strings).

```dart
[1, 2, 3].head // 1
[].head // null
[1, 2, 3].tail // [2, 3]
[1].tail // []
[].tail // null

'hello'.head // 'h'
'hello'.tail // 'ello'
'hello'.last // 'o'
```

```tails```
returns a nested iterable by removing one element at a time from the beginning:
```dart
[1, 2, 3].tails // [[1, 2, 3], [2, 3], [3], []]

// inclusive function defined in this package
List<List<int>> twelveDaysOfChristmas = inclusiveList(12, 1).tails.backwards;
// [[], [1], [2, 1], [3, 2, 1], [4, 3, 2, 1], [5, 4, 3, 2, 1], [6, 5, 4, 3, 2, 1], [7, 6, 5, 4, 3, 2, 1], [8, 7, 6, 5, 4, 3, 2, 1], [9, 8, 7, 6, 5, 4, 3, 2, 1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]]

'hello'.tails
// ['hello', 'ello', 'llo', 'lo', 'o', '']
```

```inits```
returns a nested iterable by adding elements from the beginning:
```dart
[1, 2, 3].inits
// [[], [1], [1, 2], [1, 2, 3]]

'hi'.inits
// ['', 'h', 'hi']
```



### splitAt
Split an iterable or string into two:
```dart
[5, 6, 7, 8].splitAt(2); // [[5, 6], [7, 8]]
'hello'.splitAt(2) // ['he', 'llo'] 
```

### interleave
Combine by taking turns:
```dart 
[1, 2, 3].interleave([4, 5, 6]); 
// [1, 4, 2, 5, 3, 6]

'abc'.interleave('123')
// 'a1b2c3'
```

### riffleIn, riffleOut
Riffle shuffle: splits in half and interleaves them:

<img width="250" height="188" alt="riffle" src="https://github.com/user-attachments/assets/45d33db3-9d33-4c60-a3ec-87ea065daa93" />

```dart
List<int> l = [1, 2, 3, 4, 5, 6].riffleOut(); // [1, 4, 2, 5, 3, 6]
List<int> l2 = [1, 2, 3, 4, 5, 6].riffleIn(); // [4, 1, 5, 2, 6, 3]

'12345'.riffleOut(); // '14253'
'12345'.riffleIn(); // '31425'

// inverse goes back to original:
'14253'.riffleOut(inverse: true) // '12345'
```
### group, groupBy
```group``` combines consecutive elements together if they are equal:
```dart
[1, 2, 3, 3, 1].group() // [[1], [2], [3, 3], [1]]
'hello'.group() // ['h', 'e', 'll', 'o']
```
```groupBy``` combines consecutive elements if they meet criteria.
In this example, items are in the same sublist if they are less than the one after:
```dart
[1, 2, 3, 2, 1].groupBy((a, b) => a < b) 
// [[1, 2, 3], [2], [1]]

List<String> ls = 'HelLo'.groupBy((a, b) => a.isUpper && b.isLower);
// ['He', 'l', 'Lo']
```


### chr, chrs

```chr``` returns a String from a character code.

```chrs``` returns a String from a list of codes.

```dart
97.chr // 'a'
[97, 98].chrs // 'ab'

// .codeUnits converts back to codes
```



### toStrings
Convert all elements to Strings:
```dart
List<String> l = [1, 2, 3].toStrings(); // ['1', '2', '3']
```


## Methods for nested iterables

### concat
Concatenate nested iterable or Strings:
```dart
List<int> l = [[1, 2], [3, 4], [5, 6]].concat(); // [1, 2, 3, 4, 5, 6]
String str = ['hello', 'world'].concat(); // 'helloworld'
```

### intercalate (in-TER-kuh-late)

Inserts elements between iterables (or String between Strings) and concatenates the result:
```dart
List<int> l = [[1, 2], [3, 4], [5, 6]].intercalate([0, 0]);
// [1, 2, 0, 0, 3, 4, 0, 0, 5, 6]

String s = ['hello', 'world'].intercalate('-');
// 'hello-world'
```
Optional parameters:
```dart
[[1], [2], [3], [4]].intercalate([0, 0], count: 1) // [1, 0, 0, 2, 3, 4]
[[1], [2], [3], [4]].intercalate([0, 0], count: 1, reverse: true) // [1, 2, 3, 0, 0, 4]
[[1], [2], [3], [4]].intercalate([0, 0], skip: 1) // [1, 2, 0, 0, 3, 0, 0, 4]
```



### zip, zipWith
```zip``` takes in a nested iterable, returns a nested iterable where corresponding elements are paired together.
```dart
[[1, 2, 3], [4, 5, 6]].zip() // [[1, 4], [2, 5], [3, 6]]
['hello', 'world'].zip() // ['hw', 'eo', 'lr', 'll', 'od']
```
```zipWith``` performs a function between corresponding elements:
```dart
[[1, 2, 3], [4, 5, 6]].zipWith((args) => args[0] + args[1]) // [5, 7, 9]
['hello', 'world'].zipWith((args) => args[0] == args[1]) // [false, false, false, true, false]
```



## Other methods for Strings

### removeWhitespace
```dart
String s = '  hello \n world  '.removeWhitespace(); // 'helloworld'
```

### shuffled
```dart
String s = 'hello world'.shuffled() // edwl hlloro
```

### words, wordCount
```words``` returns a List of words without whitespace.

```wordCount``` takes the length of this List. Equivalent to ```.words.length```.

```dart
List<String> listOfWords = 'hello world'.words; // ['hello', 'world']
int w = 'hello world'.wordCount; // 2
```

### is(Strictly)Upper, is(Strictly)Lower


```dart
'hello world'.isLower // true
'hello world'.isStrictlyLower // false (because of space)
'HELLO WORLD'.isUpper // true
'HELLO WORLD'.isStrictlyUpper // false (because of space)
```


## Generating a list of numbers

### range(List), inclusive(List)
```range``` and ```inclusive``` generate a lazy iterable of numbers.
```rangeList``` and ```inclusiveList``` generate a List.


```dart
Iterable<int> l = range(5); // (0, 1, 2, 3, 4)
inclusive(5) // (0, 1, 2, 3, 4, 5)

range(-5) // (-4, -3, -2, -1, 0)
inclusive(-5) // (-5, -4, -3, -2, -1, 0)
range(0) // ()
inclusive(0) // (0)
```

With two arguments, ```inclusive``` includes the second one, ```range``` does not .

```dart
range(1, 5) // (1, 2, 3, 4)
inclusive(1, 5) // (1, 2, 3, 4, 5)
range(1, -2) // (1, 0, -1)
inclusive(1, -2) // (1, 0, -1, -2)
```
Third argument adds a step count:
```dart
range(1, 5, 2) // (1, 3)
inclusive(1, 5, 2) // (1, 3, 5)
range(1, -5, -2) // (1, -1, -3)
inclusive(1, -5, -2) // (1, -1, -3, -5)
```

### rangeString, inclusiveString
Arguments must have exactly one character:
```dart
rangeString('a', 'f') // 'abcde'
rangeString('c', 'a') // 'cb'
rangeString('a', 'g', 2) // 'ace'

inclusiveString('a', 'c') // 'abc'
inclusiveString('c', 'a') // 'cba'
inclusiveString('a', 'g', 2) // 'aceg'
```

## Operators for strings and iterables

### >, >=, <, <=, *

Compare elements in two iterables, starting at the beginning:
```dart
[1, 2, 3] > [1, 1, 3] // true
```
Compare strings according to their character codes:
```dart
'b' > 'a' // true
'hello' < 'hi' // true

['a', 1] >= ['b', 1] // false
```
(If elements cannot be compared, both >= and <= will return false.)

Repeat elements with ```*```:
```dart
List<int> l = [1, 2] * 3; // [1, 2, 1, 2, 1, 2]

// Dart has this for Strings:
String s = 'hello' * 3; // 'hellohellohello'
```


## Methods for sorting Maps
```dart
{9: 5, 1: 2, 4: 8}.ascendingKeys // {1: 2, 4: 8, 9: 5}
{9: 5, 1: 2, 4: 8}.descendingKeys // {9: 5, 4: 8, 1: 2}

{9: 5, 1: 2, 4: 8}.ascendingValues // {1: 2, 9: 5, 4: 8}
{9: 5, 1: 2, 4: 8}.descendingValues // {4: 8, 9: 5, 1: 2}
```
