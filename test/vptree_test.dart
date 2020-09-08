import 'package:test/test.dart';
import 'package:vptree/vptree.dart';
import '../lib/vptree_factory.dart';
import 'dart:math' as Math;

void main() {
  VpTree vptree;
  VpTreeFactory vpTreeFactory;
  List<dynamic> element;
  dynamic computeDistanceCallback;

  var gridSize = 10;
  approxEqual(actualResult, expectedIndex, expectedDistance) {
    expect(actualResult.i, equals(expectedIndex));
    expect((actualResult.d - expectedDistance).abs() < 1e-10, equals(true),
        reason: actualResult.d + " pour " + expectedDistance + " attendu");
  }

  euclidean2(List<int> a, List<int> b) {
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

    var vptree = vpTreeFactory.build(element, 0, euclidean2);
    var vptreeb = vpTreeFactory.build(element, 5, euclidean2);

    var stringified, stringifiedb;
    stringified = vptree.stringify();
    stringified = vptreeb.stringify();

    var vptree2 =
        vpTreeFactory.load(element, computeDistanceCallback, stringified);
    var vptreeb2 =
        vpTreeFactory.load(element, computeDistanceCallback, stringifiedb);
  }

  searchElements(VpTree vpTree){
    var result;
    for (var i = 0, n = element.length; i < n; i++) {
      result = vpTree.search(element[i], 0);
      expect(result.length, equals(1), reason: "point [" + element[i] + ']');
      approxEqual(result[0], i, 0);
    }
  }

  searchNearestOne(VpTree vpTree){
    for (var i = 0, n = element.length; i < n; i++) {
      var point = element[i],
          x = point[0],
          y = point[1],
          result = vptree.search([x + 0.1, y + 0.4], 0);
      expect(result.length, equals(1),
          reason: "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']');
      approxEqual(result[0], i, 0.41231056256176607);
    }
  }

  searchNearestTwo(VpTree vpTree){
    var x, y, i = 0, result, expected, expectedDistance;
    for (x = 0; x < gridSize; x++) {
      for (y = 0; y < gridSize; y++) {
        result = vpTree.search([x + 0.1, y + 0.4], 2);
        expect(result.length, equals(2),
            reason: "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']');
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

  searchNearestThree(vpTree){
    var x, y, i = 0, result, expected, expectedDistance;
    for (x = 0; x < gridSize; x++) {
      for (y = 0; y < gridSize; y++) {
        result = vpTree.search([x + 0.1, y + 0.4], 3);
        expect(result.length, equals(3),
            reason: "point [" + (x + 0.1) + ', ' + (y + 0.4) + ']');
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

  searchByDistance(vpTree){
    var result = vpTree.search([1.1, 0.9], 2);
    expect(result.length, equals(10));
    expect(result[0].i, equals(11));
    expect(result[9].i, equals(31));
    result = vpTree.search([5.4, 3.2], 1);
    expect(result.length, equals(4));
    expect(result[0].i, equals(53));
    expect(result[1].i, equals(63));
    expect(result[2].i, equals(54));
    expect(result[3].i, equals(64));
  }

  // stringifyTest() {
	// 	var vptree = VpTreeFactory().build([[0,0], [1,1]], 10, euclidean2),
	// 	str = vptree.stringify(),
	// 	expected = vptree.stringify(vptree.tree).JSON;	
  //   expect(str, equals(expected));
	// }
  
  test('Search elements - no buckets', () {
    var vpTree = new VpTreeFactory().build(element, 0, euclidean2);
    searchElements(vpTree);
  });
  test('Search elements - 5 elements buckets', () {
    var vpTree = new VpTreeFactory().build(element, 5, euclidean2);
    searchElements(vpTree);
  });
  test('Search elements - stringified and reloaded VpTree - no buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 0, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchElements(vpTree);
  });
  test('Search elements - stringified and reloaded VpTree - 5 elements buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 5, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchElements(vpTree);
  });

  test('Search nearest one - no buckets', () {
    var vpTree = new VpTreeFactory().build(element, 0, euclidean2);
    searchNearestOne(vpTree);
  });
  test('Search nearest one - 5 elements buckets', () {
    var vpTree = new VpTreeFactory().build(element, 5, euclidean2);
    searchNearestOne(vpTree);
  });
  test('Search nearest one - stringified and reloaded VpTree - no buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 0, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestOne(vpTree);
  });
  test('Search nearest one - stringified and reloaded VpTree - 5 elements buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 5, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestOne(vpTree);
  });

  test('Search nearest two - no buckets', () {
    var vpTree = new VpTreeFactory().build(element, 0, euclidean2);
    searchNearestTwo(vpTree);
  });
  test('Search nearest two - 5 elements buckets', () {
    var vpTree = new VpTreeFactory().build(element, 5, euclidean2);
    searchNearestTwo(vpTree);
  });
  test('Search nearest two - stringified and reloaded VpTree - no buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 0, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestTwo(vpTree);
  });
  test('Search nearest two - stringified and reloaded VpTree - 5 elements buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 5, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestTwo(vpTree);
  });

  test('Search nearest three - no buckets', () {
    var vpTree = new VpTreeFactory().build(element, 0, euclidean2);
    searchNearestThree(vpTree);
  });
  test('Search nearest three - 5 elements buckets', () {
    var vpTree = new VpTreeFactory().build(element, 5, euclidean2);
    searchNearestThree(vpTree);
  });
  test('Search nearest three - stringified and reloaded VpTree - no buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 0, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestThree(vpTree);
  });
  test('Search nearest three - stringified and reloaded VpTree - 5 elements buckets', () {
    var origVpTree = new VpTreeFactory().build(element, 5, euclidean2);
    var vpTree = new VpTreeFactory().load(element, origVpTree.stringify(), euclidean2);
    searchNearestThree(vpTree);
  });

  test('Search by distance - no buckets', () {
    var vpTree = new VpTreeFactory().build(element, 0, euclidean2);
    searchByDistance(vpTree);
  });
  test('Search by distance - 5 elements buckets', () {
    var vpTree = new VpTreeFactory().build(element, 5, euclidean2);
    searchByDistance(vpTree);
  });

  test('Stringify',(){
    var vpTree = new VpTreeFactory().build([[0,0], [1,1]], 10, euclidean2);
    var str = vptree.stringify();
    var expected = vpTree.toJson().toString();
    expect(str, equals(expected));
  });
}

//flutter test test\vptree_test.dart
