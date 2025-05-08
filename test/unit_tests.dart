import 'package:heart/heart.dart';
import 'package:test/test.dart';

// No separate test functions for straightforward methods.
// There is documentation for all functions, and failed
// tests can be pinpointed.
void main() {
  group('HeartIterable', () {
    test('Iterable extension methods', () {
      {
        final List l1 = [
          1,
          2,
          {3, 4}
        ];
        final List l2 = [
          1,
          2,
          {4, 5}
        ];
        final List l3 = [
          1,
          2,
          {4, 5}
        ];
        final List l4 = [
          1,
          2,
          {
            4,
            [4, 5]
          }
        ];
        expect(l1 * 2, [
          1,
          2,
          {3, 4},
          1,
          2,
          {3, 4}
        ]);
        expect(l2 > l1, true);
        expect(l2 >= l3, true);
        expect(l2 <= l3, true);
        expect(l4.deepContains({4, nums(4, 5)}), true);
        expect((l4 * 3).elemIndices({4, inclusive(4, 5)}), [2, 5, 8]);

        expect(l1.toStringList(), ['1', '2', '{3, 4}']);
        expect(l1.head(), 1);
        expect([].head(), null);
        expect([1].tail(), []);
        expect([].tail(), null);
        expect([1].tails(), [
          [1],
          []
        ]);
        expect([1, 2, 3].intersperse(0), [1, 0, 2, 0, 3]);
        expect(l4.splitAt(9), [l4, []]);
        expect(l4.splitAt(-9), [l4, []].backwards());

        final List<int> l5 = [1, 2, 3, 3, 2, 1];
        final List<List<int>> l6 = [
          [1],
          [2],
          [3, 3],
          [2],
          [1]
        ];
        final List<List<int>> l7 = [
          [1, 2, 3, 3],
          [2],
          [1]
        ];

        expect(l5.group(), l6);
        expect(l5.groupBy((a, b) => a <= b), l7);

        expect(l5.subtract([1]), l5.drop(1));
        expect(l5.dropWhile((element) => element < 3), l5.subtract([1, 2]));
        expect(l5.subtractAll([1, 2]), [3, 3]);

        expect(l5.nub(), [1, 2, 3]);
        expect(l5.nub([1]), [1, 2, 3, 3, 2]);
        expect(l5.nub([]), l5);
        expect(l6.nub(), [
          [1],
          [2],
          [3, 3]
        ]);
        expect(
            l6.nub([
              [1]
            ]),
            [
              [1],
              [2],
              [3, 3],
              [2]
            ]);

        expect([1, 1, 2, 3].union([2, 3, 4, 4]), [1, 1, 2, 3, 4]);
        expect(l5.union(l5), l5);

        final List<int> l8 = [1, 2, 3];
        expect([1, 1, 2, 3].replaceFirst(1, 99), [99, 1, 2, 3]);
        expect([1, 1, 2, 3].replaceFirst(1), [1, 2, 3]);
        expect([1, 1, 2, 3].replaceAll(1, 99), [99, 99, 2, 3]);
        expect([1, 1, 2, 3].replaceAll(1, [99, 100]), [99, 100, 99, 100, 2, 3]);
        expect([1, 1, 2, 3].replaceAll(1), [2, 3]);
        expect([1, 1, 2, 3].replaceAll(9, [1, 2]), [1, 1, 2, 3]);

        expect([1, 2, 3, 3].filter((element) => element < 3), [1, 2]);
        expect([].filter((element) => element < 3), []);

        expect(l8.interleave(l8), [1, 1, 2, 2, 3, 3]);

        expect([1, 2, 3, 4, 5].riffleIn(), [3, 1, 4, 2, 5]);
        expect([1, 2, 3, 4, 5].riffleOut(), [1, 4, 2, 5, 3]);

        expect([1, 2, 3].drop(-1), [1, 2, 3]);
      }
    });
  });

  group('HeartIterableIterable<E>', () {
    test('Extension methods for Iterables in Iterables', () {
      {
        final List<List<int>> l1 = [
          [1, 2],
          [3, 4],
          [5, 6]
        ];
        final List<List<int>> l2 = [
          [1, 2, 0, 0, 3, 4, 0, 0, 5, 6]
        ];

        expect(l1.intercalate([0, 0]), l2.concat());
      }
    });
  });
  group('HeartIterableNum', () {
    test('Extension methods for iterables with num elements', () {
      {
        expect([1.1, 2.2, 3.3].sum(), 6.6);
        expect(<double>[].sum(), 0.0);
        expect(<double>[].product(), 0.0);
        expect(<double>[1, 2, 3].product(), 6.0);
        expect(<double>[1, 2, 3].average(), 2.0);
        expect(<num>[].average(), 0);

        expect([0.0, 5.0, 3.0].insertInOrder(4), [0.0, 4.0, 5.0, 3.0]);

        expect([1.1, 0.1, 3.1].ascending(),
            [1.1, 0.1, 3.1].descending().backwards());
      }
    });
  });
  group('HeartIterableInt', () {
    test('Extension methods for iterables with int elements', () {
      {
        expect([1, 2, 3].sum(), 6);
        expect([97, 98].chrs(), 'ab');

        expect([1, 0, 3].ascending(), [1, 0, 3].descending().backwards());

        expect(<int>[1, 2, 3].product(), 6);
      }
    });
  });
  group('HeartIterableString', () {
    test('Extension methods for iterables with String elements', () {
      {
        expect(['one', 'two', 'three'].intercalate('-'), 'one-two-three');
        expect(<String>['hello'].intercalate(''), 'hello');
        expect(<String>[''].intercalate('abc'), '');

        expect(['h', 'i'].concat(), 'hi');
        expect([''].concat(), '');

        expect(['hello', 'world'].unwords(), 'hello world');

        expect(['world', 'hello'].ascending(),
            ['hello', 'world'].descending().backwards());
      }
    });
  });
  group('HeartString', () {
    test('Extension methods for Strings', () {
      {
        expect('' ^ 1, '');
        expect('abc' ^ 1, 'bcd');
        expect('b' ^ (-1), 'a');

        expect('abc'.average(), 'b');

        expect('bca'.ascending(), 'bca'.descending().backwards());
        expect('bca'.ascending(), 'abc');

        expect('HELLO WORLD'.isUpperCase(), true);
        expect('HELLO WORLd'.isUpperCase(), false);
        expect('HELLO WORLd'.isLowerCase(), false);
        expect('HELLO WORLD'.isUpperCase(ignoreSymbols: false), false);
        expect('helló'.isLowerCase(ignoreSymbols: false), true);
        expect('helló '.isLowerCase(ignoreSymbols: false), false);

        expect('hello'.splitAt(3), ['hel', 'lo']);
        expect('hello'.splitAt(0), ['', 'hello']);
        expect('hello'.splitAt(6), ['hello', '']);

        expect('hello \n \t \r world'.removeWhitespace(), 'helloworld');
        expect(''.removeWhitespace(), '');

        expect(''.groupBy((a, b) => a <= b), []);
        expect(''.group(), []);
        expect('helloworld!'.groupBy((a, b) => a <= b),
            ['h', 'ellow', 'or', 'l', 'd', '!']);
        expect('aabbccabc'.group(), ['aa', 'bb', 'cc', 'a', 'b', 'c']);

        expect('aabbccabc'.dropWhile((char) => char < 'b'), 'bbccabc');
        expect(''.dropWhile((char) => char < 'b'), '');
        expect(''.drop(1), '');
        expect(''.drop(-1), '');

        expect('Mississippi'.nub(), 'Misp');
        expect(''.nub('abc'), '');
        expect('Mississippi'.nub('is'), 'Mispp');
        expect('Mississippi'.nub(''), 'Mississippi');

        expect('hello \n world'.words(), ['hello', 'world']);
        expect(''.words(), []);
        expect(''.wordCount(), 0);
        expect('hello  \n world'.wordCount(), 2);
        expect(''.letters(), []);
        expect('h i'.letters(), ['h', 'i']);
        expect('h i'.letters(keepWhitespace: true), ['h', ' ', 'i']);
        expect(''.letterCount(keepWhitespace: true), 0);
        expect('h i'.letterCount(keepWhitespace: false), 2);
        expect('h i'.letterCount(keepWhitespace: true), 3);

        expect(''.count(''), 0);
        expect('abc'.count(''), 0);
        expect('abca'.count('abc'), 1);
        expect('abca'.count('a'), 2);

        expect(''.union('a'), 'a');
        expect('aa'.union('a'), 'aa');
        expect('aa'.intersect('a'), 'aa');
        expect('aa'.intersect(''), '');
        expect('aa'.intersect('aaab'), 'aa');

        expect('hello'.any((character) => character == 'e'), true);
        expect(''.any((character) => character == 'e'), false);
        expect('hello'.every((character) => character == 'e'), false);
        expect(''.every((character) => character == ''), false);

        expect('hello'.filter((char) => char == 'llo'), '');
        expect('hello'.filter((char) => char == 'llo'), '');

        expect('hello'.intersperse('-'), 'h-e-l-l-o');
        expect(''.intersperse('-'), '');

        expect('hello'.elemIndices('l'), [2, 3]);
        expect('hello'.elemIndices('ll'), [2]);
        expect('hello'.elemIndices('a'), []);

        expect('hello'.drop(-1), 'hello');

        expect('hello'.head(), 'h');
        expect(''.head(), null);
        expect(''.inits(), ['']);
        expect('h'.inits(), ['', 'h']);
        expect('h'.tail(), '');
        expect('h'.tails(), ['h', '']);
        expect(''.tails(), ['']);
        expect(''.last(), null);

        expect('hello'.subtract('l'), 'helo');
        expect('hello'.subtract('ll'), 'heo');
        expect('hello'.subtractAll('l'), 'heo');
        expect(''.subtractAll('l'), '');
        expect(''.subtractAll(''), '');

        expect('one'.interleave('SEVEN'), 'oSnEeVEN');
        expect('one'.interleave(''), 'one');

        expect('one'.riffleIn(), 'noe');
        expect('12345'.riffleIn(), '31425');
        expect('one'.riffleOut(), 'oen');
        expect('12345'.riffleOut(), '14253');

        expect(''.insertInOrder('0'), '0');
        expect(''.insertInOrder(''), '');
        expect('ABC'.insertInOrder('a'), 'aCBA'.backwards());

        expect('h' > 'a', true);
        expect('h' >= 'a', true);
        expect('h' <= 'a', false);
        expect('h' < 'a', false);
      }
    });
  });

  group('HeartInt', () {
    test('Extension methods for ints', () {
      expect(97.chr(), 'a');
    });
  });

  group('Others', () {
    test('Other helper functions', () {
      {
        expect(nums(3), [0, 1, 2]);
        expect(nums(-3), [-2, -1, 0]);
        expect(nums(-3, 1), [-3, -2, -1, 0, 1]);
        expect(nums(1, 5, 3), [1, 4]);
        expect(nums(1, -5, 3), [1, -2, -5]);
        expect(nums(1, 1), [1]);
        expect(nums(0), []);
        expect(nums(0), range(0));
        expect(nums(5), range(5));
        expect(nums(-5), range(-5));
        expect(nums(-1, 5), inclusive(-1, 5));
        expect(nums(5, -1), inclusive(5, -1));
        expect(nums(-1, 5, 1), inclusive(-1, 5, 1));
        expect(nums(-1, 5, 2), inclusive(-1, 5, 2));
        expect(nums(5, -1, 2), inclusive(5, -1, -2));
        expect(nums(-1, -1, 2), inclusive(-1, -1, 2));
        expect(() => nums(-1, 5, -100), throwsArgumentError);
        expect(inclusive(0), [0]);
        expect(inclusive(1), [0, 1]);
        expect(inclusive(-1), [-1, 0]);
        expect(inclusive(3), [0, 1, 2, 3]);
        expect(inclusive(-3), [-3, -2, -1, 0]);
        expect(inclusive(1, 3), [1, 2, 3]);
        expect(inclusive(1, 2, 1), [1, 2]);
        expect(inclusive(0, 0), [0]);
        expect(inclusive(0, 0, 0), [0]);
        expect(inclusive(-1, 2), [-1, 0, 1, 2]);
        expect(inclusive(-3, -1), [-3, -2, -1]);
        expect(inclusive(2, -1), [-1, 0, 1, 2].backwards());
        expect(inclusive(1, -3), [1, 0, -1, -2, -3]);
        expect(inclusive(-1, 2, 2), [-1, 1]);
        expect(inclusive(-1, -3), [-1, -2, -3]);
        expect(inclusive(-1, -3, -2), [-1, -3]);
        expect(inclusive(1, -3, -2), [1, -1, -3]);
        expect(inclusive(-1, -3, -3), [-1]);
        expect(inclusive(-1, -1, -50), [-1]);
        expect(inclusive(-3, -1, 1), [-3, -2, -1]);
        expect(inclusive(-3, -6, -2), [-3, -5]);
        expect(inclusive(-3, 1, 2), [-3, -1, 1]);
        expect(inclusive(1, 1, -100), [1]);
        expect(inclusive(-3, -7, -2), [-3, -5, -7]);
        expect(inclusive(-3, -7, -99), [-3]);
        expect(() => inclusive(4, 5, -3), throwsArgumentError);
        expect(() => inclusive(4, 5, 0), throwsArgumentError);
        expect(() => inclusive(5, 4, 3), throwsArgumentError);
        expect(() => inclusive(-3, -5, 0), throwsArgumentError);
        expect(inclusiveString('a', 'z'), 'abcdefghijklmnopqrstuvwxyz');
        expect(inclusiveString('b', 'a'), 'ba');
        expect(inclusiveString('a', 'c', 1), 'abc');
        expect(inclusiveString('c', 'a', -1), 'cba');
        expect(inclusiveString('c', 'a', -2), 'ca');
        expect(inclusiveString('a', 'a', -100), 'a');
        expect(inclusiveString('a', 'a', 100), 'a');
        expect(inclusiveString('a', 'g', 2), 'aceg');
        expect(() => inclusiveString('aa', 'b'), throwsArgumentError);
        expect(() => inclusiveString('a', 'b', -1), throwsArgumentError);
        expect(() => inclusiveString('b', 'a', 1), throwsArgumentError);
        expect(range(0), []);
        expect(range(1), [0]);
        expect(range(-1), [0]);
        expect(range(-2), [-1, 0]);
        expect(range(3), [0, 1, 2]);
        expect(range(-3), [-2, -1, 0]);
        expect(range(1, 3), [1, 2]);
        expect(range(-3, -3), []);
        expect(range(-3, -6), [-3, -4, -5]);
        expect(range(1, -3), [1, 0, -1, -2]);
        expect(range(-2, 2, 2), [-2, 0]);
        expect(range(-3, -7, -2), [-3, -5]);
        expect(range(0, -3), [0, -1, -2]);
        expect(range(3, -2), [3, 2, 1, 0, -1]);
        expect(range(-2, 1), [-2, -1, 0]);
        expect(range(1, 1), []);
        expect(range(1, 1, 1), []);
        expect(range(1, 2, 1), [1]);
        expect(range(1, 2, 99), [1]);
        expect(range(1, 5, 2), [1, 3]);
        expect(range(1, 1, -100), []);
        expect(range(-2, 2, 3), [-2, 1]);
        expect(range(-2, 1, 3), [-2]);
        expect(range(0, 5, 1), range(5));
        expect(range(-5, 0, 1), inclusive(-5, -1));
        expect(range(0, -4, -2), [0, -2]);
        expect(range(-3, -3, 100), []);
        expect(range(-3, -4, -100), [-3]);
        expect(() => range(-3, -4, 100), throwsArgumentError);
        expect(() => range(-3, -4, 0), throwsArgumentError);
        expect(() => range(-3, 3, -100), throwsArgumentError);
        expect(() => range(-3, 3, 0), throwsArgumentError);
        expect(rangeString('a', 'b'), 'a');
        expect(rangeString('b', 'a'), 'b');
        expect(rangeString('a', 'c', 1), 'ab');
        expect(rangeString('c', 'a', -1), 'cb');
        expect(rangeString('a', 'z', 2), 'acegikmoqsuwy');
        expect(rangeString('a', 'g', 2), 'ace');
        expect(inclusiveString('a') == rangeString('b'), true);
        expect(() => rangeString('aa', 'b'), throwsArgumentError);
        expect(() => rangeString('a', 'b', -1), throwsArgumentError);
        expect(() => rangeString('b', 'a', 1), throwsArgumentError);

        expect(
            deepEquals([
              [1, 2],
              {3, 4}
            ], [
              [1, 2],
              {3, 4}
            ]),
            true);

        expect(
            [
              [1, 2],
              {3, 4}
            ].deepContains({3, nums(4, 4).first}),
            true);

        final List l1 = ['one', 'two', 'three'];
        final List l2 = [1, 2, 3];
        final List l3 = [
          ['one', 1],
          ['two', 2],
          ['three', 3]
        ];

        expect(zip([l1, l2]), l3);

        expect(
            zip2([
              [1, 2, 3],
              [4, 5, 6]
            ], (a, b) => a + b),
            [5, 7, 9]);
        expect(
            zip3([
              [0, 0, 0],
              [1, 1, 1],
              [2, 2, 2]
            ], (a, b, c) => a + b + c).cast<int>().sum(),
            9);
        expect(
            zip4([
              [0, 0],
              [5, 5],
              [10, 10],
              [15, 15]
            ], (a, b, c, d) => a + b + c + d).cast<int>().sum(),
            60);
      }
    });
  });
}
