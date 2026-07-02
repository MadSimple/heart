import 'package:heart/heart.dart';
import 'package:test/test.dart';

void mapTest() {
  test('HeartMap', () {
    expect({9: 5, 1: 2, 4: 8}.ascendingKeys.keys, [1, 4, 9]);
    expect({}.ascendingKeys, {});
    expect({9: 5, 1: 2, 4: 8}.descendingKeys.keys, [9, 4, 1]);
    expect({}.descendingKeys, {});
    expect({9: 5, 1: 2, 4: 8}.ascendingValues.values, [2, 5, 8]);
    expect({}.ascendingValues, {});
    expect({9: 5, 1: 2, 4: 8}.descendingValues.values, [8, 5, 2]);
    expect({}.descendingValues, {});
  });
}
