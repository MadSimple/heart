import 'dart:collection';

import 'package:heart/heart.dart';
import 'package:heart/src/helper.dart'
    show
        deepEquals,
        reverseDeepEquals,
        normalEquals,
        symmetricDeepEquals,
        deepEquality;
import 'package:test/test.dart';

bool isIterable(Iterable it) {
  return it is! List && it is! Queue && it is! Set;
}

void iterableOperatorTest() {
  test('HeartIterableOperator', () {
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
      [4, 5]
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
    expect([] * 1000, []);
    expect(isIterable([] * 1000), true);
    expect([] * -1000, []);
    expect(['b', 1] >= ['a', 1], true);
    expect(['a', 1] >= ['a', 1], true);
    expect([1, 2] > {0, 1}, true);
    expect([0, 1] < {1, 2}, true);
    expect([0, 1] <= {0, 1}, true);
    expect(l2 > l1, true);
    expect((l3 * 2) > l3, true);
    expect(l2 >= l3, true);
    expect(l2 <= l3, true);
    expect(l2 < l3, false);
    expect(l2 > l3, false);
    expect([1, 2, 3] > [1, 1, 5], true);
    expect([1, 2, 3] < [1, 1, 5], false);
    expect(isIterable([1, 2, 3].toStrings()), true);
    expect([1, 2, 3].toStrings() > ['1', 1, 5].toStrings(), true);
    expect(['a', 1] > ['b', 1], false);
    expect(['a', 1] < ['b', 1], true);
    expect(['b', 1] <= ['a', 1], false);
    expect(['a', 1] <= ['b', 1], true);
    expect(['a', 1] >= ['b', 1], false);
    const List<int> li1 = [1, 2, 3];
    const List<int> li2 = [1, 2, 4];
    expect(li2 > li1, true);

    expect([1, 2, 3].deepContains({1, 2}), true);
    expect(
        l4.deepContains([
          {4, inclusiveList(4, 5)}
        ]),
        true);

    expect(l1.toStrings(), ['1', '2', '{3, 4}']);
    expect([].toStrings(), []);

    expect([1, 2, 3] > [1, 1, 3], true);
    expect([1, 2, 3] > [1, 2], true);
    expect(
        [
              [1],
              2,
              3
            ] >
            [
              [0],
              1,
              2
            ],
        true);
    expect(
        [
              1,
              [1, 2]
            ] >
            [
              1,
              [0, 2]
            ],
        true);
    expect(
        [
              {1, 3}
            ] >
            [
              [1, 3]
            ],
        false);
    expect(
        [
              {1, 3}
            ] >=
            [
              [1, 3]
            ],
        true);

    expect(
        [
              {1, 2}
            ] >
            [0],
        false);
    expect([] > [], false);
    expect([] >= [], true);
    expect([1, 2, 3] > [1, 2, 4], false);
    expect([1, 2, 3] >= [1, 2, 4], false);
    expect(
        [
              1,
              [1, 2]
            ] >
            [1, 0],
        false);
    expect([1, 2] > {0, 1}, true);

    expect([1, 2] >= {1, 2}, true);

    expect(
        [
              {1, 3}
            ] <
            [
              [1, 3]
            ],
        false);
    expect(
        [
              {1, 3}
            ] <=
            [
              [1, 3]
            ],
        true);

    expect(
      [
            {1, 2}
          ] <
          [0],
      false,
    );
    expect([1, 2] < [1, 2, 3], true);
    expect([1, 2, 3] < [1, 2], false);
    expect([] < [], false);
    expect([] <= [], true);
    expect([1, 2, 3] < [1, 2, 4], true);
    expect([1, 1, 3] < [1, 2, 3], true);
    expect(
        [
              1,
              [0, 2]
            ] <
            [
              1,
              [1, 2]
            ],
        true);
    expect(
        [1, 0] <
            [
              1,
              [1, 2]
            ],
        false);
    expect({0, 1} < [1, 2], true);
    expect({0, 1} <= [1, 2], true);
    expect(
        {
              [0],
              [1]
            } <=
            [
              [1],
              [2]
            ],
        true);
    expect(
        {
              [0],
              [1]
            } <=
            [
              1,
              [2]
            ],
        false);
    expect(
        {
              [0],
              [1]
            } >=
            [
              1,
              [2]
            ],
        false);
    expect([1, 2, 3] <= [1, 2, 4], true);
    expect([1, 2] <= {1, 2, 3}, true);
    expect([] <= {}, true);
  });
}

void iterableTest() {
  test('HeartIterable', () {
    expect(
        [
          [1, 2],
          {3, 4}
        ].deepContains({
          {3, inclusive(4, 4).first}
        }),
        true);
    expect(
        [
          {1: 2},
          {3: 4}
        ].deepContains([
          {1: 2},
          {3: 4}
        ]),
        true);
    expect([1, 2, 3].deepContains([1, 2]), true);
    expect(
        [
          [1],
          2,
          3
        ].deepContains([
          [1]
        ]),
        true);
    expect(
        [
          [1],
          2,
          3
        ].deepContains([
          [1]
        ], equalityFunction: normalEquals),
        false);
    expect(
        [
          [0],
          2,
          3
        ].deepContains([Iterable.generate(1)],
            equalityFunction: (a, b) => DeepCollectionEquality().equals(b, a)),
        true);
    expect(
        [
          [0],
          2,
          3
        ].deepContains({
          [0]
        }),
        true);
    expect(
        [
          [0],
          2,
          3
        ].deepContains([
          [0]
        ], equalityFunction: deepEquals),
        true);
    expect(
        [Iterable.generate(1), 2, 3].deepContains([
          [0]
        ], equalityFunction: reverseDeepEquals),
        false);
    expect(
        <dynamic>[
          [0, 1],
          [1, 2]
        ].deepContains([Iterable.generate(2, (e) => e)],
            equalityFunction: reverseDeepEquals),
        true);
    expect(
        <dynamic>[
          [0, 1],
          [1, 2]
        ].deepContains([Iterable.generate(2, (e) => e)],
            equalityFunction: deepEquals),
        false);

    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].deepContains([
          [0, 1],
          {0, 1}
        ], equalityFunction: deepEquals),
        true);
    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].deepContains([
          [0, 1],
          {0, 1}
        ], equalityFunction: reverseDeepEquals),
        false);

    expect([1, 2].toStrings(), ['1', '2']);
    expect([].toStrings(), []);

    expect(
        isIterable([
          ['one', 'two', 'three'],
          [1, 2, 3]
        ].zip()),
        true);
    expect(
        [
          ['one', 'two', 'three'],
          [1, 2, 3]
        ].zip(),
        [
          ['one', 1],
          ['two', 2],
          ['three', 3]
        ]);

    final List l1 = ['one', 'two', 'three'];
    final List l2 = [1, 2, 3];
    final List l3 = [
      ['one', 1],
      ['two', 2],
      ['three', 3]
    ];
    expect([l1, l2].zip(), l3);
    expect([l1, []].zip(), []);
    expect([[], l1].zip(), []);
    expect([[], []].zip(), []);

    List<int> l123 = [1, 2, 3];
    List<int> l456 = [4, 5, 6];
    List<int> l579 = [5, 7, 9];

    expect(isIterable([l123, l456].zipWith((args) => args[0] + args[1])), true);
    expect([l123, l456].zipWith((args) => args[0] + args[1]), l579);
    expect([l579, l456].zipWith((args) => (args[0] + args[1]).isEven),
        [false, true, false]);
    expect([[], l579].zipWith((args) => args[0] == args[1]), []);
    expect([l1, []].zipWith((args) => args[0] == args[1]), []);
    expect(<List>[].zipWith((args) => args[0] == args[1]), []);

    expect([1, 2, 3].indicesOf({1, 2}), [0]);
    expect([1, 2, 3].indicesOf({}), [0, 1, 2, 3]);
    expect([1, 2, 3].indicesOf({4}), []);
    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].indicesOf([
          [0, 1],
          {0, 1}
        ], equalityFunction: (a, b) => DeepCollectionEquality().equals(a, b)),
        [0]);
    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].indicesOf([
          [0, 1],
          {0, 1}
        ], equalityFunction: (a, b) => DeepCollectionEquality().equals(b, a)),
        []);

    final List l4 = [
      1,
      2,
      {
        4,
        [4, 5]
      }
    ];

    expect(
        isIterable((l4 * 3).indicesOf([
          {4, inclusiveList(4, 5)}
        ])),
        false);
    expect(
        (l4 * 3).indicesOf([
          {4, inclusiveList(4, 5)}
        ]),
        [2, 5, 8]);
    expect([1, 2, 1, 2, 1].indicesOf([1]), [0, 2, 4]);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2]), [0, 2]);
    expect(
        <dynamic>[1, 2, 1, 2, 1].indicesOf([
          [1, 2]
        ]),
        []);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2], overlap: false), [0, 2]);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2], overlap: true), [0, 2]);
    expect([1, 1, 1, 1, 1].indicesOf([1, 1], overlap: false), [0, 2]);
    expect([1, 1, 1, 1, 1].indicesOf([1, 1], overlap: true), [0, 1, 2, 3]);
    expect([1, 2, 1, 2, 1].indicesOf([]), [0, 1, 2, 3, 4, 5]);
    expect([1, 2, 1, 2, 1].indicesOf([], overlap: false), [0, 1, 2, 3, 4, 5]);
    expect([].indicesOf([]), [0]);
    expect([].indicesOf([1]), []);
    expect([2].indicesOf([1, 2]), []);
    expect([2, []].indicesOf([[]]), [1]);
    expect(
        [
          [1, 2],
          [3, 4]
        ].indicesOf([
          [1, 2]
        ]),
        [0]);
    expect([].indicesOf([]), [0]);
    expect([].indicesOf([1]), []);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2, 1], overlap: true), [0, 2]);
    expect([1, 2, 1, 2, 1].indicesOf([1], overlap: true), [0, 2, 4]);
    expect([1, 2, 1, 2, 1].indicesOf([1], overlap: false), [0, 2, 4]);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2, 1]), [0]);
    expect([1, 2, 1, 2, 1].indicesOf([1, 2, 1], overlap: true), [0, 2]);
    expect([1, 2, 1, 2, 1].indicesOf([], overlap: true), [0, 1, 2, 3, 4, 5]);
    expect([1, 2, 1, 2, 1].indicesOf([], overlap: false), [0, 1, 2, 3, 4, 5]);
    expect([1, 2, 1, 2, 1].indicesOf([3]), []);
    expect([1, 2, 1, 2, 1].indicesOf([3], overlap: false), []);
    expect(
        [
          {1: 2},
          3,
          {1: 2},
          3,
          {1: 2}
        ].indicesOf([
          {1: 2},
          3,
          {1: 2},
        ], overlap: true),
        [0, 2]);
    expect(
        [
          {1: 2},
          3,
          {1: 2},
          3,
          {1: 2}
        ].indicesOf([
          {1: 2},
          3,
          {1: 2},
        ]),
        [0]);
    expect(
        [
          [1, 2],
          [3, 4]
        ].indicesOf([
          [1, 2]
        ]),
        [0]);

    expect(
        isIterable([2, -22, 33, 44, -12].indicesWhere((e) => e.isOdd)), false);
    expect([2, -22, 33, 44, -12].indicesWhere((e) => e.isOdd), [2]);
    expect([].indicesWhere((e) => e.isOdd), []);
    expect([2, -22, 33, 44].indicesWhere((e) => e.isEven), [0, 1, 3]);

    expect(isIterable([10, 11, 12].keepIndices(range(0, 2, 2))), true);
    expect([10, 11, 12].keepIndices(range(0, 2, 2)), [10]);
    expect([10, 11, 12].keepIndices([0, 0, -2]), [10]);
    expect([10, 11, 12].keepIndices(range(100)), [10, 11, 12]);
    expect([10, 11, 12].keepIndices([]), []);
    expect([].keepIndices([1, -33]), []);
    expect([].keepIndices([]), []);

    expect([1, 2, 1, 2, 1].count([1, 2]), 2);
    expect([2, 1, 2, 1].count([1, 2, 1], overlap: true), 1);
    expect([2, 1, 2, 1].count([1, 2, 1]), 1);
    expect([1, 1, 1].count([]), 4);
    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].count([
          [0, 1],
          {0, 1}
        ], equalityFunction: (a, b) => DeepCollectionEquality().equals(a, b)),
        1);
    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].count([
          [0, 1],
          {0, 1}
        ], equalityFunction: (a, b) => DeepCollectionEquality().equals(b, a)),
        0);

    expect(l1.head, 'one');
    expect([].head, null);

    List<int> li = [1, 2, 3];
    List<double> ld = [1, 2, 3];

    expect(isIterable(li.inc()), true);
    expect(li.inc(), [2, 3, 4]);
    expect(isIterable(li.inc()), true);
    expect(li.inc(), li.dec(-1));
    expect(li.inc(-1), li.dec());
    expect(li.inc(-2), li.dec(2));
    expect([1, 2, 3].inc(-2), [-1, 0, 1]);
    expect([1, 2, 3].dec(-2), [3, 4, 5]);
    expect(<int>[].inc(), []);
    expect(isIterable(<int>[].mult(1)), true);
    expect(<int>[].mult(1), []);
    expect(li.mult(1), li);
    expect(li.mult(2), [2, 4, 6]);
    expect(li.mult(-2), [-2, -4, -6]);
    expect(li.mult(0), [0, 0, 0]);
    expect(isIterable(li.div(1)), true);
    expect(li.div(1), li);
    expect(li.div(2), [0, 1, 1]);
    expect(li.div(-2), [0, -1, -1]);
    expect(ld.div(2), [0.5, 1, 1.5]);
    expect(isIterable(ld.div(2)), true);

    expect(isIterable([].inits), true);
    expect([].inits, [[]]);
    expect([1].inits, [
      [],
      [1]
    ]);
    expect([1, 2].inits, [
      [],
      [1],
      [1, 2]
    ]);

    expect(isIterable([1].tail!), true);
    expect([1].tail, []);
    expect([1, 2, 3].tail, [2, 3]);
    expect([].tail, null);

    expect(isIterable([].tails), true);
    expect([1].tails, [
      [1],
      []
    ]);
    expect([].tails, [[]]);
    expect([1, 2].tails, [
      [1, 2],
      [2],
      []
    ]);

    expect(isIterable(['one', 'two', 'three'].intersperse(['-'])), true);
    expect(['one', 'two', 'three'].intersperse(['-']),
        ['one', '-', 'two', '-', 'three']);
    expect([1, 2, 3].intersperse([0]), [1, 0, 2, 0, 3]);
    expect([1, 2, 3].intersperse([8, 8]), [1, 8, 8, 2, 8, 8, 3]);
    expect([1, 2, 3].intersperse([0], reverse: true), [1, 0, 2, 0, 3]);
    expect([1, 2, 3].intersperse([]), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 2), [1, 0, 2, 0, 3]);
    expect([1, 2, 3].intersperse([0], count: 1), [1, 0, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 1, reverse: true), [1, 2, 0, 3]);
    expect([1, 2, 3].intersperse([0], count: -1), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: -1, reverse: true), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 100), [1, 0, 2, 0, 3]);
    expect(
        [1, 2, 3].intersperse([0], count: 100, reverse: true), [1, 0, 2, 0, 3]);
    expect([1, 2, 3].intersperse([0], count: 100, skip: 1), [1, 2, 0, 3]);
    expect([1, 2, 3].intersperse([0], count: 100, skip: -1), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: -100, skip: 1), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: -100, skip: 1, reverse: true),
        [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 100, skip: 100), [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 100, skip: 100, reverse: true),
        [1, 2, 3]);
    expect([1, 2, 3].intersperse([0], count: 100, skip: 2), [1, 2, 3]);
    expect([1, 2, 3, 4].intersperse([0], skip: 1), [1, 2, 0, 3, 0, 4]);
    expect([1, 2].intersperse([0], skip: 1), [1, 2]);
    expect(['a', 'b', 'c'].intersperse(['x'], count: 100),
        ['a', 'x', 'b', 'x', 'c']);
    expect([].intersperse([0]), []);
    expect([].intersperse([0], count: 100), []);
    expect([].intersperse([0], count: -100), []);
    expect([1].intersperse([0]), [1]);

    expect(isIterable(l4.splitAt(9)), true);
    expect(l4.splitAt(9), [l4, []]);
    expect(l4.splitAt(-9), [l4, []].backwards);
    expect([].splitAt(1), [[], []]);
    expect([1, 2, 3].splitAt(2), [
      [1, 2],
      [3]
    ]);
    expect([1, 2, 3].splitAt(2), [
      [1, 2],
      [3]
    ]);
    expect([1, 2, 3].splitAt(3), [
      [1, 2, 3],
      []
    ]);

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

    expect(isIterable(l5.group()), true);
    expect(l5.group(), l6);
    expect([].group(), []);
    expect([1].group(), [
      [1]
    ]);

    expect(isIterable(l5.groupBy((a, b) => a <= b)), true);
    expect(l5.groupBy((a, b) => a <= b), l7);
    expect([].groupBy((a, b) => a <= b), []);
    expect([1].groupBy((a, b) => a <= b), [
      [1]
    ]);

    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].group(equalityFunction: deepEquals),
        [
          [
            Iterable.generate(2),
            {0, 1}
          ]
        ]);

    expect(isIterable([10, 11, 12].dropIndices([-100, 0, 0, 0, 2, 100])), true);
    expect([10, 11, 12].dropIndices([-100, 0, 0, 0, 2, 100]), [11]);
    expect(
        Iterable.generate(3, (e) => [e]).dropIndices([-100, 0, 0, 0, 2, 100]), [
      [1]
    ]);
    expect([].dropIndices([0, 2]), []);
    expect([0].dropIndices([]), [0]);
    expect([].dropIndices([]), []);

    expect(
        [
          Iterable.generate(2),
          {0, 1}
        ].nub(equalityFunction: DeepCollectionEquality().equals),
        [
          [0, 1]
        ]);
    expect(isIterable([].nub(elementsToNub: [1, 2])), true);
    expect([].nub(elementsToNub: [1, 2]), []);
    expect([3, 4].nub(elementsToNub: [1, 2]), [3, 4]);
    expect([4, 4, 3, 4].nub(), [4, 3]);
    expect(l5.nub(), [1, 2, 3]);
    expect(l5.nub(elementsToNub: [1]), [1, 2, 3, 3, 2]);
    expect([1, 1, 1, 2, 2, 2, 3, 3, 3].nub(elementsToNub: [2, 3]),
        [1, 1, 1, 2, 3]);
    expect(l5.nub(elementsToNub: []), l5);
    expect([1, 1, 2, 2, 3, 3].nub(elementsToNub: []), [1, 1, 2, 2, 3, 3]);
    expect(l6.nub(), [
      [1],
      [2],
      [3, 3]
    ]);
    expect(
        l6.nub(elementsToNub: [
          [1]
        ]),
        [
          [1],
          [2],
          [3, 3],
          [2]
        ]);

    expect(isIterable([1, 1, 2, 3].addMissing([2, 3, 4, 4])), true);
    expect([1, 1, 2, 3].addMissing([2, 3, 4, 4]), [1, 1, 2, 3, 4]);
    expect(l5.addMissing(l5), l5);
    expect(l5.addMissing([]), l5);
    expect([].addMissing([]), []);
    expect(
        [
          {0, 1},
          1
        ].addMissing([
          Iterable.generate(2),
          [0, 1]
        ]),
        [
          {0, 1},
          1,
          Iterable.generate(2),
          [0, 1]
        ]);
    expect(
        [
          {0, 1},
          1
        ].addMissing([
          Iterable.generate(2),
          [0, 1]
        ], equalityFunction: deepEquals),
        [
          {0, 1},
          1,
          Iterable.generate(2),
        ]);
    expect(
        [
          [0, 1],
          2
        ].addMissing([
          Iterable.generate(2),
          {0, 1}
        ], equalityFunction: DeepCollectionEquality().equals),
        [
          [0, 1],
          2,
          Iterable.generate(2)
        ]);
    expect(
        [
          [0, 1],
          6
        ].addMissing([
          Iterable.generate(2),
          {0, 1}
        ], equalityFunction: DeepCollectionEquality().equals),
        [
          [0, 1],
          6,
          Iterable.generate(2)
        ]);

    expect(isIterable([1, 1, 2, 2].keep([1, 3, 3, 5])), true);
    expect([1, 1, 2, 2].keep([1, 3, 3, 5]), [1, 1]);
    expect([1, 1, 2, 2].keep([]), []);
    expect(
        [
          1,
          [1],
          2,
          2
        ].keep([
          [1]
        ]),
        [
          [1]
        ]);
    expect(
        [
          1,
          [1],
          2,
          2
        ].keep([
          [1]
        ], equalityFunction: normalEquals),
        []);
    expect([].keep([]), []);
    expect([].keep([1, 2, 3]), []);
    expect(
        [
          [1, 2],
          [3, 4]
        ].keep([
          [1, 2]
        ], equalityFunction: (a, b) => a == b),
        []);

    expect(isIterable([1, 2, 3, 1].subtract([1])), true);
    expect([1, 2, 3, 1].subtract([1]), [2, 3, 1]);
    expect([1, 2, 3, 1].subtract([1, 1]), [2, 3]);
    expect([1, 2, 3, 1].subtract([]), [1, 2, 3, 1]);
    expect(
        [
          1,
          2,
          [3],
          [3],
          1
        ].subtract({
          [3]
        }),
        [
          1,
          2,
          [3],
          1
        ]);
    expect(
        [
          1,
          2,
          [0],
          {0},
        ].subtract({Iterable.generate(1)}, equalityFunction: deepEquals),
        [
          1,
          2,
          [0],
          {0},
        ]);
    expect(
        [
          1,
          2,
          Iterable.generate(1),
          Iterable.generate(1),
        ].subtract({
          {0},
          [0]
        }, equalityFunction: deepEquals),
        [1, 2]);
    expect([].subtract([1, 1]), []);
    expect([].subtract([]), []);
    expect(
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ].subtract([Iterable.generate(2)],
            equalityFunction: (a, b) => DeepCollectionEquality().equals(a, b)),
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ]);
    expect(
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ].subtract([Iterable.generate(2)],
            equalityFunction: (a, b) => DeepCollectionEquality().equals(b, a)),
        [
          {0, 1},
          [3, 4]
        ]);

    expect(
        [
          [1],
          [1],
          [1],
          [1],
          3,
          3
        ].subtractAll({
          [1],
          2
        }),
        [3, 3]);
    expect(isIterable(l5.subtractAll([])), true);
    expect(l5.subtractAll([]), l5);
    expect([].subtractAll(l5), []);
    expect([].subtractAll([]), []);
    expect(
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ].subtractAll([Iterable.generate(2)],
            equalityFunction: (a, b) => DeepCollectionEquality().equals(a, b)),
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ]);
    expect(
        [
          {0, 1},
          {0, 1},
          [3, 4]
        ].subtractAll([Iterable.generate(2)],
            equalityFunction: (a, b) => DeepCollectionEquality().equals(b, a)),
        [
          [3, 4]
        ]);

    expect(isIterable([1, 2].replace([1], [2])), true);
    expect([1, 2].replace([1], [2]), [2, 2]);
    expect([1, 2].replace([1], [2], count: 0), [1, 2]);
    expect([1, 2].replace([2], [2]), [1, 2]);
    expect([1, 2].replace([2], []), [1]);
    expect([1, 2, 4].replace([], [3]), [3, 1, 3, 2, 3, 4, 3]);
    expect([1, 2, 4].replace([], [3], count: 1), [3, 1, 2, 4]);
    expect([1, 2, 4].replace([], [3], count: 2), [3, 1, 3, 2, 4]);
    expect([].replace([], [3], count: 3), [3]);
    expect([].replace([], [3], count: 1), [3]);
    expect([].replace([], [3], count: 0), []);
    expect([].replace([], [3], count: -10), []);
    expect([1, 2, 1, 2, 1].replace([1, 2, 1], [3], count: 2), [3, 2, 1]);
    expect([1, 1, 1, 1].replace([1, 1], [3]), [3, 3]);
    expect([1, 2].replace([], [3], count: -1), [1, 2]);
    expect([1, 2].replace([], [3], count: 1), [3, 1, 2]);
    expect([1, 2].replace([], [3], count: 100), [3, 1, 3, 2, 3]);
    expect([1, 2, 1, 2, 3].replace([1, 2], []), [3]);
    expect(
        [
          1,
          2,
          1,
          2,
          [1, 2]
        ].replace([1, 2], []),
        [
          [1, 2]
        ]);
    expect([1, 2, 1].replace([1], [3, 3], count: 1), [3, 3, 2, 1]);
    expect([1, 2, 1].replace([], [3, 3], count: 0), [1, 2, 1]);
    expect([1, 2, 1].replace([1, 2, 3], [3, 3]), [1, 2, 1]);
    expect([1, 2, 1].replace([1, 2, 1], []), []);
    expect([1, 1, 1].replace([1], [], count: 1), [1, 1]);
    expect([1, 1, 1].replace([1, 1], []), [1]);
    expect([1, 1, 1].replace([1, 1, 1], []), []);
    expect([1, 1, 1].replace([1, 1, 1, 1], []), [1, 1, 1]);

    expect([].replace([], [1]), [1]);
    expect([].replace([], [1], count: 15), [1]);
    expect(
        [
          1,
          2,
          {1: 3}
        ].replace([1, 2], []),
        [
          {1: 3}
        ]);
    expect(
        [
          1,
          2,
          {1: 3}
        ].replace([1, 2], [[]]),
        [
          [],
          {1: 3}
        ]);
    expect(
        [
          1,
          2,
          {1: 3}
        ].replace([
          1,
          2,
          {1: 3}
        ], [
          1,
          2,
          []
        ]),
        [1, 2, []]);

    expect([1, 2, 1].replace([], []), [1, 2, 1]);
    expect([1, 2, 1].replace([1], [], count: 1), [2, 1]);
    expect([1, 2, 1].replace([1], [], count: 0), [1, 2, 1]);
    expect([].replace([], [1, 2, 1]), [1, 2, 1]);
    expect([].replace([], [1, 2, 1], count: 0), []);
    expect([].replace([], [1, 2, 1], count: 1000), [1, 2, 1]);

    expect(([1, 2] * 5).replace([1, 2], [3], count: 2),
        [3, 3] + ([1, 2] * 3).toList());
    expect(([1, 2] * 5).replace([1, 2], [3], count: 5), [3] * 5);
    expect([1, 1, 2, 3].replace([1], []), [2, 3]);
    expect([1, 1, 2, 3].replace([1, 1], []), [2, 3]);

    const List lr = [1, 2, 2, 2, 1, 1, 1];
    expect(lr.replace([2, 1], [], recursive: true), [1]);
    expect(lr.replace([2, 1], [], count: 1), [1, 2, 2, 1, 1]);
    expect([1, 1, 1].replace([1], [], count: 1), [1, 1]);
    expect(lr.replace([2, 1], []), [1, 2, 2, 1, 1]);
    expect(lr.replace([2, 1], [2, 1], recursive: true), lr);
    expect(lr.replace([2, 1], [], count: 2, recursive: true), [1, 2, 1]);
    expect(lr.replace([2, 1], [], count: 200, recursive: true), [1]);
    expect(lr.replace([2, 1], [], count: -2, recursive: true), lr);
    expect(lr.replace([], [], recursive: true), lr);
    expect([].replace([], [], recursive: true), []);
    expect([1, 2, 3].replace([], [1, 2, 3], recursive: true),
        [1, 2, 3, 1, 1, 2, 3, 2, 1, 2, 3, 3, 1, 2, 3]);
    expect([1].replace([], [4], recursive: true), [4, 1, 4]);
    expect([1].replace([], [4], recursive: true, count: 1), [4, 1]);
    expect(
        [1, 2, 3, 3].replace([3], [1], reverse: false, count: 1), [1, 2, 1, 3]);
    expect(
        [1, 2, 3, 3].replace([3], [1], reverse: true, count: 1), [1, 2, 3, 1]);
    expect([1, 2, 3, 3].replace([3], [1], reverse: true), [1, 2, 1, 1]);
    expect([3, 2, 2, 2, 1, 1, 1].replace([2, 1], [], recursive: true, count: 2),
        [3, 2, 1]);

    final List<int> l8 = [1, 2, 3];

    expect(isIterable(l8.interleave(l8)), true);
    expect(l8.interleave(l8), [1, 1, 2, 2, 3, 3]);
    expect(l8.interleave([]), l8);
    expect([].interleave(l8), l8);
    expect([4].interleave([1, 2, 3]), [4, 1, 2, 3]);
    expect([1, 2, 3].interleave([4]), [1, 4, 2, 3]);

    expect(isIterable([1, 2, 3, 4, 5].riffleIn()), true);
    expect([1, 2, 3, 4, 5].riffleIn(), [3, 1, 4, 2, 5]);
    expect([3, 1, 4, 2, 5].riffleIn(inverse: true), inclusive(1, 5));
    expect([1, 2, 3, 4, 5, 6].riffleIn(), [4, 1, 5, 2, 6, 3]);
    expect([1, 2].riffleIn(), [2, 1]);
    expect([2, 1].riffleIn(inverse: true), [1, 2]);
    expect([].riffleIn(), []);
    expect([].riffleIn(inverse: true), []);

    expect(isIterable([1, 2, 3, 4, 5].riffleOut()), true);
    expect([1, 2, 3, 4, 5].riffleOut(), [1, 4, 2, 5, 3]);
    expect([1, 4, 2, 5, 3].riffleOut(inverse: true), inclusive(1, 5));
    expect([1, 2, 3, 4, 5, 6].riffleOut(), [1, 4, 2, 5, 3, 6]);
    expect([1, 2].riffleOut(), [1, 2]);
    expect([1, 2].riffleOut(inverse: true), [1, 2]);
    expect([].riffleOut(), []);
    expect([].riffleOut(inverse: true), []);

    expect(isIterable([1, 2, 3].before([3])), true);
    expect([1, 2, 3].before([3]), [1, 2]);
    expect([1, 2, 3].before([-12], skip: 0), [1, 2, 3]);
    expect([1, 2, 3].before([-12], skip: 0, reverse: true), []);
    expect([1, 2, 3].before([1, 2]), []);
    expect([1, 2, 3].before([1, 2], includeInResult: true), [1, 2]);
    expect([1, 2, 3].before([5, 6]), [1, 2, 3]);
    expect([1, 2, 3].before([5, 6]), [1, 2, 3]);
    expect([1, 2, 3].before([5, 6], reverse: true), []);
    expect([1, 2, 3, 3].before([3], skip: 1), [1, 2, 3]);
    expect([1, 2, 3, 3].before([3], reverse: true), [1, 2, 3]);
    expect([1, 2, 3, 3].before([3], skip: 1, reverse: true), [1, 2]);
    expect([1, 2, 3, 3].before([3], skip: 100), [1, 2, 3, 3]);
    expect([1, 2, 3, 3].before([3], skip: 100, reverse: true), []);
    expect([1, 2, 3, 3].before([], skip: 1), [1]);
    expect([1, 2, 3, 3].before([3]), [1, 2]);
    expect([1, 2, 3, 3].before([3, 3]), [1, 2]);
    expect([1, 2, 3, 3].before([3, 3], skip: 2), [1, 2, 3, 3]);
    expect([1, 2, 3, 3].before([3], skip: 3), [1, 2, 3, 3]);
    expect([1, 2, 3, 3].before([3, 3], skip: 1), [1, 2, 3, 3]);
    expect([1, 2, 3, 3].before([3, 3]), [1, 2]);
    expect([1, 2, {}].before([], skip: 1), [1]);
    expect([1, 2, {}].before([1, 2, {}]), []);
    expect([1, 2, {}, {}].before([{}], skip: 1), [1, 2, {}]);
    expect(
        [
          1,
          2,
          [3, 3]
        ].before([
          [3, 3]
        ]),
        [1, 2]);
    expect(
        [
          1,
          2,
          [3, 3]
        ].before([
          [3, 3]
        ], skip: 1, reverse: true),
        []);

    expect([1, 2, 3, 3].before([]), []);
    expect([1, 2, 3, 3].before([]), []);
    expect(
        [
          {1: 2},
          {3: 4}
        ].before([
          {3: 4}
        ]),
        [
          {1: 2}
        ]);

    expect([1, 2, 3].before([]), []);
    expect([].before([]), []);
    expect([].before([1], includeInResult: true), []);
    expect([1, 2, 3].before([3]), [1, 2]);
    expect([1, 2, 3].before([2, 3]), [1]);
    expect(
        [
          1,
          2,
          {1: 3}
        ].before([
          {1: 3}
        ]),
        [1, 2]);
    expect([1, 2, {}].before([{}]), [1, 2]);
    expect([1, 2, {}].before([], skip: 1), [1]);
    expect([1, 2, {}].before([2, {}]), [1]);
    expect([1, 2, {}].before([2, {}], skip: 0, reverse: true), [1]);
    expect([1, 2, {}].before([2, {}], skip: 1, reverse: true), []);
    expect([1, 2, 1, 2, 1].before([1, 2, 1], overlap: true, skip: 1), [1, 2]);
    expect([1, 2, 1, 2, 1].before([1, 2, 1], overlap: false, skip: 1),
        [1, 2, 1, 2, 1]);
    expect(
        [1, 2, 1, 2, 1]
            .before([1, 2, 1], overlap: true, skip: 1, includeInResult: true),
        [1, 2, 1, 2, 1]);
    expect([1, 2, 1, 2, 1].before([], overlap: true, skip: 1), [1]);
    expect([1, 2, 1, 3, 1].before([3], includeInResult: true, skip: 100),
        [1, 2, 1, 3, 1]);
    expect(
        [
          1,
          2,
          1,
          [3],
          1
        ].before([
          [3]
        ]),
        [1, 2, 1]);
    expect(
        [
          1,
          2,
          1,
          [3],
          1
        ].before([Iterable.generate(1, (e) => 3)],
            equalityFunction: deepEquals),
        [
          1,
          2,
          1,
          [3],
          1
        ]);
    expect(
        [
          1,
          2,
          1,
          [3],
          1
        ].before([Iterable.generate(1, (e) => 3)],
            equalityFunction: reverseDeepEquals),
        [1, 2, 1]);
    expect([1, 2, 1].before([1], reverse: true), [1, 2]);

    expect(isIterable([1, 2, 3, 4].beforeWhere((e) => e.isEven, reverse: true)),
        true);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isEven, reverse: true), [1, 2, 3]);
    expect(<int>[].beforeWhere((e) => e.isOdd), []);
    expect(<int>[].beforeWhere((e) => e.isOdd, reverse: true), []);
    expect([2].beforeWhere((e) => e.isOdd), [2]);
    expect([2].beforeWhere((e) => e.isOdd, reverse: true), []);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 2), [1, 2, 3, 4]);
    expect(
        [1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 2, reverse: true), []);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 200), [1, 2, 3, 4]);
    expect(
        [1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 200, reverse: true), []);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: -1), []);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: -1, reverse: true),
        [1, 2, 3, 4]);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd), []);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, reverse: true), [1, 2]);
    expect([1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 1), [1, 2]);
    expect(
        [1, 2, 3, 4].beforeWhere((e) => e.isOdd, skip: 1, reverse: true), []);
    expect(
        [1, 2, 3, 4].beforeWhere((e) => e.isOdd, includeInResult: true), [1]);
    expect(
        [1, 2, 3, 4]
            .beforeWhere((e) => e.isOdd, includeInResult: true, reverse: true),
        [1, 2, 3]);
    expect(
        [1, 2, 3, 4]
            .beforeWhere((e) => e.isEven, includeInResult: true, skip: 100),
        [1, 2, 3, 4]);

    expect(isIterable([1, 2, 3].after([-5])), true);
    expect([1, 2, 3].after([-5]), []);
    expect([1, 2, 3].after([-1], skip: -1), [1, 2, 3]);
    expect([1, 1, 1].after([], skip: 2), [1]);
    expect([1, 2, 3].after([1, 2]), [3]);
    expect([1, 2, 3].after([100], skip: -1), [1, 2, 3]);
    expect([1, 2, 3].after([100], skip: 0), []);
    expect([1, 2, 3].after([]), [1, 2, 3]);
    expect([1, 2, 3, 3].after([3]), [3]);
    expect([1, 2, 3, 3].after([3], skip: 1), []);
    expect([1, 2, 3, 3].after([3], skip: 1, reverse: true), [3]);
    expect([1, 2, 3, 3].after([3], skip: 2, reverse: true), [1, 2, 3, 3]);
    expect([1, 2, 3, 3].after([], skip: 1), [2, 3, 3]);
    expect([1, 2, 3, 3].after([], skip: 1, reverse: true), [3]);
    expect(
        [1, 2, 3, 4].after(
          [],
          skip: 3,
        ),
        [4]);
    expect([1, 2, 3, 4].after([], skip: 3, reverse: true), [2, 3, 4]);
    expect([1, 2, 3, 4].after([], skip: 5), []);
    expect([1, 2, 3, 4].after([], skip: 3, reverse: true), [2, 3, 4]);
    expect([1, 2, 3, 4].after([], skip: -100), [1, 2, 3, 4]);
    expect([1, 2, 3, 4].after([], skip: 0), [1, 2, 3, 4]);
    expect([1, 2, 3, 4].after([], skip: 0, reverse: true), []);
    expect([1, 2, 1, 2, 3].after([1, 2], skip: 1), [3]);
    expect([1, 2, 1, 2, 3].after([1, 2], skip: 1, reverse: true), [1, 2, 3]);
    expect([].after([], skip: 0), []);
    expect([].after([1], skip: 0), []);
    expect([].after([1], skip: -100), []);
    expect(
        [
          [1, 2, 3],
          [4, 5, 6]
        ].after([
          [1, 2, 3]
        ]),
        [
          [4, 5, 6]
        ]);
    expect(
        ([
          {1, 3},
          {1: 3}
        ].after([
          {1, 3}
        ]).elementAt(0) as Map)[1],
        3);
    expect([1, [], 3].after([[]]), [3]);
    expect([1, [], 3].after([3]), []);
    expect(
        [
          {1: 2},
          {3: 4}
        ].after([
          {1: 2}
        ]),
        [
          {3: 4}
        ]);
    expect([1, 2, 1, 2, 1].after([1, 2, 1]), [2, 1]);
    expect([1, 2, 1, 2, 1].after([1, 2, 1], reverse: true), []);
    expect([1, 2, 1, 2, 1].after([1, 2, 1], skip: 1), []);
    expect([1, 2, 1, 2, 1].after([1, 2, 1], includeInResult: true),
        [1, 2, 1, 2, 1]);
    expect(
        [1, 2, 1, 2, 1].after([1, 2, 1], includeInResult: true, skip: 100), []);
    expect([1, 2, 1, 3, 1].after([3], includeInResult: true, skip: 100), []);
    expect([1, 2, 1, 3, 1].after([3], includeInResult: true, reverse: true),
        [3, 1]);
    expect([1, 2, 3].after([1]), [2, 3]);
    expect([1, 2, 3].after([1, 2]), [3]);
    expect([1, 2, 3].after([]), [1, 2, 3]);
    expect([1, 2, 1, 2, 3].after([1], skip: 1), [2, 3]);
    expect([1, 2, 3].after([], skip: 1), [2, 3]);

    expect(isIterable([1, 2, 3, 4].afterWhere((e) => e.isOdd, reverse: true)),
        true);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, reverse: true), [4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 1), [4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, includeInResult: true),
        [1, 2, 3, 4]);
    expect([].afterWhere((e) => e.isOdd), []);
    expect([].afterWhere((e) => e.isOdd, reverse: true), []);
    expect([2].afterWhere((e) => e.isOdd), []);
    expect([2].afterWhere((e) => e.isOdd, reverse: true), [2]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 1), [4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 2), []);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 200), []);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: 200, reverse: true),
        [1, 2, 3, 4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, skip: -1), [1, 2, 3, 4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd), [2, 3, 4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, reverse: true), [4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd, includeInResult: true),
        [1, 2, 3, 4]);
    expect(
        [1, 2, 3, 4]
            .afterWhere((e) => e.isOdd, includeInResult: true, reverse: true),
        [3, 4]);
    expect([1, 2, 3, 4].afterWhere((e) => e.isOdd), [2, 3, 4]);

    expect([1, 2, {}].startsWith([]), true);
    expect(<dynamic>[1, 2, {}].startsWith(<dynamic>[1]), true);
    expect([1, 2, {}].startsWith([1, 2, {}]), true);
    expect(
        ([
          1,
          2,
          [
            {3: 4}
          ]
        ][2] as List)
            .startsWith([
          {3: 4}
        ]),
        true);
    expect([1, 2, {}].startsWith([2]), false);
    expect([1, 2, {}].startsWith([1]), true);
    expect([2, 1].startsWith([2, 1]), true);
    expect([].startsWith([]), true);
    expect([].startsWith([1]), false);
    expect([[]].startsWith([]), true);
    expect([1, []].startsWith([[]]), false);
    expect([[]].startsWith([[]]), true);

    List<int> intList = [4, 1, 6];
    expect(intList.ascending, [1, 4, 6]);
    expect(intList.descending, [1, 4, 6].backwards);
    expect(
        symmetricDeepEquals(
            [
              1,
              2,
              [1, 2]
            ].descending.toList(),
            [
              [1, 2],
              2,
              1
            ]),
        true);

    expect([1, 0, 3].ascending, [1, 0, 3].descending.backwards);
    expect([1, 0, 3].ascending, [0, 1, 3]);
    expect([].ascending, []);
    expect([].descending, []);
    expect(
        [
          {1, 2},
          [0, 1]
        ].ascending,
        [
          [0, 1],
          {1, 2}
        ]);
    expect(
        [
          [1, 2],
          {0, 1}
        ].ascending,
        [
          {0, 1},
          [1, 2]
        ]);
    expect(
        ['world', 'hello'].ascending, ['hello', 'world'].descending.backwards);

    expect([].frequencies(), {});
    expect([6, 2, 2].frequencies(), {6: 1, 2: 2});
    expect(
        symmetricDeepEquals(
            [
              6,
              [2],
              [2]
            ].frequencies(),
            {
              6: 1,
              [2]: 2
            }),
        true);
    expect(
        symmetricDeepEquals(
            [
              6,
              [2],
              [2]
            ].frequencies(equalityFunction: (a, b) => a == b),
            {
              6: 1,
              [2]: 1,
              [2]: 1
            }),
        true);

    expect(isIterable([].mode()), true);
    expect([].mode(), []);
    expect([1, 1, 2, 2, 3].mode(), [1, 2]);
    expect(
        [
          {1, 2},
          {1, 2},
          3
        ].mode(),
        [
          {1, 2}
        ]);
    expect(
        [
          {1, 2},
          {1, 2},
          3
        ].mode(equalityFunction: normalEquals),
        [
          {1, 2},
          {1, 2},
          3
        ]);
    expect(
        [
          Iterable.generate(2),
          {0, 1},
          3
        ].mode(equalityFunction: deepEquality.equals),
        [Iterable.generate(2)]);

    expect(isIterable([1, 2, 3].toStrings()), true);
    expect({1, 2, 3}.toStrings(), ['1', '2', '3']);
  });
}

void iterableIntTest() {
  test('HeartIterableInt', () {
    expect([1, 2].productOrNull, 2);
    expect([1, 2].productOrNull.runtimeType, int);
    expect([97, 98].chrs, 'ab');
    expect([97, 98, -1].chrs, 'ab');
    expect(<int>[].chrs, '');
  });
}

void iterableNumTest() {
  test('HeartIterableNum', () {
    Iterable<num> itn = [1.9, 2.0];
    List<int> l = [1, 2];
    List<num> ln = [1.9, 2.0];
    List<double> ld = [1.9, 2.0];

    expect(isIterable(itn.toInts()), true);
    expect(itn.toInts(), l);
    expect(itn.runtimeType == ln.runtimeType, true);
    expect(itn.runtimeType == ld.runtimeType, false);
    expect(itn.toDoubles().toList().runtimeType == ld.runtimeType, true);
    expect(l.toInts(), l);
    expect(isIterable(l.toDoubles()), true);
    expect(l.toDoubles(), [1.0, 2.0]);
    expect(ld.toInts(), l);
    expect(ld.toDoubles(), [1.9, 2.0]);
    expect(isIterable(ld.toRounded()), true);
    expect(ld.toRounded(), [2, 2]);
    expect(<num>[].toInts(), []);
    expect(<num>[].toRounded(), []);
    expect(<num>[].toDoubles(), []);
    expect(<int>[1, 2].toDoubles(), <double>[1, 2]);

    expect(<num>[].sumOrNull, null);
    expect([1, 2, 3].sumOrNull, 6);

    expect(<num>[].productOrNull, null);
    expect(<num>[1, 2, 3].productOrNull, 6);

    expect([1, 2, 3].averageOrNull, 2);
    expect([1, 2].averageOrNull, 1.5);
    expect(<num>[].averageOrNull, null);

    expect([4, 0, 1].medianOrNull, 1);
    expect(<int>[2, 2, 3, 9].medianOrNull, 2.5);
    expect(<int>[].medianOrNull, null);

    expect(isIterable([0, 5, 6.0].insertInOrder([-1])), true);
    expect([0, 5, 6.0].insertInOrder([-1]), [-1.0, 0.0, 5.0, 6.0]);
    expect([0, 5, 6.0].insertInOrder([7]), [0.0, 5.0, 6.0, 7.0]);
    expect([0, 5, 6.0].insertInOrder([4]), [0.0, 4.0, 5.0, 6.0]);
    expect([3, 1.1, 2.2].insertInOrder([1]), [1.0, 3.0, 1.1, 2.2]);
    List<num> numList = [4, 1, 6.0];
    expect(numList.insertInOrder([4]), [4.0, 4.0, 1.0, 6.0]);
    expect(numList.insertInOrder([-4]), [-4.0, 4.0, 1.0, 6.0]);
    expect(numList.insertInOrder([44]), [4.0, 1.0, 6.0, 44.0]);
    expect(numList.insertInOrder([44.0]), [4.0, 1.0, 6.0, 44.0]);
    expect((<num>[0, 5, 3]).insertInOrder([4]) is List<int>, false);
    // expect((<num>[0, 5, 3]).insertInOrder(4) is List<double>, true);
    expect([0, 5, 3.0].insertInOrder([4]) is List<int>, false);

    expect([1, 2, 3].inc(), [2, 3, 4]);
    expect([1, 2, 3].inc(2), [3, 4, 5]);
    expect([1, 2, 3].inc(-1), [0, 1, 2]);
    expect([1, 2, 3].inc(0), [1, 2, 3]);

    expect([1, 2, 3].dec(), [0, 1, 2]);
    expect([1, 2, 3].dec(2), [-1, 0, 1]);
    expect([1, 2, 3].dec(-1), [2, 3, 4]);
    expect([1, 2, 3].dec(0), [1, 2, 3]);

    expect(isIterable([1.1, 0, 3.1].descending.backwards), true);
    expect([1.1, 0, 3.1].ascending, [1.1, 0, 3.1].descending.backwards);
    expect(isIterable([].ascending), true);
    expect([].ascending, [].descending);
    expect([ArgumentError('1'), ArgumentError('0')].ascending.toStrings(),
        [ArgumentError('0'), ArgumentError('1')].toStrings());
    expect([ArgumentError('a'), ArgumentError('x')].descending.toStrings(),
        [ArgumentError('x'), ArgumentError('a')].toStrings());

    expect(<num>[].maxOrNull, null);
    expect(<num>[].minOrNull, null);
    expect([1.1, 2.2, 3.3].min, 1.1);
    expect(<double>[].productOrNull, null);
    expect([1, 2, 3].productOrNull, 6.0);

    expect([0.0, 5.0, 6.0].insertInOrder([-1]), [-1.0, 0.0, 5.0, 6.0]);
    expect([0.0, 5.0, 6.0].insertInOrder([7]), [0.0, 5.0, 6.0, 7.0]);
    expect([0.0, 5.0, 6.0].insertInOrder([4]), [0.0, 4.0, 5.0, 6.0]);
    List<double> doubleList = [4.0, 1.0, 6.0];
    expect(doubleList.insertInOrder([4]), [4.0, 4.0, 1.0, 6.0]);
    expect(doubleList.insertInOrder([-4]), [-4.0, 4.0, 1.0, 6.0]);
    expect([3, 1.1, 2.2].insertInOrder([2, 1]), [1.0, 2.0, 3.0, 1.1, 2.2]);
    expect(doubleList.insertInOrder([44.0]), [4.0, 1.0, 6.0, 44.0]);
    expect(doubleList.insertInOrder([5]), [4.0, 1.0, 5.0, 6.0]);
    expect([0.0, 5.0, 3.0].insertInOrder([4]), [0.0, 4.0, 5.0, 3.0]);

    expect([1.1, 0.1, 3.1].ascending, [1.1, 0.1, 3.1].descending.backwards);
    expect(doubleList.ascending, [1.0, 4.0, 6.0]);
    List<int> intList = [4, 1, 6];
    expect(intList.insertInOrder([44]), [4, 1, 6, 44]);
    expect(intList.insertInOrder([-44]), [-44, 4, 1, 6]);
    expect(intList.insertInOrder([5]), [4, 1, 5, 6]);
    expect([1, 4, 6].insertInOrder([2]), [1, 2, 4, 6]);
    expect([1, 4, 6].insertInOrder([2]), [1, 2, 4, 6]);
    expect(<int>[].insertInOrder([2]), [2]);

    expect(<int>[1, 2, 3].productOrNull, 6);
  });
}

void iterableIterableTest() {
  test('HeartIterableIterable', () {
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
    expect(isIterable(l1.intercalate([0, 0])), true);
    expect(l1.intercalate([0, 0]), l2.flattened.toList());
    expect([[], []].intercalate([0, 0]), [0, 0]);
    expect([[], [], []].intercalate([0, 0]), [0, 0, 0, 0]);
    expect([[], []].intercalate([]), []);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0]),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          skip: 2,
          count: 1,
          reverse: true,
        ),
        [1, 2, 0, 0, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 4,
          reverse: true,
        ),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 3,
          reverse: true,
        ),
        [1, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 3,
        ),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 100,
        ),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 100,
          skip: 100,
        ),
        [1, 2, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 100,
          reverse: true,
        ),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 100,
          skip: 100,
          reverse: true,
        ),
        [1, 2, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 0,
          reverse: true,
        ),
        [1, 2, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: -1,
          reverse: true,
        ),
        [1, 2, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          skip: -1,
          reverse: true,
        ),
        [1, 2, 3, 4, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ].intercalate(
          [0, 0],
          count: 4,
        ),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 100),
        [1, 0, 0, 2, 0, 0, 3, 0, 0, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 1, reverse: true),
        [1, 2, 3, 0, 0, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 1, skip: 100, reverse: true),
        [1, 2, 3, 4]);
    expect(l1.intercalate([0, 0], count: -1), inclusive(1, 6));
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 1),
        [1, 0, 0, 2, 3, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], skip: 1),
        [1, 2, 0, 0, 3, 0, 0, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([]),
        [1, 2, 3, 4]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], skip: 3),
        [1, 2, 3, 4]);
    expect([[]].intercalate([0, 0]), []);
    expect(<List<int>>[].intercalate([0, 0]), []);
    expect(
        [
          [1]
        ].intercalate([0, 0]),
        [1]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 0),
        [1, 2, 3, 4]);
    expect(
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ].intercalate([0, 0]),
        [1, 2, 0, 0, 3, 4, 0, 0, 5, 6]);
    expect(
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ].intercalate([0, 0], count: 1),
        [1, 2, 0, 0, 3, 4, 5, 6]);
    expect(<List>[].intercalate([0, 0]), []);
    expect(
        [
          [1]
        ].intercalate([0, 0]),
        [1]);
    expect(
        [
          [1],
          [2],
          [3]
        ].intercalate([0, 0]),
        [1, 0, 0, 2, 0, 0, 3]);
    expect(
        [
          [1],
          [2],
          [3]
        ].intercalate([0, 0], count: 2),
        [1, 0, 0, 2, 0, 0, 3]);
    expect(
        [
          [1],
          [2],
          [3]
        ].intercalate([0, 0], count: 99),
        [1, 0, 0, 2, 0, 0, 3]);
    expect(
        [
          [1],
          [2],
          [3]
        ].intercalate([0, 0], count: 1),
        [1, 0, 0, 2, 3]);
    expect(
        [
          [1],
          [2],
          [3]
        ].intercalate([0, 0], count: 0),
        [1, 2, 3]);
    expect(
        [
          [1],
          [2],
          []
        ].intercalate([0, 0]),
        [1, 0, 0, 2, 0, 0]);
    expect(
        [
          [1],
          [2],
          []
        ].intercalate([0, {}]),
        [1, 0, {}, 2, 0, {}]);
    expect(
        [
          [1, []],
          [2],
          [3]
        ].intercalate([]),
        [1, [], 2, 3]);
    expect(
        [
          [1, []],
          [2],
          [3]
        ].intercalate([[]]),
        [1, [], [], 2, [], 3]);
    expect(
        [
          [1]
        ].intercalate([]),
        [1]);
    expect(
        [
          [1]
        ].intercalate([0, 0]),
        [1]);
    expect(
        [
          [1]
        ].intercalate([0, 0]),
        [1]);
    expect(
        [
          [1],
          [2],
          [3],
          [4]
        ].intercalate([0, 0], count: 1, reverse: true),
        [1, 2, 3, 0, 0, 4]);

    expect(
        isIterable([
          [1, 2],
          [3, 4]
        ].concat()),
        true);
    expect(
        [
          [1, 2],
          [3, 4]
        ].concat(),
        [1, 2, 3, 4]);
  });
}

void iterableStringTest() {
  test('HeartIterableString', () {
    expect(['one', 'two', 'three'].intercalate('-'), 'one-two-three');
    expect(['one', 'two', 'three'].intercalate(''), 'onetwothree');
    expect(['one', 'two', 'three'].intercalate('', count: 1), 'onetwothree');
    expect(
        ['one', 'two', 'three'].intercalate('\n', count: 1), 'one\ntwothree');
    expect(['one', 'two', 'three'].intercalate('-', count: 1), 'one-twothree');
    expect(['one', 'two', 'three', 'four'].intercalate('-', count: 1),
        'one-twothreefour');
    expect(['one', 'two', 'three', 'four'].intercalate('-', skip: 1),
        'onetwo-three-four');
    expect(['one', 'two', 'three', 'four'].intercalate('-', skip: 1, count: 1),
        'onetwo-threefour');
    expect(['one', 'two', 'three', 'four'].intercalate('-', skip: -1, count: 1),
        'onetwothreefour');
    expect(['one', 'two', 'three', 'four'].intercalate('-', skip: 1, count: -1),
        'onetwothreefour');
    expect(['one', 'two', 'three'].intercalate('-', skip: 10), 'onetwothree');
    expect(
        ['one', 'two', 'three', 'four']
            .intercalate('-', count: 1, reverse: true),
        'onetwothree-four');
    expect(
        ['one', 'two', 'three'].intercalate('-', count: 99), 'one-two-three');
    expect(['one', 'two', 'three'].intercalate('-', count: -99), 'onetwothree');
    expect(['', '', ''].intercalate('-'), '--');
    expect(<String>[].intercalate('-', count: -99), '');
    expect(<String>[].intercalate('abc', count: 99), '');
    expect(<String>[].intercalate('', count: 99), '');
    expect(<String>[].intercalate(''), '');
    expect(['a', 'b'].intercalate('c', skip: -1), 'ab');
    expect(['a', 'b'].intercalate('c', count: 0), 'ab');
    expect([''].intercalate('hello'), '');
    expect(<String>['hello'].intercalate(''), 'hello');
    expect(<String>[''].intercalate('abc'), '');

    expect(['abc', '123'].zip(), ['a1', 'b2', 'c3']);
    expect(['abc', ''].zip(), []);
    expect(<String>[].zip(), []);

    expect(<String>[].zipWith((args) => args[0] == args[1]), []);
    expect(<String>['abc', 'axy'].zipWith((args) => args[0] == args[1]),
        [true, false, false]);
    expect(
        isIterable(
            <String>['abc', 'axy'].zipWith((args) => args[0] == args[1])),
        true);

    expect(['abc', '123', '456'].concat(), 'abc123456');
    expect(['abc', ''].concat(), 'abc');
    expect(['', ''].concat(), '');
    expect(<String>[].concat(), '');
  });
}

void iterableCollectionTest() {
  test('HeartCollectionIterable', () {
    expect(isIterable([10, 11, 12].transform((e) => e % 3)), true);
    expect([10, 11, 12].transform((e) => e % 3), [1, 2, 0]);

    expect(
        isIterable(
            [10, 11, 12].transformIndexed((index, element) => element + index)),
        true);
    expect([10, 11, 12].transformIndexed((index, element) => element + index),
        [10, 12, 14]);

    expect(isIterable([10, 11, 12].filter((e) => e.isEven)), true);
    expect([10, 11, 12].filter((e) => e.isEven), [10, 12]);
    expect([1, 3, 2].filter((element) => element > 3), []);
    expect([].filter((element) => element < 3), []);

    expect(
        isIterable([2, 4]
            .filterIndexed((index, element) => index.isEven && element.isEven)),
        true);
    expect(
        [2, 4]
            .filterIndexed((index, element) => index.isEven && element.isEven),
        [2]);

    expect(isIterable([2, '3', 4].filterType<int>()), true);
    expect([2, '3', 4].filterType<int>(), [2, 4]);

    expect(isIterable([2, 3, 4].filterNot((e) => e.isEven)), true);
    expect([2, 3, 4].filterNot((e) => e.isEven), [3]);

    expect(
        isIterable([0, 1, 2]
            .filterNotIndexed((index, element) => element + index < 2)),
        true);
    expect([0, 1, 2].filterNotIndexed((index, element) => element + index < 2),
        [1, 2]);

    expect(
        isIterable([
          [1, 2],
          [3, 4]
        ].flatMap((element) => element)),
        true);
    expect(
        [
          [1, 2],
          [3, 4]
        ].flatMap((element) => element),
        [1, 2, 3, 4]);

    expect(
        isIterable([
          [1, 2],
          [3, 4],
          [5, 6]
        ].flatMapIndexed((index, element) => element * index)),
        true);
    expect(
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ].flatMapIndexed((index, element) => element * index),
        [3, 4, 5, 6, 5, 6]);
  });
}

void iterableStringCollectionTest() {
  test('HeartCollectionIterableString', () {
    expect(['hello', 'world'].flatMapString((c) => [c]), 'helloworld');
    expect(['hello', 'world'].flatMapStringIndexed((i, c) => [i.toString(), c]),
        '0hello1world');
  });
}
