import './vptree.dart';


class VpTreeFactory {
  build(List<List<int>> element, int bucketSize,
      Function(List<int>, List<int>) computeDistanceCallback) {
    var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;

    var list = [];
    for (var i = 0, n = element.length; i < n; i++) {
      list[i] = {i: i};
    }
    var tree = recurseVPTree(element, list, bucketSize, computeDistanceCallback);
    return new VpTree();
  }

	recurseVPTree(List<List<int>> elements, List<Map<String, int>> list, 
  int bucketSize, Function(List<int>,List<int>) computeDistanceCallback) {
		if (list.length == 0) return null;
		var i;
		var listLength = list.length;
		if (bucketSize > 0 && listLength <= bucketSize) {
			var bucket = [];
			for (i = 0; i < listLength; i++) {
				bucket[i] = list[i].i;
			}
			return bucket;
		}
		var vpIndex = selectVPIndex(list),
		node = list[vpIndex];
		list.addAll("vpIndex", 1);
		listLength--;
		node = { i: node.i };
		if (listLength == 0) { 
      return node;
      }
    var vp = elements[node.i];
    var dmin.Infinity();
    var dmax = 0,
    item, dist, n;
		for (i = 0, n = listLength; i < n; i++) {
			item = list[i];
			dist = distance(vp, elements[item.i]);
			item.dist = dist;
			if (dmin > dist) dmin = dist;
			if (dmax < dist) dmax = dist;
		}
		node.m = dmin;
		node.M = dmax;

		var medianIndex = listLength >> 1,
		median = select(list, medianIndex, infComparator);
		var leftItems = list.remove(medianIndex, 0);
		var rightItems = list;
		node.mu = median.dist;
		node.L = recurseVPTree(elements, leftItems, bucketSize, computeDistanceCallback);
		node.R = recurseVPTree(elements, rightItems, bucketSize, computeDistanceCallback);
		return node;
	}

  selectVPIndex(list) {
    var math;
		return math.floor(math.random() * list.length);
	}

  load(List<List<int>> element, String stringifiedTree,
      Function(List<int>, List<int>) computeDistanceCallback) {
    return new VpTreeFactory();
  }

  infComparator(int a, int b) {
    return a < b;
  }

  select(List array, int k, Function(int, int) infComparator) {}
}
