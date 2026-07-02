## 0.6.0

Large rewrite. Code should be retested after upgrading.
README shows updated behavior for all methods.

* BREAKING: ```count``` for iterables takes in an iterable and not an element, and does not include
  overlap by default.
* BREAKING: ```indices``` changed to ```indicesOf``` and does not include overlap by default.
* BREAKING: ```replace``` requires 2 arguments.
* BREAKING: ```before``` and ```after``` have new parameters and behavior for edge cases. Also added
  ```beforeWhere``` and ```afterWhere```. ```after``` no longer starts from the end.
* BREAKING: Zip functions have been consolidated into two extension methods: ```zip```, and
  ```zipWith```.
* BREAKING: Removed ```letters``` and ```letterCount```.
* BREAKING: Removed ```drop```, added ```dropIndices```, ```keepIndices```.
* BREAKING: Removed ```isUpperCase``` and ```isLowerCase```. Use ```isUpper```,
  ```isStrictlyUpper```, ```isLower```, and ```isStrictlyLower```.
* BREAKING: ```insertInOrder``` for iterables takes in an iterable, and inserts all characters for Strings.
* BREAKING: Removed ```unwords```.
* BREAKING: ```intersperse``` takes in an iterable instead of an element.
* BREAKING: ```deepContains``` now takes in an iterable instead of an element.
* BREAKING: ```every``` returns true for empty String, same as for iterables.
* BREAKING: ```union``` is now ```addMissing```, ```intersect``` is now ```keep```.
* BREAKING: Removed ```^``` operator, added ```inc```, ```dec```, ```mult```, and ```div```.
* Added ```wordCount``` getter for Strings.
* Added ```toInts```, ```toRounded```, and ```toDoubles```.
* Added ```frequencies``` and sorting methods for Maps.
* Added equivalents for Dart collection methods.
* Added optional parameters for many methods.
* ```ascending``` and ```descending``` work for any types.
* ```chr``` and ```chrs``` return empty for invalid codes.
* Operators separated from other extension methods to make it easier to show/hide.
* Bug fix: ``inits`` for String is no longer nullable.

## 0.5.8

* README update

## 0.5.7

* BREAKING: ```shuffled``` now takes in an optional Random object

## 0.5.6

* Slight code changes, no functionality changed

## 0.5.5

* Methods for lists of numbers rewritten

## 0.5.4

* Updated repository in pubspec

## 0.5.3

* Slight optimizations to ```before``` and ```after```

## 0.5.2

* ```shuffled``` now has seed parameter

## 0.5.1

* README changes

## 0.5.0

* Added ```before``` and ```after```.
* Added ```startsWith``` for lists.
* Added ```indices``` to search for sublists. ```elemIndices``` deprecated.
* Added ```replace```. ```replaceFirst``` and ```replaceAll``` for lists are deprecated.
* ```intercalate``` now has optional count parameter.

## 0.4.4

* Documentation correction

## 0.4.3

* Documentation correction

## 0.4.2

* Documentation correction

## 0.4.1

* Changes to CHANGELOG and README

## 0.4.0

* ```range``` and ```inclusive``` added, ```nums``` deprecated
* ```rangeString``` and ```inclusiveString``` also added
* Moved helper.dart to src folder

## 0.3.0

* Min Dart SDK 2.19
* Fixed dangling comment in helper.dart

## 0.2.2

* Min Dart SDK lowered to 2.18

## 0.2.1

* Removed version constraint from collection dependency to resolve version pinning error

## 0.2.0

* ```bigEquals``` and ```bigContains``` are deprecated in favor of ```deepEquals``` and
  ```deepContains```

## 0.1.4

* README alphabetical links fixed

## 0.1.3

* Formatting file

## 0.1.2

* Documentation update

## 0.1.1

* Documentation update

## 0.1.0

* ```drop(-n)``` for String has no effect instead of returning empty
* Removed Flutter dependency, pure Dart
* Documentation updates

## 0.0.2

* Documentation update

## 0.0.1

* Initial release.