import 'dart:collection';

import 'package:heart/heart_types.dart';
import 'package:heart/src/helper.dart';
import 'package:test/test.dart';

bool isQueue(Iterable it) {
  return it is Queue && it is! QueueList;
}

bool isList(Iterable it) {
  return it is List && it is! QueueList;
}

void queueOperatorTest() {
  test('HeartQueueOperator', () {
    final Queue l1 = [
      1,
      2,
      {3, 4}
    ].toQueue();
    final Queue l2 = [
      1,
      2,
      {4, 5}
    ].toQueue();

    expect(l1 * 2, [
      1,
      2,
      {3, 4},
      1,
      2,
      {3, 4}
    ]);
    expect(isQueue([].toQueue() * 10), true);
    expect(['b', 1].toQueue() >= ['a', 1].toQueue(), true);
    expect(l2 > l1, true);
  });
}

void queueTest() {
  test('HeartQueue', () {
    expect(
        [
          [1, 2],
          {3, 4}
        ].toQueue().deepContains({
          {3, inclusive(4, 4).first}
        }),
        true);

    expect(
        [
          ['one', 'two', 'three'],
          [1, 2, 3],
        ].toQueue().zip(),
        [
          ['one', 1],
          ['two', 2],
          ['three', 3]
        ]);

    final List l1 = ['one', 'two', 'three'];
    final List l2 = [1, 2, 3];

    expect(isQueue([l1, l2].toQueue().zip()), true);

    List<int> l123 = [1, 2, 3];
    List<int> l456 = [4, 5, 6];

    var qZip = [l123, l456].toQueue().zipWith((args) => args[0] + args[1]);
    expect(isQueue(qZip), true);

    expect(isList([1, 2, 3].toQueue().indicesOf({1, 2})), true);

    expect(isList([2, -22, 33, 44, -12].toQueue().indicesWhere((e) => e.isOdd)),
        true);

    final qKI = [10, 11, 12].toQueue().keepIndices(range(0, 2, 2));
    expect(isQueue(qKI), true);
    expect(qKI, [10]);

    final qC = [1, 2, 1, 2, 1].toQueue().count([1, 2]);
    expect(qC, 2);

    final qi = [1, 2, 3].toQueue().inc();
    expect(qi, [2, 3, 4]);
    expect(isQueue(qi), true);

    final qd = [1, 2, 3].toQueue().dec();
    expect(qd, [0, 1, 2]);
    expect(isQueue(qd), true);

    expect(isQueue([].toQueue().inits), true);

    expect(
        [1].toQueue().tail is Queue && [1].toQueue().tail is! QueueList, true);

    expect(isQueue([1].toQueue().tails), true);

    expect(isQueue(['one', 'two', 'three'].toQueue().intersperse(['-'])), true);

    expect(isQueue([].toQueue().splitAt(1)), true);

    final List<int> l5 = [1, 2, 3, 3, 2, 1];

    expect(isQueue(l5.toQueue().group()), true);

    expect(isQueue(l5.toQueue().groupBy((a, b) => a <= b)), true);

    expect(isQueue([10, 11, 12].toQueue().dropIndices([-100, 0, 0, 0, 2, 100])),
        true);

    expect(
        isQueue([
          Iterable.generate(2),
          {0, 1}
        ].toQueue().nub(equalityFunction: DeepCollectionEquality().equals)),
        true);

    expect(isQueue([1, 1, 2, 3].toQueue().addMissing([2, 3, 4, 4])), true);

    expect(isQueue([1, 1, 2, 2].toQueue().keep([1, 3, 3, 5])), true);

    expect(isQueue([1, 2, 3, 1].toQueue().subtract([1])), true);

    expect(
        isQueue([
          [1],
          [1],
          [1],
          [1],
          3,
          3
        ].toQueue().subtractAll({
          [1],
          2
        })),
        true);

    expect(isQueue([1, 2].toQueue().replace([1], [2])), true);

    expect(isQueue([1, 3, 2].toQueue().filter((element) => element < 3)), true);

    final List<int> l8 = [1, 2, 3];

    expect(isQueue(l8.toQueue().interleave(l8)), true);

    expect(isQueue([1, 2, 3, 4, 5].toQueue().riffleIn()), true);

    expect(isQueue([1, 2, 3, 4, 5].toQueue().riffleOut()), true);

    expect(isQueue([1, 2, 3].toQueue().before([3])), true);

    expect(
        isQueue(
            [1, 2, 3, 4].toQueue().beforeWhere((e) => e.isEven, reverse: true)),
        true);

    expect(isQueue([1, 2, 3].toQueue().after([-5])), true);

    expect(
        isQueue(
            [1, 2, 3, 4].toQueue().afterWhere((e) => e.isOdd, reverse: true)),
        true);

    expect([1, 2, {}].toQueue().startsWith([]), true);

    List<int> intList = [4, 1, 6];
    expect(isQueue(intList.toQueue().ascending), true);
    expect(isQueue(intList.toQueue().descending), true);

    expect(isQueue([].toQueue().mode()), true);

    expect(isQueue([1, 2, 3].toQueue().toStrings()), true);
  });
}

void queueIntTest() {
  test('HeartQueueInt', () {
    expect([1, 2].toQueue().productOrNull, 2);
    expect([1, 2].toQueue().productOrNull.runtimeType, int);
    expect([97, 98].toQueue().chrs, 'ab');
    expect([97, 98, -1].toQueue().chrs, 'ab');
    expect(<int>[].toQueue().chrs, '');
  });
}

void queueNumTest() {
  test('HeartQueueNum', () {
    Iterable<num> itn = [1.9, 2.0];

    List<double> ld = [1.9, 2.0];

    expect(isQueue(itn.toQueue().toInts()), true);

    expect(isQueue(itn.toQueue().toDoubles()), true);

    expect(isQueue(ld.toQueue().toRounded()), true);

    expect(<num>[].toQueue().productOrNull, null);
    expect(<num>[1, 2, 3].toQueue().productOrNull, 6);

    expect([1, 2, 3].toQueue().averageOrNull, 2);
    expect([1, 2].toQueue().averageOrNull, 1.5);
    expect(<num>[].toQueue().averageOrNull, null);

    expect([4, 0, 1].toQueue().medianOrNull, 1);
    expect(<int>[2, 2, 3, 9].toQueue().medianOrNull, 2.5);
    expect(<int>[].toQueue().medianOrNull, null);

    expect(isQueue([0, 5, 6.0].toQueue().insertInOrder([-1])), true);

    expect(isQueue([1, 2, 3].toQueue().inc()), true);

    expect([1, 2, 3].dec(), [0, 1, 2]);
    expect([1, 2, 3].dec(2), [-1, 0, 1]);
    expect([1, 2, 3].dec(-1), [2, 3, 4]);
    expect([1, 2, 3].dec(0), [1, 2, 3]);

    expect(isQueue([1.1, 0, 3.1].toQueue().ascending), true);

    expect(isQueue([0.0, 5.0, 6.0].toQueue().insertInOrder([-1])), true);
  });
}

void queueStringTest() {
  test('HeartQueueString', () {
    expect(isQueue(['abc', '123'].toQueue().zip()), true);

    expect(
        isQueue(<String>['abc', 'axy']
            .toQueue()
            .zipWith((args) => args[0] == args[1])),
        true);
  });
}

void queueIterableTest() {
  test('HeartQueueIterable', () {
    expect(
        [
          [],
          [1]
        ].flattened.toList(),
        [1]);
    final List<List<int>> l1 = [
      [1, 2],
      [3, 4],
      [5, 6]
    ];
    final List<List<int>> l2 = [
      [1, 2, 0, 0, 3, 4, 0, 0, 5, 6]
    ];
    expect(l1.toQueue().intercalate([0, 0]), l2.flattened.toList());
    expect(isQueue(l1.toQueue().intercalate([0, 0])), true);
  });
}

void queueCollectionTest() {
  test('HeartCollectionQueue', () {
    expect(isQueue([10, 11, 12].toQueue().transform((e) => e % 3)), true);
    expect([10, 11, 12].toQueue().transform((e) => e % 3), [1, 2, 0]);

    expect(
        isQueue([10, 11, 12]
            .toQueue()
            .transformIndexed((index, element) => element + index)),
        true);
    expect(
        [10, 11, 12]
            .toQueue()
            .transformIndexed((index, element) => element + index),
        [10, 12, 14]);

    expect(isQueue([10, 11, 12].toQueue().filter((e) => e.isEven)), true);
    expect([10, 11, 12].toQueue().filter((e) => e.isEven), [10, 12]);
    expect([1, 3, 2].toQueue().filter((element) => element > 3), []);
    expect([].toQueue().filter((element) => element < 3), []);

    expect(
        isQueue([2, 4]
            .toQueue()
            .filterIndexed((index, element) => index.isEven && element.isEven)),
        true);
    expect(
        [2, 4]
            .toQueue()
            .filterIndexed((index, element) => index.isEven && element.isEven),
        [2]);

    expect(isQueue([2, '3', 4].toQueue().filterType<int>()), true);
    expect([2, '3', 4].toQueue().filterType<int>(), [2, 4]);

    expect(isQueue([2, 3, 4].toQueue().filterNot((e) => e.isEven)), true);
    expect([2, 3, 4].toQueue().filterNot((e) => e.isEven), [3]);

    expect(
        isQueue([0, 1, 2]
            .toQueue()
            .filterNotIndexed((index, element) => element + index < 2)),
        true);
    expect(
        [0, 1, 2]
            .toQueue()
            .filterNotIndexed((index, element) => element + index < 2),
        [1, 2]);

    expect(
        isQueue([
          [1, 2],
          [3, 4]
        ].toQueue().flatMap((element) => element)),
        true);
    expect(
        [
          [1, 2],
          [3, 4]
        ].toQueue().flatMap((element) => element),
        [1, 2, 3, 4]);

    expect(
        isQueue([
          [1, 2],
          [3, 4],
          [5, 6]
        ].toQueue().flatMapIndexed((index, element) => element * index)),
        true);
    expect(
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ].toQueue().flatMapIndexed((index, element) => element * index),
        [3, 4, 5, 6, 5, 6]);
  });
}
