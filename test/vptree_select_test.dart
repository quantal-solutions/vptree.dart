import 'package:test/test.dart';
import '../lib/vptree_factory.dart';

infComparator(int a, int b) {
  return a < b;
}

void main() {
  VpTreeFactory vpTreeFactory;
  test('GCC Standard Library nth_element test suite 1-1', () {
    var array = [6, 5, 4, 3, 2, 1, 0];
    vpTreeFactory.select(array, 3, infComparator);
    expect(array[3], equals(3));
    for (var i = 0; i < 3; i++) {
      expect(array[i] < array[3], equals(true),
          reason: 'Left elements must be < 3');
    }
    for (var i = 4; i < 7; i++) {
      expect(array[i] > array[3], equals(true),
          reason: 'Right elements must be > 3');
    }
  });

  test('GCC Standard Library nth_element test suite 1-2', () {
    var array = [0, 6, 1, 5, 2, 4, 3];
    vpTreeFactory.select(array, 3, infComparator);
    expect(array[3], equals(3));
    for (var i = 0; i < 3; i++) {
      expect(array[i] < array[3], equals(true),
          reason: 'Left elements must be < 3');
    }
    for (var i = 4; i < 7; i++) {
      expect(array[i] > array[3], equals(true),
          reason: 'Right elements must be > 3');
    }
  });

  test('GCC Standard Library nth_element test suite 02', () {
    prepareTestSet(int size) {
      List<int> v = [];
      for (var i = 0; i < size; i += 4) {
        v.add(i ~/ 2);
        v.add((size - 2) - (i ~/ 2));
      }
      for (var i = 1; i < size; i += 2) v.add(i);
      return v;
    }

    doSizeTest(int size) {
      var set = prepareTestSet(size);
      var s = List.from(set);

      s.sort((a, b) {
        return a - b;
      });

      for (var j = 0; j < size; ++j) {
        var v = List.from(set);

        vpTreeFactory.select(v, j, infComparator);

        expect(v[j] == s[j], equals(true));

        for (var i = 0; i < j; i++) {
          expect((v[j] >= v[i]), equals(true));
        }

        for (var i = j; i < v.length; i++) {
          expect(v[i] >= v[j], equals(true));
        }
      }
      var maxSize = (1 << 10);
      maxSize = 256;
      for (var size = 4; size <= maxSize; size <<= 1) doSizeTest(size);
    }
  });

  test('GCC Standard Library nth_element test suite 03', () {
    var A = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20
    ];
    var B = [
      10,
      20,
      1,
      11,
      2,
      12,
      3,
      13,
      4,
      14,
      5,
      15,
      6,
      16,
      7,
      17,
      8,
      18,
      9,
      19
    ];
    var C = [
      20,
      19,
      18,
      17,
      16,
      15,
      14,
      13,
      12,
      11,
      10,
      9,
      8,
      7,
      6,
      5,
      4,
      3,
      2,
      1
    ];
    var N = A.length;
    var logN = 3;
    var P = 7;

    compLast(x, y) {
      return x % 10 < y % 10;
    }

    var s1 = List<int>.from(B);

    dynamic pn = (N ~/ 2) - 1;
    vpTreeFactory.select(s1, pn, infComparator);
    for (var i = pn; i < N; i++) {
      expect(s1[i] >= s1[pn], equals(true));
    }

    vpTreeFactory.select(s1, pn, compLast);
    for (var i = pn; i < N; i++) {
      expect(!compLast(s1[i], s1[pn]), equals(true));
    }
  });

  test('GCC Standard Library nth_element test suite 04', () {
    var list = [4, 10, 70, 30, 10, 69, 96, 100];
    var pivot = vpTreeFactory.select(list, 3, infComparator);
    expect(pivot, equals(30));

    for (var i = 0; i < 3; i++) {
      expect(list[i] < 30, equals(true));
      expect(list[3], equals(30));
    }
    for (var i = 4; i < 8; i++) {
      expect(list[i] > 30, equals(true));
    }
  });

  test('Single Element Test', () {
    var list = [5];
    var pivot = vpTreeFactory.select(list, 0, infComparator);

    expect(pivot, equals(5));

    expect(list, equals([5]));
  });
}
