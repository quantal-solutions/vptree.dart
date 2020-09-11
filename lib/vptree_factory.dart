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
    var treeNodes =
        recurseVPTree(elements, nodeList, bucketSize, computeDistanceCallback);
    return new VpTree(elements, treeNodes, computeDistanceCallback);
  }

  List<VpTreeNode> recurseVPTree(
      List<List<int>> elements,
      List<VpTreeNode> nodeList,
      int bucketSize,
      Function(List<int>, List<int>) computeDistanceCallback) {
    if (nodeList.length == 0) {
      return null;
    }

    var listLength = nodeList.length;
    if (bucketSize > 0 && listLength <= bucketSize) {
      var bucket = List<VpTreeNode>();
      for (var i = 0; i < listLength; i++) {
        var node = VpTreeNode();
        node.i = nodeList[i].i;
        bucket[i] = node;
      }
      return bucket;
    }
    var vpIndex = selectVPIndex(nodeList), node = nodeList[vpIndex];
    nodeList.removeAt(vpIndex);
    listLength--;
    var oldNode = node;
    node = VpTreeNode();
    node.i = oldNode.i;
    if (listLength == 0) {
      return [node];
    }
    var vp = elements[node.i];
    var dmin = double.maxFinite;
    var dmax = .0;
    VpTreeNode item;
    var dist = 0;
    var n = listLength;
    for (var i = 0; i < n; i++) {
      item = nodeList[i];
      var dist = computeDistanceCallback(vp, elements[item.i]);
      item.dist = dist;
      if (dmin > dist) dmin = dist;
      if (dmax < dist) dmax = dist;
    }
    node.min = dmin;
    node.max = dmax;

    var medianIndex = listLength >> 1;
    var median = select(nodeList, medianIndex, distanceComparator);
    var leftItems = List<VpTreeNode>.from(nodeList);
    leftItems.removeRange(medianIndex, leftItems.length);
    nodeList.removeRange(0, medianIndex);
    var rightItems = nodeList;
    node.mu = median.dist;
    node.L =
        recurseVPTree(elements, leftItems, bucketSize, computeDistanceCallback);
    node.R = recurseVPTree(
        elements, rightItems, bucketSize, computeDistanceCallback);
    return [node];
  }

  findNthElement(List<List<int>> elements, int left, int nth, int right,
      Function(List<int>, List<int>) comp) {
    if (nth <= 0 || nth > (right - left + 1))
      throw new Error(
          "VPTree.nth_element: nth must be in range [1, right-left+1] 
          (nth="+nth+")");
    );
    var pivotIndex;
    var pivotNewIndex; 
    var pivotDist;
    for (;;) {
      var pivotIndex =
          medianOf3(elements, left, right, (left + right) >> 1, comp);
      var pivotNewIndex = 
          partition(elements, left, right, pivotIndex, comp);
      var pivotDist = pivotNewIndex - left + 1;
      if (pivotDist == nth) {
        return elements[pivotNewIndex];
      } else if (nth < pivotDist) {
        right = pivotNewIndex - 1;
      } else {
        nth -= pivotDist;
        left = pivotNewIndex + 1;
      }
    }
  }

  medianOf3(list, a, b, c, comp) {
    var A = list[a], B = list[b], C = list[c];
    return comp(A, B)
        ? comp(B, C) ? b : comp(A, C) ? c : a
        : comp(A, C) ? a : comp(B, C) ? c : b;
  }

  partition(List<List<int>> elements, int left, int right, pivotIndex,
      Function(List<int>, List<int>) comp) {
    var pivotValue = elements[pivotIndex];
    var swap = elements[pivotIndex];
    elements[pivotIndex] = elements[right];
    elements[right] = swap;
    var storeIndex = left;
    for (var i = left; i < right; i++) {
      if (comp(elements[i], pivotValue)) {
        var swap = elements[storeIndex];
        elements[storeIndex] = elements[i];
        elements[i] = swap;
        storeIndex++;
      }
    }
    swap = elements[right];
    elements[right] = elements[storeIndex];
    elements[storeIndex] = swap;
    return storeIndex;
  }

  distanceComparator(a,  b) {
    return a["dist"] < b["dist"];
  }

  selectVPIndex(List<VpTreeNode> nodeList) {
    return (Random().nextInt(1) * nodeList.length).floor().toInt();
  }

  load(List<List<int>> element, String stringifiedTree,
      Function(List<int>, List<int>) computeDistanceCallback) {
    return new VpTreeFactory();
  }

  infComparator(int a, int b) {
    return a < b;
  }

  select(List<List<int>> list, int k, Function(int, int) infComparator) {
    if (k < 0 || k >= list.length) {
            throw new 
            Error("VPTree.select: k must be in range [0, list.length-1] (k="+k+")");
        }
		return nth_element(list, 0, k+1, list.length-1, infComparator);
  }
}
