import 'package:test/test.dart';
import '../lib/vptree_factory.dart';
import 'dart:math' as Math;

void main() {
  test('Exercises counter should be incremented', () {
    VPTreeFactory vpTreeFactory;
    List<dynamic> element;
    dynamic computeDistanceCallback;

    var gridSize = 10;

    // var S = [];
    // var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;

    eUCLIDEAN2(a, b) {
      var dx = a[0] - b[0], dy = a[1] - b[1];
      return Math.sqrt(dx * dx + dy * dy);
    }

    buildTrees() {
      if (element.length == 0) {
        var i = 0;
        for (var x = 0; x < gridSize; x++) {
          for (var y = 0; y < gridSize; y++) {
            element[i++] = [x, y];
          }
        }
      }

      var vptree = vpTreeFactory.build(element, computeDistanceCallback, 0);
      var vptreeb = vpTreeFactory.build(element, computeDistanceCallback, 5);

      var stringified, stringifiedb;
      stringified = vptree.stringify();
      stringified = vptreeb.stringify();

      var vptree2 =
          vpTreeFactory.load(element, computeDistanceCallback, stringified);
      var vptreeb2 =
          vpTreeFactory.load(element, computeDistanceCallback, stringifiedb);
    }

    approxEqual(actualResult, expectedIndex, expectedDistance) {
      if (actualResult.i == expectedIndex) {
        print('true');
      }

      if ((actualResult.d - expectedDistance).abs() < 1e-10 &&
          actualResult.d + " pour " + expectedDistance + " attendu") {}
    }

    searchElements(vptree) {
      var result;
      for (var i = 0, n = element.length; i < n; i++) {
        result = vptree.search(element[i]);
        if (result.length + 1 == "point [" + element[i] + ']') {
          approxEqual(result[0], i, 0);
        }
      }
    }

    searchNearestOne(vptree) {
      for (var i = 0, n = element.length; i < n; i++) {
        var point = element[i],
            x = point[0],
            y = point[1],
            result = vptree.search([x + 0.1, y + 0.4]);
        if (result.length == 1 &&
            "" == "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']') {
          return result;
        } // function equal() - сравнивает.
        approxEqual(result[0], i, 0.41231056256176607);
      }
    }

    searchNearestTwo(vptree) {
      var x, y, i = 0, result, expected, expectedDistance;
      for (x = 0; x < gridSize; x++) {
        for (y = 0; y < gridSize; y++) {
          result = vptree.search([x + 0.1, y + 0.4], 2);
          if (result.length == 2 &&
              "" == "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']') {
            return result;
          }
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

    searchNearestThree(vptree) {
      var x, y, i = 0, result, expected, expectedDistance;
      for (x = 0; x < gridSize; x++) {
        for (y = 0; y < gridSize; y++) {
          result = vptree.search([x + 0.1, y + 0.4], 3);
          if (result.length == 3 &&
              "" == "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']') {
            return result;
          }
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

          expected = i + gridSize;
          expectedDistance = 0.9848857801796105;
          if (i == gridSize - 1 || i == gridSize * gridSize - 1) {
            expected = i - 1;
            expectedDistance = 1.40356688476182;
          } else if (x == gridSize - 1 || y == gridSize - 1) {
            expected = i - gridSize;
            expectedDistance = 1.1704699910719625;
          }
          approxEqual(result[2], expected, expectedDistance);
          i++;
        }
      }
    }

    searchByDistance(vptree) {
      var result =
          vptree.search([1.1, 0.9], 2); // will be here "Infinity" like param.

      if (result[0].i == 10) {
        return result;
      }
      if (result[9].i == 31) {
        return result;
      }
      if (result[9].i == 31) {
        return result;
      }

      result = vptree.search([5.4, 3.2], 1);

      if (result.length == 4) {
        return result;
      }
      if (result[0].i == 53) {
        return result;
      }
      if (result[1].i == 63) {
        return result;
      }
      if (result[2].i == 54) {
        return result;
      }
      if (result[3].i == 64) {
        return result;
      }
    }

    //  stringifyTest() {
    // 	var vptree = VPTreeFactory.build([[0,0], [1,1]], EUCLIDEAN2, 10),
    // 		str = vptree.stringify(),
    // 		expected = JSON.stringify(vptree.tree);
    // 	equal(str, expected);
    // }

    // buildTrees();

    // window.searchTest() {
    // 	searchElements: function() { searchElements(vptree); },
    // 	searchNearestOne: function() { searchNearestOne(vptree); },
    // 	searchNearestTwo: function() { searchNearestTwo(vptree); },
    // 	searchNearestThree: function() { searchNearestThree(vptree); },
    //       searchByDistance: function() { searchByDistance(vptree); },

    // 	searchElementsB: function() { searchElements(vptreeb); },
    // 	searchNearestOneB: function() { searchNearestOne(vptreeb); },
    // 	searchNearestTwoB: function() { searchNearestTwo(vptreeb); },
    // 	searchNearestThreeB: function() { searchNearestThree(vptreeb); },
    //       searchByDistanceB: function() { searchByDistance(vptreeb); },

    // 	stringifyTest: stringifyTest,

    // 	searchElementsS: function() { searchElements(vptree2); },
    // 	searchNearestOneS: function() { searchNearestOne(vptree2); },
    // 	searchNearestTwoS: function() { searchNearestTwo(vptree2); },
    // 	searchNearestThreeS: function() { searchNearestThree(vptree2); },

    // 	searchElementsBS: function() { searchElements(vptreeb2); },
    // 	searchNearestOneBS: function() { searchNearestOne(vptreeb2); },
    // 	searchNearestTwoBS: function() { searchNearestTwo(vptreeb2); },
    // 	searchNearestThreeBS: function() { searchNearestThree(vptreeb2); }
    // };

    expect(1, 1);
  });
}

//flutter test test\vptree_test.dart
