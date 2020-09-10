import './vptree.dart';

class VpTreeFactory {
  build(List<List<int>> elements, int bucketSize,
      Function(List<int>, List<int>) computeDistanceCallback) {
    var list = [];
    for (var i = 0, n = elements.length; i < n; i++) {
      list[i] = {"i": i};
    }
    var treeNode = 
      recurseVPTree(elements, list, bucketSize, computeDistanceCallback);
    return new VpTree(elements, treeNode, computeDistanceCallback);
  }

  recurseVPTree(List<List<int>> elements, 
  List<Map<String, int>> list,
  int bucketSize, 
  Function(List<int>, List<int>) computeDistanceCallback) {
    if (list.length == 0) {
      return null;
    }
    var i;
    var listLength = list.length;
    if (bucketSize > 0 && listLength <= bucketSize) {
      var bucket = [];
      for (i = 0; i < listLength; i++) {
        bucket[i] = list[i]["i"];
      }
      return bucket;
    }
    var vpIndex = selectVPIndex(list), node = list[vpIndex];
    list.removeAt(vpIndex);
    listLength--;
    node = {i: node["i"]};
    if (listLength == 0) {
      return node;
    }
    var vp = elements[node["i"]];
    var dmin = double.infinity.toInt();
    var dmax = 0;
    var item = 0;
    var dist = 0;
    var n = listLength;
    for (i = 0; i < n; i++) {
      Map<String, int> item;
      var dist = computeDistanceCallback(vp, elements[item["i"]]);
      item["dist"] = dist;
      if (dmin > dist) dmin = dist;
      if (dmax < dist) dmax = dist;
    }
    node["min"] = dmin;
    node["max"] = dmax;

    var medianIndex = listLength >> 1,
        median = select(list, medianIndex, distanceComparator);
    var leftItems = List<Map<String, int>>.from(list);
    leftItems.removeRange(medianIndex, leftItems.length);
    list.removeRange(0, medianIndex);
    var rightItems = list;
    node["mu"] = median.dist;
    node["L"] = recurseVPTree(elements, leftItems, bucketSize, computeDistanceCallback);
    node["R"] = recurseVPTree(elements, rightItems, bucketSize, computeDistanceCallback);
    return node;
  }

  distanceComparator(a, b) {
    return a["dist"] < b["dist"];
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
