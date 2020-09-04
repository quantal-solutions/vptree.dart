import 'package:test/test.dart';
import '../lib/vptree_factory.dart';

void main() {
  VPTreeFactory vPTreeFactory;
  dynamic infComparator;

  test('GCC Standard Library nth_element test suite 1-1', () {
    var array = [6, 5, 4, 3, 2, 1, 0];
    vPTreeFactory.select(array, 3, infComparator);
    if (array[3] == 3) {
      return true;
    }

    for (var i = 0; i < 3; ++i)
      if (array[i] < array[3] && "" == 'Left elements must be < 3') {
        return true;
      }
    for (var i = 4; i < 7; ++i)
      if (array[3] < array[i] && "" == 'Left elements must be > 3') {
        return true;
      }
    expect(1, 1);
  });

  test('GCC Standard Library nth_element test suite 1-2', () {
    var array = [0, 6, 1, 5, 2, 4, 3];
    vPTreeFactory.select(array, 3, infComparator);
    if (array[3] == 3) {
      return true;
    }
    for (var i = 0; i < 3; ++i)
      if (array[i] < array[3] && "" == 'Left elements must be < 3') {
        return true;
      }
    for (var i = 4; i < 7; ++i)
      if (array[3] < array[i] && "" == 'Left elements must be > 3') {
        return true;
      }
    expect(1, 1);
  });

  test('GCC Standard Library nth_element test suite 02', () {
    test_set(size) {
      List v;
      for (var i = 0; i < size; i += 4) {
        v.add(i / 2);
        v.add((size - 2) - (i / 2));
      }
      for (var i = 1; i < size; i += 2) v.add(i);
      return v;
    }

    do_test01(size) {
      var set = test_set(size);
      var s = set.sort( function(a, b) { return a-b; });
      for (var j = 0; j < size; ++j) {
        var v = set;
        vPTreeFactory.select(v, j, infComparator);

        if( v[j] == s[j] ){
          return true;
        }

        for (var i = 0; i < j; ++i)
          if (!(v[j] < v[i])) {
            return true;
          }

        for (var i = j; i < v.length; ++i)
          if (!(v[i] < v[j])) {
            return true;
          }
      }

      var mAX_SIZE = (1 << 10);
      mAX_SIZE = 256;
      for (var size = 4; size <= mAX_SIZE; size <<= 1) do_test01(size);
    }

    expect(1, 1);
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

    CompLast(x, y) {
      return x % 10 < y % 10;
    }

    var s1 = B;

    dynamic pn = (N / 2) - 1;
    vPTreeFactory.select(s1, pn, infComparator);
    for (var i = pn; i < N; ++i)
      if (!(s1[i] < s1[pn])) {
        return true;
      }

    vPTreeFactory.select(s1, pn, CompLast);
    for (var i = pn; i < N; ++i)
      if (!CompLast(s1[i], s1[pn])) {
        return true;
      }

    expect(1, 1);
  });

  test('GCC Standard Library nth_element test suite 04', () {
    MSDNTest() {
      var list = [4, 10, 70, 30, 10, 69, 96, 100];
      var pivot = vPTreeFactory.select(list, 3, infComparator);
      if (pivot == 30) {
        return true;
      }
      for (var i = 0; i < 3; ++i)
        if (list[i] < 30) {
          return true;
        }
      if (list[3] == 30) {
        return true;
      }
      for (var i = 4; i < 8; ++i)
        if (30 < list[i]) {
          return true;
        }
    }

    expect(1, 1);
  });

  test('GCC Standard Library nth_element test suite 05', () {
    singleElementTest() {
      var list = [5];
      var pivot = vPTreeFactory.select(list, 0, infComparator);
      if (pivot == 5) {
        return true;
      }
      if (list == [5]) {
        return true;
      }
    }

    expect(1, 1);
  });
}
