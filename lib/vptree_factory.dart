import 'dart:math';
import './vptree_node.dart';
import './vptree.dart';

class VpTreeFactory {
  build(List<List<int>> elements, int bucketSize,
      Function(List<int>, List<int>) computeDistanceCallback) {
    var nodeList = List<VpTreeNode>();
    for (var i = 0, n = elements.length; i < n; i++) {
      VpTreeNode vpTreeNode = VpTreeNode();
      vpTreeNode.i = i;
      nodeList.add(vpTreeNode);
    }
    var treeNode =
        recurseVPTree(elements, nodeList, bucketSize, computeDistanceCallback);
    return new VpTree(elements, treeNode, computeDistanceCallback);
  }

  recurseVPTree(List<List<int>> elements, List<VpTreeNode> nodeList,
      int bucketSize, Function(List<int>, List<int>) computeDistanceCallback) {
    if (nodeList.length == 0) {
      return null;
    }
    var i;
    var listLength = nodeList.length;
    if (bucketSize > 0 && listLength <= bucketSize) {
      var bucket = [];
      for (i = 0; i < listLength; i++) {
        bucket[i] = nodeList[i].i;
      }
      return bucket;
    }
    var vpIndex = selectVPIndex(nodeList), node = nodeList[i];
    nodeList.removeAt(vpIndex);
    listLength--;
    var oldNode = node;
    node = VpTreeNode();
    node.i = oldNode.i;
    if (listLength == 0) {
      return node;
    }
    var vp = elements[node.i];
    var dmin = double.maxFinite.toInt();
    var dmax = 0;
    VpTreeNode item;
    var dist = 0;
    var n = listLength;
    for (i = 0; i < n; i++) {
      item = nodeList[i];
      var dist = computeDistanceCallback(vp, elements[item.i]);
      item.dist = dist;
      if (dmin > dist) dmin = dist;
      if (dmax < dist) dmax = dist;
    }
    node.min = dmin;
    node.max = dmax;

    var medianIndex = listLength >> 1,
        median = select(nodeList, medianIndex, distanceComparator);
    var leftItems = List<VpTreeNode>.from(nodeList);
    leftItems.removeRange(medianIndex, leftItems.length);
    nodeList.removeRange(0, medianIndex);
    var rightItems = nodeList;
    node.mu = median.dist;
    node.L =
        recurseVPTree(elements, leftItems, bucketSize, computeDistanceCallback);
    node.R = recurseVPTree(
        elements, rightItems, bucketSize, computeDistanceCallback);
    return node;
  }

  distanceComparator(a, b) {
    return a["dist"] < b["dist"];
  }

  selectVPIndex(list) {
    return (Random().nextInt(1) * list.length).floor();
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
