import 'dart:core';

import 'package:heart/heart_types.dart';

void main() {
  List<double> ld = [1.0, 2, 3];

  print(inclusive(12, 1).tails.backwards);
  print([1, 1, 1].riffleIn());

  bool b = [1, 2, 3].startsWith([1, 2]);
  List<int> j = [1, 2, 3, 4, 5, 6];
  List<num> l = [3, 1.1, 2.2].insertInOrder([2, 1]);
  j.riffleOut();
  print('hello world'.shuffled());
  List<List<int>> twelveDaysOfChristmas = inclusiveList(12, 1).tails.backwards;
  print([].inits);
}

void loopN(Function f, int n) {
  int start = rightNow();
  for (int i = 0; i < n; i++) {
    f();
  }
  print(rightNow() - start);
}

int rightNow() {
  return DateTime.now().millisecondsSinceEpoch;
}
