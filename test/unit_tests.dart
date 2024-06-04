import 'package:test/test.dart';
import 'package:heart/heart.dart';

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
        expect(l4.bigContains({4, nums(4, 5)}), true);
        expect((l4 * 3).elemIndices({4, nums(4, 5)}), [2, 5, 8]);

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

        expect([1, 2, 3].union([2, 3, 4, 4]), [1, 2, 3, 4]);
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
        expect('one'.riffleOut(), 'oen');

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

        expect(
            bigEquals([
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
            ].bigContains({3, 4}),
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
