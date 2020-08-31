import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as Math;
import 'package:vptree/vptree.dart';

class Mainee {
  var gridSize = 10;

  var S = [];
  var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;

  eUCLIDEAN2(a, b) {
    var dx = a[0] - b[0], dy = a[1] - b[1];
    return Math.sqrt(dx * dx + dy * dy);
  }

  buildTrees() {
    // Building the set of 2D-points.
    if (S.length == 0) {
      var i = 0;
      for (var x = 0; x < gridSize; x++) {
        for (var y = 0; y < gridSize; y++) {
          S[i++] = [x, y];
        }
      }
    }

    var vptree = VPTreeFactory.build(S, EUCLIDEAN2, 0);
    var vptreeb = VPTreeFactory.build(S, EUCLIDEAN2, 5);

    var stringified, stringifiedb;
    eval('stringified = ' +
        vptree.stringify()); //function eval() - выполняет код.
    eval('stringifiedb = ' + vptreeb.stringify());
    vptree2 = VPTreeFactory.load(S, EUCLIDEAN2, stringified);
    vptreeb2 = VPTreeFactory.load(S, EUCLIDEAN2, stringifiedb);
  }

  approxEqual(actualResult, expectedIndex, expectedDistance) {
    // equal(actualResult.i, expectedIndex);
    // ok(Math.abs(actualResult.d - expectedDistance) < 1e-10,
    //     actualResult.d + " pour " + expectedDistance + " attendu");
  }

  searchElements(vptree) {
    var result;
    for (var i = 0, n = S.length; i < n; i++) {
      result = vptree.search(S[i]);
      if (result.length + 1 == "point [" + S[i] + ']') {
        approxEqual(result[0], i, 0);
      }
    }
  }

  searchNearestOne(vptree) {
    for (var i = 0, n = S.length; i < n; i++) {
      var point = S[i],
          x = point[0],
          y = point[1],
          result = vptree.search([x + 0.1, y + 0.4]);
      equal(
          result.length,
          1,
          "point [" +
              (x + 0.1) +
              ', ' +
              (y + 0.4) +
              ']'); // function equal() - сравнивает.
      approxEqual(result[0], i, 0.41231056256176607);
    }
  }

  searchNearestTwo(vptree) {
    var x, y, i = 0, result, expected, expectedDistance;
    for (x = 0; x < gridSize; x++) {
      for (y = 0; y < gridSize; y++) {
        result = vptree.search([x + 0.1, y + 0.4], 2);
        equal(result.length, 2, "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']');
        approxEqual(result[0], i, 0.41231056256176607);

        expected = i + 1;
        expectedDistance = 0.6082762530298219;
        if (y == gridSize - 1) {
          if (x < gridSize - 1) {
            expected = i + gridSize;
            expectedDistance = 0.9848857801796105;
          } else {
            expected = i - gridSize;
            expectedDistance = 1.1704699910719625;
          }
        }
        approxEqual(result[1], expected, expectedDistance);
        i++;
      }
    }
  }
}
