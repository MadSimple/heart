import 'dart:collection';

import 'package:heart/heart_types.dart';
import 'package:heart/src/helper.dart';
import 'package:test/test.dart';

bool isQueueList(Iterable it) {
  return it is QueueList;
}

bool isList(Iterable it) {
  return it is List && it is! QueueList;
}

void queueListOperatorTest() {
  test('HeartQueueListOperator', () {
    final Queue l1 = [
      1,
      2,
      {3, 4}
    ].toQueueList();
    final Queue l2 = [
      1,
      2,
      {4, 5}
    ].toQueueList();

    expect(l1 * 2, [
      1,
      2,
      {3, 4},
      1,
      2,
      {3, 4}
    ]);
    expect(isQueueList([].toQueueList() * 10), true);
    expect(['b', 1].toQueueList() >= ['a', 1].toQueueList(), true);
    expect(l2 > l1, true);
  });
}

void queueListTest() {
  test('HeartQueueList', () {
    expect(
        [
          [1, 2],
          {3, 4}
        ].toQueueList().deepContains({
          {3, inclusive(4, 4).first}
        }),
        true);

    expect(
        [
          ['one', 'two', 'three'],
          [1, 2, 3],
        ].toQueueList().zip(),
        [
          ['one', 1],
          ['two', 2],
          ['three', 3]
        ]);

    final List l1 = ['one', 'two', 'three'];
    final List l2 = [1, 2, 3];

    expect(isQueueList([l1, l2].toQueueList().zip()), true);

    List<int> l123 = [1, 2, 3];
    List<int> l456 = [4, 5, 6];

    var qZip = [l123, l456].toQueueList().zipWith((args) => args[0] + args[1]);
    expect(isQueueList(qZip), true);

    expect(isList([1, 2, 3].toQueueList().indicesOf({1, 2})), true);

    expect(
        isList(
            [2, -22, 33, 44, -12].toQueueList().indicesWhere((e) => e.isOdd)),
        true);

    final qKI = [10, 11, 12].toQueueList().keepIndices(range(0, 2, 2));
    expect(isQueueList(qKI), true);
    expect(qKI, [10]);

    final qC = [1, 2, 1, 2, 1].toQueueList().count([1, 2]);
    expect(qC, 2);

    final qi = [1, 2, 3].toQueueList().inc();
    expect(qi, [2, 3, 4]);
    expect(isQueueList(qi), true);

    final qd = [1, 2, 3].toQueueList().dec();
    expect(qd, [0, 1, 2]);
    expect(isQueueList(qd), true);

    expect(isQueueList([].toQueueList().inits), true);

    expect([1].toQueueList().tail is QueueList, true);

    expect(isQueueList([1].toQueueList().tails), true);

    expect(
        isQueueList(['one', 'two', 'three'].toQueueList().intersperse(['-'])),
        true);

    expect(isQueueList([].toQueueList().splitAt(1)), true);

    final List<int> l5 = [1, 2, 3, 3, 2, 1];

    expect(isQueueList(l5.toQueueList().group()), true);

    expect(isQueueList(l5.toQueueList().groupBy((a, b) => a <= b)), true);

    expect(
        isQueueList(
            [10, 11, 12].toQueueList().dropIndices([-100, 0, 0, 0, 2, 100])),
        true);

    expect(
        isQueueList([
          Iterable.generate(2),
          {0, 1}
        ].toQueueList().nub(equalityFunction: DeepCollectionEquality().equals)),
        true);

    expect(
        isQueueList([1, 1, 2, 3].toQueueList().addMissing([2, 3, 4, 4])), true);

    expect(isQueueList([1, 1, 2, 2].toQueueList().keep([1, 3, 3, 5])), true);

    expect(isQueueList([1, 2, 3, 1].toQueueList().subtract([1])), true);

    expect(
        isQueueList([
          [1],
          [1],
          [1],
          [1],
          3,
          3
        ].toQueueList().subtractAll({
          [1],
          2
        })),
        true);

    expect(isQueueList([1, 2].toQueueList().replace([1], [2])), true);

    expect(
        isQueueList([1, 3, 2].toQueueList().filter((element) => element < 3)),
        true);

    final List<int> l8 = [1, 2, 3];

    expect(isQueueList(l8.toQueueList().interleave(l8)), true);

    expect(isQueueList([1, 2, 3, 4, 5].toQueueList().riffleIn()), true);

    expect(isQueueList([1, 2, 3, 4, 5].toQueueList().riffleOut()), true);

    expect(isQueueList([1, 2, 3].toQueueList().before([3])), true);

    expect(
        isQueueList([1, 2, 3, 4]
            .toQueueList()
            .beforeWhere((e) => e.isEven, reverse: true)),
        true);

    expect(isQueueList([1, 2, 3].toQueueList().after([-5])), true);

    expect(
        isQueueList([1, 2, 3, 4]
            .toQueueList()
            .afterWhere((e) => e.isOdd, reverse: true)),
        true);

    expect([1, 2, {}].toQueueList().startsWith([]), true);

    List<int> intList = [4, 1, 6];
    expect(isQueueList(intList.toQueueList().ascending), true);
    expect(isQueueList(intList.toQueueList().descending), true);

    expect(isQueueList([].toQueueList().mode()), true);

    expect(isQueueList([1, 2, 3].toQueueList().toStrings()), true);
  });
}

void queueListIntTest() {
  test('HeartQueueListInt', () {
    expect([1, 2].toQueueList().productOrNull, 2);
    expect([1, 2].toQueueList().productOrNull.runtimeType, int);
    expect([97, 98].toQueueList().chrs, 'ab');
    expect([97, 98, -1].toQueueList().chrs, 'ab');
    expect(<int>[].toQueueList().chrs, '');
  });
}

void queueListNumTest() {
  test('HeartQueueListNum', () {
    Iterable<num> itn = [1.9, 2.0];

    List<double> ld = [1.9, 2.0];

    expect(isQueueList(itn.toQueueList().toInts()), true);

    expect(isQueueList(itn.toQueueList().toDoubles()), true);

    expect(isQueueList(ld.toQueueList().toRounded()), true);

    expect(<num>[].toQueueList().productOrNull, null);
    expect(<num>[1, 2, 3].toQueueList().productOrNull, 6);

    expect([1, 2, 3].toQueueList().averageOrNull, 2);
    expect([1, 2].toQueueList().averageOrNull, 1.5);
    expect(<num>[].toQueueList().averageOrNull, null);

    expect([4, 0, 1].toQueueList().medianOrNull, 1);
    expect(<int>[2, 2, 3, 9].toQueueList().medianOrNull, 2.5);
    expect(<int>[].toQueueList().medianOrNull, null);

    expect(isQueueList([0, 5, 6.0].toQueueList().insertInOrder([-1])), true);

    expect(isQueueList([1, 2, 3].toQueueList().inc()), true);

    expect([1, 2, 3].dec(), [0, 1, 2]);
    expect([1, 2, 3].dec(2), [-1, 0, 1]);
    expect([1, 2, 3].dec(-1), [2, 3, 4]);
    expect([1, 2, 3].dec(0), [1, 2, 3]);

    expect(isQueueList([1.1, 0, 3.1].toQueueList().ascending), true);

    expect(
        isQueueList([0.0, 5.0, 6.0].toQueueList().insertInOrder([-1])), true);
  });
}

void queueListStringTest() {
  test('HeartQueueListString', () {
    expect(isQueueList(['abc', '123'].toQueueList().zip()), true);

    expect(
        isQueueList(<String>['abc', 'axy']
            .toQueueList()
            .zipWith((args) => args[0] == args[1])),
        true);
  });
}

void queueListIterableTest() {
  test('HeartQueueListIterable', () {
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
    expect(l1.toQueueList().intercalate([0, 0]), l2.flattened.toList());
    expect(isQueueList(l1.toQueueList().intercalate([0, 0])), true);
  });
}

void queueListCollectionTest() {
  test('HeartCollectionQueueList', () {
    expect(
        isQueueList([10, 11, 12].toQueueList().transform((e) => e % 3)), true);
    expect([10, 11, 12].toQueueList().transform((e) => e % 3), [1, 2, 0]);

    expect(
        isQueueList([10, 11, 12]
            .toQueueList()
            .transformIndexed((index, element) => element + index)),
        true);
    expect(
        [10, 11, 12]
            .toQueueList()
            .transformIndexed((index, element) => element + index),
        [10, 12, 14]);

    expect(
        isQueueList([10, 11, 12].toQueueList().filter((e) => e.isEven)), true);
    expect([10, 11, 12].toQueueList().filter((e) => e.isEven), [10, 12]);
    expect([1, 3, 2].toQueueList().filter((element) => element > 3), []);
    expect([].toQueueList().filter((element) => element < 3), []);

    expect(
        isQueueList([2, 4]
            .toQueueList()
            .filterIndexed((index, element) => index.isEven && element.isEven)),
        true);
    expect(
        [2, 4]
            .toQueueList()
            .filterIndexed((index, element) => index.isEven && element.isEven),
        [2]);

    expect(isQueueList([2, '3', 4].toQueueList().filterType<int>()), true);
    expect([2, '3', 4].toQueueList().filterType<int>(), [2, 4]);

    expect(
        isQueueList([2, 3, 4].toQueueList().filterNot((e) => e.isEven)), true);
    expect([2, 3, 4].toQueueList().filterNot((e) => e.isEven), [3]);

    expect(
        isQueueList([0, 1, 2]
            .toQueueList()
            .filterNotIndexed((index, element) => element + index < 2)),
        true);
    expect(
        [0, 1, 2]
            .toQueueList()
            .filterNotIndexed((index, element) => element + index < 2),
        [1, 2]);

    expect(
        isQueueList([
          [1, 2],
          [3, 4]
        ].toQueueList().flatMap((element) => element)),
        true);
    expect(
        [
          [1, 2],
          [3, 4]
        ].toQueueList().flatMap((element) => element),
        [1, 2, 3, 4]);

    expect(
        isQueueList([
          [1, 2],
          [3, 4],
          [5, 6]
        ].toQueueList().flatMapIndexed((index, element) => element * index)),
        true);
    expect(
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ].toQueueList().flatMapIndexed((index, element) => element * index),
        [3, 4, 5, 6, 5, 6]);
  });
}
