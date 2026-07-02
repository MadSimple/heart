import 'dart:collection';

import 'package:heart/heart.dart';
import 'package:heart/src/helper.dart' show symmetricDeepEquals;
import 'package:test/test.dart';

bool isIterable(Iterable it) {
  return it is! List && it is! Queue && it is! Set;
}

bool isList(Iterable it) {
  return it is List && it is! QueueList;
}

void otherTest() {
  test('other_functions', () {
    expect(isIterable(inclusive(0)), true);
    expect(inclusive(0), [0]);
    expect(isList(inclusiveList(0)), true);
    expect(inclusiveList(0), [0]);
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
    expect(inclusive(2, -1), [-1, 0, 1, 2].backwards);
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
    expect(isIterable(range(0)), true);
    expect(range(0), []);
    expect(isList(rangeList(0)), true);
    expect(rangeList(0), []);
    expect(range(1), [0]);
    expect(range(-1), [0]);
    expect(range(-2), [-1, 0]);
    expect(range(3), [0, 1, 2]);
    expect(range(-3), [-2, -1, 0]);
    expect(range(1, 3), [1, 2]);
    expect(range(-3, -3), []);
    expect(range(-6, -3), [-6, -5, -4]);
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
    expect(range(-3, -3, -100), []);
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
        symmetricDeepEquals([
          [1, 2],
          {3, 4}
        ], [
          [1, 2],
          {3, 4}
        ]),
        true);
    expect(
        symmetricDeepEquals({
          1: 2,
          3: [4, 5]
        }, {
          3: inclusiveList(4, 5),
          1: 2
        }),
        true);
  });
}
