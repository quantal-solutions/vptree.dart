import 'package:test/test.dart';
import '../lib/vptree.dart';

void main() {
  test('Exercises counter should be incremented', () {
    test3() {
      var array = [6, 5, 4, 3, 2, 1, 0];

      VPTreeFactory.select(array, 3, infComparator);
      equal(array[3], 3);
      for (var i = 0; i < 3; ++i)
        ok(array[i] < array[3], 'Left elements must be < 3');
      for (var i = 4; i < 7; ++i)
        ok(array[3] < array[i], 'Left elements must be > 3');
    }
  });
}
