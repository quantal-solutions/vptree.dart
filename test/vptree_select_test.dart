import 'package:test/test.dart';
import '../lib/vptree_factory.dart';
import '../lib/vptree_node.dart';

infComparator(VpTreeNode a, VpTreeNode b) {
  return a.i < b.i;
}

void main() {
  test('GCC Standard Library nth_element test suite 1-1', () {
    var array = [
      VpTreeNode(6),
      VpTreeNode(5),
      VpTreeNode(4),
      VpTreeNode(3),
      VpTreeNode(2),
      VpTreeNode(1),
      VpTreeNode(0)
    ];
    VpTreeFactory().select(array, 3, infComparator);
    expect(array[3].i, equals(3));
    for (var i = 0; i < 3; i++) {
      expect(array[i].i < array[3].i, equals(true),
          reason: 'Left elements must be < 3');
    }
    for (var i = 4; i < 7; i++) {
      expect(array[i].i > array[3].i, equals(true),
          reason: 'Right elements must be > 3');
    }
  });

  test('GCC Standard Library nth_element test suite 1-2', () {
    var array = [
      VpTreeNode(0),
      VpTreeNode(6),
      VpTreeNode(1),
      VpTreeNode(5),
      VpTreeNode(2),
      VpTreeNode(4),
      VpTreeNode(3)
    ];
    VpTreeFactory().select(array, 3, infComparator);
    expect(array[3].i, equals(3));
    for (var i = 0; i < 3; i++) {
      expect(array[i].i < array[3].i, equals(true),
          reason: 'Left elements must be < 3');
    }
    for (var i = 4; i < 7; i++) {
      expect(array[i].i > array[3].i, equals(true),
          reason: 'Right elements must be > 3');
    }
  });

  test('GCC Standard Library nth_element test suite 02', () {
    List<VpTreeNode> prepareTestSet(int size) {
      var v = List<VpTreeNode>();
      for (var i = 0; i < size; i += 4) {
        v.add(VpTreeNode(i ~/ 2));
        v.add(VpTreeNode((size - 2) - (i ~/ 2)));
      }
      for (var i = 1; i < size; i += 2) v.add(VpTreeNode(i));
      return v;
    }

    doSizeTest(int size) {
      var set = prepareTestSet(size);
      var s = List<VpTreeNode>.from(set);
      s.sort((a, b) {
        return a.i - b.i;
      });

      for (var j = 0; j < size; ++j) {
        var v = List<VpTreeNode>.from(set);
        VpTreeFactory().select(v, j, infComparator);
        expect(v[j] == s[j], equals(true));
        for (var i = 0; i < j; i++) {
          expect((v[j].i >= v[i].i), equals(true));
        }
        for (var i = j; i < v.length; i++) {
          expect(v[i].i >= v[j].i, equals(true));
        }
      }
    }

    var maxSize = (1 << 10);
    maxSize = 256;
    for (var size = 4; size <= maxSize; size <<= 1) doSizeTest(size);
  });

  test('GCC Standard Library nth_element test suite 03', () {
    var A = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 ];
    var B = [ VpTreeNode(10), VpTreeNode(20), VpTreeNode(1), VpTreeNode(11), VpTreeNode(2),
    VpTreeNode(12), VpTreeNode(3), VpTreeNode(13), VpTreeNode(4), VpTreeNode(14),
    VpTreeNode(5), VpTreeNode(15), VpTreeNode(6), VpTreeNode(16), VpTreeNode(7), 
    VpTreeNode(17), VpTreeNode(8), VpTreeNode(18),VpTreeNode(9), VpTreeNode(19) ];
    var C = [ 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 ];
    var N = A.length;
    var logN = 3;
    var P = 7;

    compLast(VpTreeNode x, VpTreeNode y) {
      return x.i % 10 < y.i % 10;
    }

    var s1 = B;
    dynamic pn = (N ~/ 2) - 1;
    VpTreeFactory().select(s1, pn, infComparator);
    for (var i = pn; i < N; i++) {
      expect(s1[i].i >= s1[pn].i, equals(true));
    }

    VpTreeFactory().select(s1, pn, compLast);
    for (var i = pn; i < N; i++) {
      expect(!compLast(s1[i], s1[pn]), equals(true));
    }
  });

  test('GCC Standard Library nth_element test suite 04', () {
    var list = [ 
    VpTreeNode(4), VpTreeNode(10), 
    VpTreeNode(70), VpTreeNode(30), 
    VpTreeNode(10), VpTreeNode(69), 
    VpTreeNode(96), VpTreeNode(100)];
    var pivot = VpTreeFactory().select(list, 3, infComparator);
    expect(pivot.i, equals(30));
    for (var i = 0; i < 3; i++) {
      expect(list[i].i < 30, equals(true));
      expect(list[3].i, equals(30));
    }
    for (var i = 4; i < 8; i++) {
      expect(list[i].i > 30, equals(true));
    }
  });

  test('Single Element Test', () {
    List<VpTreeNode> list = [VpTreeNode(5)];
    var pivot = VpTreeFactory().select(list, 0, infComparator);
    expect(pivot.i, equals(5));
    expect(list, equals([pivot]));
  });
}
