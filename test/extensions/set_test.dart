import 'package:heart/heart_types.dart';
import 'package:test/test.dart';

bool isSet(Iterable it) {
  return it is Set;
}

bool isList(Iterable it) {
  return it is List && it is! QueueList;
}

void setOperatorTest() {
  test('HeartSetOperator', () {
    final Set l1 = {
      1,
      2,
      {3, 4}
    };
    final Set l2 = {
      1,
      2,
      {4, 5}
    };

    expect(l1 * 2, {
      1,
      2,
      {3, 4}
    });
    expect(isSet(<dynamic>{} * 10), true);
    expect({'b', 1} >= {'a', 1}, true);
    expect(l2 > l1, true);
  });
}

void setTest() {
  test('HeartSet', () {
    expect(
        {
          [1, 2],
          {3, 4}
        }.deepContains({
          {3, inclusive(4, 4).first}
        }),
        true);

    expect(
        {
          ['one', 'two', 'three'],
          [1, 2, 3],
        }.zip(),
        [
          ['one', 1],
          ['two', 2],
          ['three', 3]
        ]);

    final List l1 = ['one', 'two', 'three'];
    final List l2 = [1, 2, 3];
    expect(isSet({l1, l2}.zip()), true);

    List<int> l123 = [1, 2, 3];
    List<int> l456 = [4, 5, 6];
    var qZip = {l123, l456}.zipWith((args) => args[0] + args[1]);
    expect(isSet(qZip), true);

    expect(isList({1, 2, 3}.indicesOf({1, 2})), true);

    expect(isList({2, -22, 33, 44, -12}.indicesWhere((e) => e.isOdd)), true);

    final qKI = {10, 11, 12}.keepIndices(range(0, 2, 2));
    expect(isSet(qKI), true);
    expect(qKI, [10]);

    final qC = {1, 2}.count([1, 2]);
    expect(qC, 1);

    final qi = {1, 2, 3}.inc();
    expect(qi, {2, 3, 4});
    expect(isSet(qi), true);

    final qd = {1, 2, 3}.dec();
    expect(qd, [0, 1, 2]);
    expect(isSet(qd), true);

    expect(isSet(<dynamic>{}.inits), true);

    expect(isSet({1}.tail!), true);

    expect(isSet({1}.tails), true);

    expect(isSet({'one', 'two', 'three'}.intersperse(['-'])), true);

    expect(isSet(<dynamic>{}.splitAt(1)), true);

    final List<int> l5 = [1, 2, 3, 3, 2, 1];

    expect(isSet(l5.toSet().group()), true);

    expect(isSet(l5.toSet().groupBy((a, b) => a <= b)), true);

    expect(isSet({10, 11, 12}.dropIndices([-100, 0, 0, 0, 2, 100])), true);

    expect(
        isSet({
          Iterable.generate(2),
          {0, 1}
        }.nub(equalityFunction: DeepCollectionEquality().equals)),
        true);

    expect(isSet({1, 2, 3}.addMissing([2, 3, 4, 4])), true);

    expect(isSet({1, 2}.keep([1, 3, 3, 5])), true);

    expect(isSet({1, 2, 3}.subtract([1])), true);

    expect(
        isSet({
          [1],
          [1],
          [1],
          [1],
          3,
        }.subtractAll({
          [1],
          2
        })),
        true);

    expect(isSet({1, 2}.replace([1], [2])), true);

    expect(isSet({1, 3, 2}.filter((element) => element < 3)), true);

    final List<int> l8 = [1, 2, 3];

    expect(isSet(l8.toSet().interleave(l8)), true);

    expect(isSet({1, 2, 3, 4, 5}.riffleIn()), true);

    expect(isSet({1, 2, 3, 4, 5}.riffleOut()), true);

    expect(isSet({1, 2, 3}.before([3])), true);

    expect(
        isSet({1, 2, 3, 4}.beforeWhere((e) => e.isEven, reverse: true)), true);

    expect(isSet({1, 2, 3}.after([-5])), true);

    expect(isSet({1, 2, 3, 4}.afterWhere((e) => e.isOdd, reverse: true)), true);

    expect({1, 2, {}}.startsWith([]), true);

    List<int> intList = [4, 1, 6];
    expect(isSet(intList.toSet().ascending), true);
    expect(isSet(intList.toSet().descending), true);

    expect(isSet(<dynamic>{}.mode()), true);

    expect(isSet({1, 2, 3}.toStrings()), true);
  });
}

void setIntTest() {
  test('HeartSetInt', () {
    expect({1, 2}.productOrNull, 2);
    expect({1, 2}.productOrNull.runtimeType, int);
    expect({97, 98}.chrs, 'ab');
    expect({97, 98, -1}.chrs, 'ab');
    expect(<int>{}.chrs, '');
  });
}

void setNumTest() {
  test('HeartSetNum', () {
    Iterable<num> itn = [1.9, 2.0];

    List<double> ld = [1.9, 2.0];

    expect(isSet(itn.toSet().toInts()), true);

    expect(isSet(itn.toSet().toDoubles()), true);

    expect(isSet(ld.toSet().toRounded()), true);

    expect(<num>{}.productOrNull, null);
    expect(<num>{1, 2, 3}.productOrNull, 6);

    expect({1, 2, 3}.averageOrNull, 2);
    expect({1, 2}.averageOrNull, 1.5);
    expect(<num>{}.averageOrNull, null);

    expect({4, 0, 1}.medianOrNull, 1);
    expect(<int>{2, 3, 9}.medianOrNull, 3);
    expect(<int>{}.medianOrNull, null);

    expect(isSet({0, 5, 6.0}.insertInOrder([-1])), true);

    expect(isSet({1, 2, 3}.inc()), true);

    expect([1, 2, 3].dec(), [0, 1, 2]);
    expect([1, 2, 3].dec(2), [-1, 0, 1]);
    expect([1, 2, 3].dec(-1), [2, 3, 4]);
    expect([1, 2, 3].dec(0), [1, 2, 3]);

    expect(isSet({1.1, 0, 3.1}.ascending), true);

    expect(isSet({0.0, 5.0, 6.0}.insertInOrder([-1])), true);
  });
}

void setStringTest() {
  test('HeartSetString', () {
    expect(isSet({'abc', '123'}.zip()), true);

    expect(isSet({'abc', 'axy'}.zipWith((args) => args[0] == args[1])), true);
  });
}

void setIterableTest() {
  test('HeartSetIterable', () {
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

    expect(isSet(l1.toSet().intercalate([0, 0])), true);
  });
}

void setCollectionTest() {
  test('HeartCollectionSet', () {
    expect(isSet({10, 11, 12}.transform((e) => e % 3)), true);
    expect({10, 11, 12}.transform((e) => e % 3), [1, 2, 0]);

    expect(
        isSet(
            {10, 11, 12}.transformIndexed((index, element) => element + index)),
        true);
    expect({10, 11, 12}.transformIndexed((index, element) => element + index),
        [10, 12, 14]);

    expect(isSet({10, 11, 12}.filter((e) => e.isEven)), true);
    expect({10, 11, 12}.filter((e) => e.isEven), [10, 12]);
    expect({1, 3, 2}.filter((element) => element > 3), []);
    expect(<dynamic>{}.filter((element) => element < 3), []);

    expect(
        isSet({2, 4}
            .filterIndexed((index, element) => index.isEven && element.isEven)),
        true);
    expect(
        {2, 4}
            .filterIndexed((index, element) => index.isEven && element.isEven),
        [2]);

    expect(isSet({2, '3', 4}.filterType<int>()), true);
    expect({2, '3', 4}.filterType<int>(), [2, 4]);

    expect(isSet({2, 3, 4}.filterNot((e) => e.isEven)), true);
    expect({2, 3, 4}.filterNot((e) => e.isEven), [3]);

    expect(
        isSet({0, 1, 2}
            .filterNotIndexed((index, element) => element + index < 2)),
        true);
    expect({0, 1, 2}.filterNotIndexed((index, element) => element + index < 2),
        [1, 2]);

    expect(
        isSet({
          [1, 2],
          [3, 4]
        }.flatMap((element) => element)),
        true);
    expect(
        {
          [1, 2],
          [3, 4]
        }.flatMap((element) => element),
        [1, 2, 3, 4]);

    expect(
        isSet({
          [1, 2],
          [3, 4],
          [5, 6]
        }.flatMapIndexed((index, element) => element * index)),
        true);
    expect(
        {
          [1, 2],
          [3, 4],
          [5, 6]
        }.flatMapIndexed((index, element) => element * index),
        [3, 4, 5, 6]);
  });
}
