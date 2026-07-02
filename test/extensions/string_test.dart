import 'dart:math';

import 'package:heart/heart.dart';
import 'package:test/test.dart';

void stringTests() {
  test('HeartOperatorString', () {
    expect('h' > 'a', true);
    expect('h' >= 'a', true);
    expect('h' <= 'a', false);
    expect('h' < 'a', false);
    expect('hi' < 'hello', false);
    expect('hi' > 'hello', true);
    expect('123' > '12', true);
    expect('123' >= '12', true);
    expect('123' <= '12', false);
    expect('123' < '12', false);
    expect('123' <= '123', true);
    expect('123' >= '123', true);
    expect('' >= '123', false);
    expect('' <= '123', true);
    expect('' <= '', true);
    expect('' >= '', true);
  });
  test('HeartString', () {
    expect('ac'.average, 'b');
    expect('abcd'.average, 'c');
    expect(''.average, '');

    expect('401'.median, '1');
    expect('2239'.median, '3');
    expect(''.median, '');

    expect(''.max, '');
    expect('aA'.max, 'a');

    expect(''.min, '');
    expect('aA'.min, 'A');

    expect(''.inc(), '');
    expect('abc'.inc(), 'bcd');
    expect('abc'.inc(1), 'bcd');
    expect('b'.inc(-1), 'a');

    expect(''.dec(1), '');
    expect('b'.dec(1), 'a');
    expect('b'.dec(), 'a');
    expect('bcd'.dec(-1), 'cde');

    expect('bca'.ascending, 'bca'.descending.backwards);
    expect('bca'.ascending, 'abc');
    expect(''.ascending, '');

    expect(''.descending, '');

    expect(''.isLower, true);
    expect(''.isStrictlyLower, true);
    expect('\n├'.isLower, true);
    expect('├'.isStrictlyLower, false);
    expect('1<*'.isLower, true);
    expect('1<*'.isStrictlyLower, false);
    expect('helló'.isLower, true);
    expect('helló'.isStrictlyLower, true);
    expect('helló '.isLower, true);
    expect('helló '.isStrictlyLower, false);

    expect(''.isUpper, true);
    expect(''.isStrictlyUpper, true);
    expect('\n├'.isUpper, true);
    expect('├'.isStrictlyUpper, false);
    expect('1<*'.isUpper, true);
    expect('1<*'.isStrictlyUpper, false);
    expect('helló'.toUpperCase().isUpper, true);
    expect('helló'.toUpperCase().isStrictlyUpper, true);
    expect('helló '.toUpperCase().isUpper, true);
    expect('helló '.toUpperCase().isStrictlyUpper, false);

    expect('hello'.splitAt(3), ['hel', 'lo']);
    expect('hello'.splitAt(0), ['', 'hello']);
    expect('hello'.splitAt(-10), ['', 'hello']);
    expect('hello'.splitAt(5), ['hello', '']);
    expect('hello'.splitAt(6), ['hello', '']);

    expect('hello \n \t \r world'.removeWhitespace(), 'helloworld');
    expect(''.removeWhitespace(), '');

    expect(''.groupBy((a, b) => a <= b), []);
    expect(''.group(), []);
    expect('helloworld!'.groupBy((a, b) => a <= b),
        ['h', 'ellow', 'or', 'l', 'd', '!']);

    expect('aabbccabc'.group(), ['aa', 'bb', 'cc', 'a', 'b', 'c']);
    expect(''.group(), []);

    expect('Mississippi'.nub(), 'Misp');
    expect(''.nub('abc'), '');
    expect(''.nub(''), '');
    expect('Mississippi'.nub('is'), 'Mispp');
    expect('Mississippi'.nub(''), 'Mississippi');

    expect('hello \n world'.words, ['hello', 'world']);
    expect(
        '''
          
          hello \n 
      
      world
      
      '''
            .words,
        ['hello', 'world']);
    expect(''.words, []);
    expect('    \t \n  '.words, []);
    expect(' hello \n world!'.words, ['hello', 'world!']);
    expect(' hello \n world!'.wordCount, 2);
    expect('hello((((world!))))'.words, ['hello((((world!))))']);
    expect('hello((((world!))))'.wordCount, 1);
    expect(''.wordCount, 0);
    expect('\n   \t '.wordCount, 0);
    expect('  hello,,,,,(#*\$&#  \n world! '.wordCount, 2);

    expect(''.addMissing(''), '');
    expect(''.addMissing('a'), 'a');
    expect('aa'.addMissing('a'), 'aa');
    expect('abc'.addMissing('a123'), 'abc123');

    expect('aa'.keep('a'), 'aa');
    expect('aa'.keep(''), '');
    expect('aa'.keep('c'), '');
    expect('aa'.keep('aaab'), 'aa');

    expect('hello'.any((character) => character == 'e'), true);
    expect(''.any((character) => character == 'e'), false);

    expect('hello'.every((character) => character == 'e'), false);
    expect(''.every((character) => character == ''), true);
    expect(''.every((character) => character == 'a'), true);

    String symbols = r'''!@#$%^&*()_+{}|:
    "<>,.;[]\=-0987654321''';
    expect(
        symbols.shuffled(Random(1)).keep(symbols), symbols.shuffled(Random(1)));

    expect('hello'.intersperse('-'), 'h-e-l-l-o');
    expect('hello'.intersperse('-', count: 1), 'h-ello');
    expect('hello'.intersperse('-', count: 1, reverse: true), 'hell-o');
    expect(
        'hello'.intersperse('-', count: 1, reverse: true, skip: 1), 'hel-lo');
    expect('hello'.intersperse('-', count: 100, reverse: true, skip: 1),
        'h-e-l-lo');
    expect(
        'hello'.intersperse('-', count: -100, reverse: true, skip: 1), 'hello');
    expect(
        'hello'.intersperse('-', count: 100, reverse: true, skip: -1), 'hello');
    expect(
        'hello'.intersperse('-', count: 1, reverse: true, skip: 100), 'hello');
    expect('hello'.intersperse(''), 'hello');
    expect('hello'.intersperse('-', reverse: true), 'h-e-l-l-o');
    expect(''.intersperse('-'), '');

    expect(''.count(''), 1);
    expect(''.count('a'), 0);
    expect(''.count('ab'), 0);
    expect('abc'.count(''), 4);
    expect('abc'.count('abc'), 1);
    expect('abca'.count('a'), 2);
    expect('ababa'.count('aba'), 1);
    expect('ababa'.count('aba', overlap: true), 2);
    expect('baba'.count('aba', overlap: false), 1);
    expect('baba'.count('aba', overlap: true), 1);
    expect('aaa'.count('aa', overlap: true), 2);
    expect('aaa'.count('aa', overlap: false), 1);
    expect('12121'.count(RegExp(r'121'), overlap: true), 2);
    expect('12121'.count(RegExp(r'121'), overlap: false), 1);
    expect('12121'.count(RegExp(r'121|1'), reverse: true), 2);
    expect('12121'.count(RegExp(r'12121|1')), 1);
    expect('12121'.count(RegExp(r'12121|1'), reverse: true), 2,
        reason: '12121 at the beginning cannot overlap with 1 in the middle.');
    expect('12121'.count(RegExp(r'12121|1'), reverse: true, overlap: true), 3);

    expect('hello'.indicesOf('l'), [2, 3]);
    expect('hello'.indicesOf('hello'), [0]);
    expect('helllo'.indicesOf('ll'), [2]);
    expect('h'.indicesOf('e'), []);
    expect('abc'.indicesOf(''), [0, 1, 2, 3]);
    expect('abc'.indicesOf('', reverse: true), [3, 2, 1, 0]);
    expect('ababa'.indicesOf('aba', reverse: true, overlap: true), [2, 0]);
    expect(''.indicesOf('l'), []);
    expect(''.indicesOf(''), [0]);
    expect('hello'.indicesOf('a'), []);
    expect('ababa'.indicesOf('a'), [0, 2, 4]);
    expect('ababa'.indicesOf('a'), [0, 2, 4]);
    expect('aaaaa'.indicesOf('aa'), [0, 2]);
    expect('baaaa'.indicesOf('aaaa'), [1]);
    expect('aaaaa'.indicesOf('aa', overlap: true), range(4));
    expect('aaaaa'.indicesOf('aa', overlap: false), [0, 2]);
    expect('abaaa'.indicesOf('aa', overlap: true), [2, 3]);
    expect('ababa'.indicesOf('aba', overlap: true), [0, 2]);
    expect('ababa'.indicesOf('a'), 'ababa'.indicesOf('a', overlap: true));
    expect('ababa'.indicesOf('aba'), [0]);
    expect('baba'.indicesOf('aba'), [1]);
    expect('baaaaa'.indicesOf('aaaaa'), [1]);
    expect('baaaaaa'.indicesOf('aaaaa', overlap: true), [1, 2]);
    expect('ababa'.indicesOf('', overlap: true), [0, 1, 2, 3, 4, 5]);
    expect('ababa'.indicesOf('', overlap: false), [0, 1, 2, 3, 4, 5]);
    expect('ababa'.indicesOf('bb', overlap: true), []);
    expect('ababa'.indicesOf('bb', overlap: false), []);
    expect(
        '1abc2def'.indicesOf(RegExp(r'\d[A-Z a-z]+'), overlap: true), [0, 4]);
    expect('ababa'.indicesOf(RegExp(r'(?=(aba))'), overlap: false), [0, 2]);
    expect('ababa'.indicesOf(RegExp('')), inclusive(5));
    expect('1a2ABc3'.indicesOf(RegExp(r'(?=(\d[A-Z a-z]+\d))'), overlap: false),
        [0, 2]);
    expect('1a2ABc3'.indicesOf(RegExp(r'\d [A-Z a-z]+ \d'), overlap: true),
        range(0));
    expect(''.indicesOf(RegExp('a')), range(0));
    expect('aa'.indicesOf(RegExp('')), inclusive(2));
    expect(''.indicesOf(RegExp(r'')), inclusive(0));
    expect('12121'.indicesOf(RegExp(r'121')), [0]);
    expect('12121'.indicesOf(RegExp(r'121'), overlap: true), [0, 2]);
    expect('12121'.indicesOf(RegExp(r'(?=.)'), overlap: true), inclusive(4));
    expect('12121'.indicesOf(RegExp(r'(?=.)'), overlap: false), inclusive(4));

    expect(''.keepIndices([]), '');
    expect('hello'.keepIndices([]), '');
    expect(''.keepIndices([1, 2, 3]), '');
    expect('hello'.keepIndices([1, 1, 1, 2, 3]), 'ell');
    expect('hello'.keepIndices([100, 1, 2, -3]), 'el');

    expect(''.dropIndices([0, 1]), '');
    expect(''.dropIndices([]), '');
    expect('01234'.dropIndices([0, 2, 4]), '13');
    expect('01234'.dropIndices([0, 0, 2, 4, 4]), '13');
    expect('hello'.dropIndices([-1]), 'hello');
    expect('hello'.dropIndices([]), 'hello');
    expect('hello'.dropIndices([0, 2, 3]), 'eo');
    expect('hello'.dropIndices(range(100)), '');

    expect('hello'.head, 'h');
    expect(''.head, null);

    expect(''.inits, ['']);
    expect('h'.inits, ['', 'h']);
    expect('hi'.inits, ['', 'h', 'hi']);

    expect('h'.tail, '');
    expect('hello'.tail, 'ello');
    expect(''.tail, null);

    expect('h'.tails, ['h', '']);
    expect('hi'.tails, ['hi', 'i', '']);
    expect(''.tails, ['']);

    expect(''.last, null);
    expect('h'.last, 'h');
    expect('he'.last, 'e');

    expect('hello'.subtract('l'), 'helo');
    expect('hello'.subtract('ll'), 'heo');
    expect('hello'.subtract(''), 'hello');
    expect(''.subtract('h'), '');
    expect(''.subtract(''), '');

    expect('hello'.subtractAll('l'), 'heo');
    expect('hello'.subtractAll('x'), 'hello');
    expect(''.subtractAll('l'), '');
    expect(''.subtractAll(''), '');

    expect('one'.interleave('SEVEN'), 'oSnEeVEN');
    expect('SEVEN'.interleave('one'), 'SoEnVeEN');
    expect('123'.interleave('456'), '142536');
    expect('123'.interleave('4'), '1423');
    expect('123'.interleave(''), '123');
    expect(''.interleave('123'), '123');
    expect(''.interleave(''), '');

    expect('one'.riffleOut(), 'oen');
    expect('oen'.riffleOut(inverse: true), 'one');
    expect('on'.riffleOut(), 'on');
    expect('on'.riffleOut(inverse: true), 'on');
    expect('12345'.riffleOut(), '14253');
    expect('123456'.riffleOut(), '142536');
    expect('142536'.riffleOut(inverse: true), '123456');
    expect(''.riffleOut(), '');
    expect(''.riffleOut(inverse: true), '');

    expect('one'.riffleIn(), 'noe');
    expect('noe'.riffleIn(inverse: true), 'one');
    expect('on'.riffleIn(), 'no');
    expect('no'.riffleIn(inverse: true), 'on');
    expect('12345'.riffleIn(), '31425');
    expect('123456'.riffleIn(), '415263');
    expect('415263'.riffleIn(inverse: true), '123456');
    expect(''.riffleIn(), '');
    expect(''.riffleIn(inverse: true), '');

    expect(''.backwards, '');
    expect('h'.backwards, 'h');
    expect('hello'.backwards, 'olleh');

    expect('123'.after('2', skip: -100), '123');
    expect('123'.after('2', skip: -100, reverse: true), '');
    expect('123'.after('2', skip: 100), '');
    expect('123'.after('2', reverse: true, skip: 100), '123');
    expect(''.after(''), '');
    expect(''.after('', skip: 1), '');
    expect(''.after('a'), '');
    expect('123'.after('a'), '');
    expect('abc'.after(''), 'abc');
    expect('abc'.after('', reverse: true), '');
    expect('abc'.after('', skip: 1), 'bc');
    expect('abc'.after('', skip: 1, reverse: true), 'c');
    expect('abc'.after('', skip: 100), '');
    expect('abc'.after('b'), 'c');
    expect('abc'.after('b', reverse: true), 'c');
    expect('ab'.after('b'), '');
    expect('ab'.after('a'), 'b');
    expect('abab'.after('ab'), 'ab');
    expect('abab'.after('ab', reverse: true), '');
    expect('27,3'.after('2'), '7,3');
    expect('27,3'.after('27,3'), '');
    expect('27,3'.after('27,'), '3');
    expect('27,3'.after('274'), '');
    expect('27,3'.after('274', includeInResult: true), '');
    expect('aabb'.after('a'), 'abb');
    expect('aabb'.after('aa'), 'bb');
    expect('aabb'.after('bb', skip: 10), '');
    expect('aabb'.after('a', skip: 2), '');
    expect('aabb'.after('a', skip: 2, reverse: true), 'aabb');
    expect('aabb'.after('a', skip: 3, reverse: true), 'aabb');
    expect('aabb'.after('a', skip: 1, reverse: true), 'abb');
    expect('aabb'.after('a', skip: 1), 'bb');
    expect('aabb'.after('a', skip: 1, reverse: true), 'abb');
    expect('aabb'.after('c', skip: -1), 'aabb');
    expect('aabb'.after('', skip: -1), 'aabb');
    expect('aabb'.after('', skip: -1, reverse: true), '');
    expect('121212145'.after('121', skip: 1), '45');
    expect('aabb'.after('', skip: -1, reverse: true), '');
    expect('aabb'.after('', skip: 3), 'b');
    expect('aabb'.after('', skip: 3, reverse: true), 'abb');
    expect('aabb'.after('', skip: 5), '');
    expect('aabb'.after('', skip: 5, reverse: true), 'aabb');
    expect('aabb'.after('', skip: 0), 'aabb');
    expect('ababab'.after('ab', skip: 2), '');
    expect('ababab'.after('ab', skip: 1, includeInResult: true), 'abab');
    expect('ababab'.after('ab', skip: 1, includeInResult: true, reverse: true),
        'abab');
    expect('1212121'.after('121', skip: 1, overlap: true), '21');
    expect('1212121'.after('121', skip: 1, overlap: false), '');
    expect(
        '1212121'.after('121', skip: 1, overlap: false, reverse: true), '2121');
    expect('1212121'.after('121'), '2121');
    expect(
        '1212121'.after('121', skip: 1, overlap: true, includeInResult: true),
        '12121');
    expect(
        '1212121'.after('121',
            skip: 1, overlap: true, includeInResult: true, reverse: true),
        '12121');
    expect('1212121'.after('121', skip: 1, includeInResult: true), '121');
    expect('12121'.after('121', skip: 1, overlap: false), '');
    expect('aabb'.after('bb'), '');
    expect('abc123'.after(RegExp(r'\D\d')), '23');
    expect('abc123'.after(RegExp(r'\D\d'), includeInResult: true), 'c123');
    expect('12121'.after(RegExp(r'121'), includeInResult: true), '12121');
    expect('12121'.after(RegExp(r'121'), includeInResult: true, reverse: true),
        '121');
    expect(
        '12121'.after(RegExp(r'121'),
            skip: 1, overlap: true, includeInResult: true),
        '121');
    expect('12121'.after(RegExp(r'121'), skip: 1), '');
    expect('123456'.after(RegExp(r'\d{3}'), includeInResult: true), '123456');
    expect('123456'.after(RegExp(r'\d{3}'), includeInResult: true, skip: 1),
        '456');
    expect('123456'.after(RegExp(r'\d{3}')), '456');
    expect(
        '123456'.after(RegExp(r'\d{6}'), includeInResult: true, skip: 10), '');
    expect('123456'.after(RegExp(r''), includeInResult: true, skip: 5), '6');
    expect(
        '123456'
            .after(RegExp(r''), includeInResult: true, skip: 5, reverse: true),
        '23456');
    expect('12121'.after(RegExp(r'(?=(121))'), includeInResult: true), '12121');
    expect('12121'.after(RegExp(r'(?=(121))'), includeInResult: true, skip: 1),
        '121');
    expect('12121'.after(RegExp(r'(?<=(121))'), includeInResult: true), '21');
    expect(
        '12121'
            .after(RegExp(r'(?<=(121))'), includeInResult: true, reverse: true),
        '');
    expect(
        '12121'.after(RegExp(r'121'),
            includeInResult: true, overlap: true, skip: 1),
        '121');
    expect(
        '12121'.after(RegExp(r'121'),
            includeInResult: false, overlap: true, skip: 1),
        '');
    expect(
        '11 22'.after(RegExp(r'1 2'),
            includeInResult: true, overlap: true, skip: 0),
        '1 22');

    expect(symbols.after(symbols[0]), symbols.substring(1));

    expect('12121'.before('121', skip: 1), '12121');
    expect('\n2\n2\n'.before('\n2\n'), '');
    expect('\n2\n2\n'.before('\n2\n', skip: 1), '\n2\n2\n');
    expect('\n2\n2\n'.before('\n2\n', skip: 1, overlap: true), '\n2');
    expect('\$2\$2\$'.before('\$2\$', skip: 1, overlap: true), '\$2');

    expect(symbols.before(symbols[7]), symbols.substring(0, 7));
    expect(symbols.before(symbols[symbols.length - 1]),
        symbols.substring(0, symbols.length - 1));
    expect('12121'.before('121', skip: 1, overlap: true), '12');
    expect('12121'.before('121', skip: 1, overlap: true, reverse: true), '');
    expect('12121'.before('121', skip: 1, overlap: true, includeInResult: true),
        '12121');
    expect(
        '12121'.before(
          '121',
          skip: 1,
          overlap: true,
          includeInResult: true,
          reverse: true,
        ),
        '121');
    expect('123'.before('4', includeInResult: true), '123');
    expect('123'.before('4', includeInResult: true, reverse: true), '');
    expect('aabb'.before('bb'), 'aa');
    expect('aabb'.before('bb', reverse: true), 'aa');
    expect('aabb'.before('bb', reverse: true, skip: 1), '');
    expect('aabb'.before('', reverse: true), 'aabb');
    expect('aabb'.before('', skip: 5, reverse: true), '');
    expect('aabb'.before('', skip: 5), 'aabb');
    expect('aabb'.before('', skip: 4), 'aabb');
    expect(''.before('', reverse: true), '');
    expect(''.before('', skip: 0), '');
    expect(''.before('', skip: 1), '');
    expect('aabb'.before('aabb'), '');
    expect(''.before(''), '');
    expect('aabb'.before('b', reverse: true), 'aab');
    expect('aabb'.before('bb'), 'aa');
    expect(''.before('c'), '');
    expect(''.before('abab', skip: 12), '');
    expect(''.before('abab', skip: -12), '');
    expect(''.before('abab', skip: -12, reverse: true), '');
    expect('aa'.before('a'), '');
    expect('aa'.before('a', reverse: true), 'a');
    expect('aa'.before('aa'), '');
    expect('aa'.before('aa', reverse: true), '');
    expect('aa'.before('a', skip: 1), 'a');
    expect('aa'.before('a', skip: -11), '');
    expect('aa'.before('a', skip: -11, reverse: true), 'aa');
    expect('aa'.before('a', skip: 2), 'aa');
    expect('aa'.before('a', skip: 2, reverse: true), '');
    expect('aa'.before('a', skip: 1, reverse: true), '');
    expect('aaabaaa'.before('a', skip: 3), 'aaab');
    expect('aaabaaa'.before('a', skip: 3, reverse: true), 'aa');
    expect('aaabaaa'.before('aaa', skip: 1), 'aaab');
    expect('aaabaaa'.before('a', skip: 5), 'aaabaa');
    expect('aaabaaa'.before('a', skip: 5, reverse: true), '');
    expect('aaabaaa'.before('', skip: 1, reverse: true), 'aaabaa');
    expect('aaabaaa'.before('', skip: 100), 'aaabaaa');
    expect('12345'.before('', skip: 5), '12345');
    expect('12345'.before('', skip: -6), '');
    expect('aaabaaa'.before('', skip: -100), '');
    expect('aaabaaa'.before('c', skip: -100), '');
    expect('12121'.before('121'), '');
    expect('abcabc'.before('c', skip: 1), 'abcab');
    expect('12121'.before('3', includeInResult: true), '12121');
    expect('abcdef'.before('c', includeInResult: true), 'abc');
    expect('12121'.before(RegExp(r'121'), includeInResult: true), '121');
    expect(
        '12121'.before(
          RegExp(r'121'),
          includeInResult: true,
          reverse: true,
        ),
        '12121');
    expect(
        '123456'.before(
          RegExp(r'[\d]{3}'),
          includeInResult: true,
        ),
        '123');
    expect(
        '123456'.before(
          RegExp(r'[\d]{3}'),
          includeInResult: true,
          reverse: true,
        ),
        '123456');
    expect('123456'.before(RegExp(r'[\d]{3}'), includeInResult: true, skip: 1),
        '123456');
    expect(
        '123456'.before(
          RegExp(r'[\d]{3}'),
          includeInResult: true,
          skip: 1,
          overlap: true,
          reverse: true,
        ),
        '12345');
    expect('123456'.before(RegExp(r'[\d]{3}'), includeInResult: false, skip: 0),
        '');
    expect('123456'.before(RegExp(r'[\d]{6}'), includeInResult: true, skip: 0),
        '123456');
    expect(
        '123456'.before(RegExp(r''), includeInResult: true, skip: 5), '12345');
    expect('12121'.before(RegExp(r'(?=(121))'), includeInResult: true, skip: 1),
        '12');
    expect(
        '12121'.before(
          RegExp(r'(?=(121))'),
          includeInResult: true,
          skip: 1,
          reverse: true,
        ),
        '');
    expect(
        '12121'.before(RegExp(r'121'),
            includeInResult: true, overlap: true, skip: 1),
        '12121');
    expect(
        '11 22'.before(RegExp(r'1 2'),
            includeInResult: true, overlap: true, skip: 0),
        '11 2');
    expect('12121'.before('121', skip: 1), '12121');
    expect('12121'.before('121', skip: 1, overlap: true), '12');
    expect('12121'.before('121', skip: 1, overlap: true, includeInResult: true),
        '12121');

    expect('aabbccabc'.beforeWhere((char) => char >= 'b'), 'aa');
    expect(''.beforeWhere((char) => char >= 'b'), '');
    expect('123'.beforeWhere((c) => c == '3'), '12');
    expect('1232'.beforeWhere((c) => c == '2', includeInResult: true), '12');
    expect('1232'.beforeWhere((c) => c == '2', skip: 1), '123');
    expect('1232'.beforeWhere((c) => c == '23', skip: 1), '1232');
    expect('1234'.beforeWhere((c) => c == '23'), '1234');
    expect('1234'.beforeWhere((c) => c == '23'), '1234');
    expect('1234'.beforeWhere((c) => c == '23', reverse: true), '');
    expect('1234'.beforeWhere((c) => c.codeUnits.first.isEven, skip: 1), '123');
    expect(
        '1232'.beforeWhere(
          (c) => c == '2',
          reverse: true,
        ),
        '123');
    expect(
        '1232'.beforeWhere(
          (c) => int.parse(c).isOdd,
          reverse: true,
          includeInResult: true,
        ),
        '123');

    expect('12324'.afterWhere((c) => c == '2'), '324');
    expect('12324'.afterWhere((c) => c == '2', reverse: true), '4');
    expect('12324'.afterWhere((c) => c == '2', skip: 1), '4');
    expect('12324'.afterWhere((char) => char == '2', skip: 1), '4');
    expect('12324'.afterWhere((c) => c == '2', skip: 1, reverse: true), '324');
    expect('1234'.afterWhere((c) => c == '23'), '');
    expect('1234'.afterWhere((c) => c == '23', reverse: true), '1234');
    expect('123'.afterWhere((c) => c == '2', includeInResult: true), '23');
    expect(''.afterWhere((c) => c == '2', includeInResult: true), '');
    expect(''.afterWhere((c) => c == '', includeInResult: true), '');
    expect('123'.afterWhere((c) => c == '', includeInResult: true), '');
    expect('123'.afterWhere((c) => c == '', includeInResult: true, skip: -1),
        '123');
    expect(
        '123'.afterWhere((c) => c == '',
            includeInResult: true, reverse: true, skip: -1),
        '');
    expect('123'.afterWhere((c) => c == '', includeInResult: true, skip: -1),
        '123');
    expect(
        '123'.afterWhere((c) => c == '',
            includeInResult: true, skip: -1, reverse: true),
        '');

    expect('111'.replace('1', '3'), '333');
    expect('111'.replace('1', '3', count: 1), '311');
    expect('111'.replace('1', '3'), '333');
    expect('111'.replace('1', '3', count: 2), '331');
    expect(''.replace('', '1'), '1');
    expect('111'.replace('', '2'), '2121212');
    expect('111'.replace('1', '', count: 1), '11');
    expect('111'.replace('1', '2', count: 100), '222');
    expect('111'.replace('1', '2', count: -100), '111');
    expect('1111'.replace('11', '3'), '33');
    expect('111'.replace('', '2', count: 2), '21211');
    expect(''.replace('1', '2', count: 2), '');
    expect(''.replace('', '2', count: 2), '2');
    const String sr = '1222111';
    expect(sr.replace('21', '', recursive: true), '1');
    expect(sr.replace('21', ''), '12211');
    expect(sr.replace('21', '21', recursive: true), sr);
    expect(sr.replace('21', '', count: 2, recursive: true), '121');
    expect(sr.replace('21', '1321', count: 2, recursive: true), '122132111');
    expect(sr.replace('21', '1321', count: 1, recursive: true), '122132111');
    expect('1111111'.replace(RegExp(r'11'), '3', count: null, recursive: true),
        '3331');
    expect('111'.replace(RegExp(r''), '4', count: null, recursive: true),
        '4141414');
    expect('111'.replace(RegExp(r''), '4', count: null, recursive: true),
        '4141414');
    expect(sr.replace('21', '', count: 3, recursive: true), '1');
    expect(sr.replace('21', '', count: 200, recursive: true), '1');
    expect(sr.replace('21', '', count: -2, recursive: true), sr);
    expect(sr.replace('', '', recursive: true), sr);
    expect('1'.replace('', '4', recursive: true), '414');
    expect('1'.replace('', '4', recursive: true, count: 1), '41');
    expect('12'.replace('1', '2', count: 0), '12');
    expect('31112224'.replace('12', '', recursive: true), '34');
    expect('31112224'.replace('12', '12', recursive: true), '31112224');
    expect('3124'.replace('12', '12', recursive: true), '3124');
    expect('3124'.replace('13', '12', recursive: true), '3124');
    expect('3'.replace('', '12', recursive: true), '12312');
    expect('01112220'.replace('12', '', recursive: true, count: 2), '0120');
    expect('01112220'.replace('12', '', recursive: true, count: 2, skip: 1),
        '01112220');
    expect('01112220'.replace('12', '', recursive: true, count: 20), '00');
    expect(
        '01112220'.replace('12', '', recursive: true, count: -20), '01112220');

    expect('hello'.mode, 'l');
    expect('11223'.mode, '12');
    expect('abc'.mode, 'abc');
    expect(''.mode, '');

    expect('ONEtwo'.indicesWhere((c) => c.isUpper), [0, 1, 2]);
    expect(''.indicesWhere((c) => c.isUpper), []);
  });

  test('HeartCollectionString', () {
    expect('12'.transform((c) => c * 2), '1122');
    expect(''.transform((c) => c * 2), '');

    expect('hi'.transformIndexed((index, char) => '$index$char'), '0h1i');
    expect('hello'.transformIndexed((i, c) => '$i$c'), '0h1e2l3l4o');
    expect(''.transformIndexed((i, c) => '$i$c'), '');

    expect('hello'.filter((c) => c == 'l'), 'll');
    expect('hello'.filter((c) => c == 'x'), '');
    expect(''.filter((c) => c == 'x'), '');
    expect('ONEtwo'.filter((char) => char.isUpper), 'ONE');

    expect('hello'.filterIndexed((i, c) => c == 'h' && i.isEven), 'h');
    expect('hello'.filterIndexed((i, c) => c == 'h' && i.isOdd), '');
    expect(''.filterIndexed((i, c) => c == 'h' && i.isOdd), '');
    expect(
        'ONEtwo'.filterIndexed((index, char) => char.isUpper && index.isEven),
        'OE');

    expect('hello'.filterNot((c) => c == 'h'), 'ello');
    expect(''.filterNot((c) => c == 'h'), '');

    expect(
        'ONEtwo'
            .filterNotIndexed((index, char) => char.isUpper || index.isEven),
        'to');
    expect('hello'.filterNotIndexed((i, c) => c == 'h' && i.isOdd), 'hello');
    expect(''.filterNotIndexed((i, c) => c == 'h' && i.isOdd), '');
  });
}
