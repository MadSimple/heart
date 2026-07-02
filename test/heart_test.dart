import 'package:test/test.dart';

import 'extensions/int_test.dart';
import 'extensions/iterable_test.dart';
import 'extensions/list_test.dart';
import 'extensions/map_test.dart';
import 'extensions/other_test.dart';
import 'extensions/queue_list_test.dart';
import 'extensions/queue_test.dart';
import 'extensions/set_test.dart';
import 'extensions/string_test.dart';

void main() {
  group('Iterable methods', () {
    iterableOperatorTest();
    iterableTest();
    iterableIntTest();
    iterableNumTest();
    iterableIterableTest();
    iterableCollectionTest();
    iterableStringTest();
    iterableStringCollectionTest();
  });
  group('List methods', () {
    listOperatorTest();
    listTest();
    listIntTest();
    listNumTest();
    listIterableTest();
    listCollectionTest();
    listStringTest();
  });
  group('Queue methods', () {
    queueOperatorTest();
    queueTest();
    queueIntTest();
    queueNumTest();
    queueIterableTest();
    queueCollectionTest();
    queueStringTest();
  });
  group('QueueList methods', () {
    queueListOperatorTest();
    queueListTest();
    queueListIntTest();
    queueListNumTest();
    queueListIterableTest();
    queueListCollectionTest();
    queueListStringTest();
  });
  group('Set methods', () {
    setOperatorTest();
    setTest();
    setIntTest();
    setNumTest();
    setIterableTest();
    setStringTest();
    setCollectionTest();
  });

  group('String methods', () {
    stringTests();
  });

  group('int methods', () {
    intTest();
  });
  group('Map methods', () {
    mapTest();
  });
  group('other functions', () {
    otherTest();
  });
}
