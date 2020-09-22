import 'dart:convert';
import 'dart:math';
import './vptree_node.dart';
import './vptree.dart';
import './space_point.dart';

class VpTreeFactory {
  VpTree build(List<SpacePoint> elements, int bucketSize,
      Function(SpacePoint, SpacePoint) computeDistanceCallback) {
    var nodeList = List<VpTreeNode>();
    for (var i = 0, n = elements.length; i < n; i++) {
      nodeList.add(VpTreeNode(i));
    }
    var treeNodes =
        recurseVPTree(elements, nodeList, bucketSize, computeDistanceCallback);
    return new VpTree(elements, treeNodes, computeDistanceCallback);
  }

  List<VpTreeNode> recurseVPTree(
      List<SpacePoint> elements,
      List<VpTreeNode> nodeList,
      int bucketSize,
      Function(SpacePoint, SpacePoint) computeDistanceCallback) {
    if (nodeList.length == 0) {
      return null;
    }

    var listLength = nodeList.length;
    if (bucketSize > 0 && listLength <= bucketSize) {
      var bucket = List<VpTreeNode>();
      for (var i = 0; i < listLength; i++) {
        bucket.insert(i, VpTreeNode(nodeList[i].i));
      }
      return bucket;
    }
    var vpIndex = selectVPIndex(nodeList), node = nodeList[vpIndex];
    nodeList.removeAt(vpIndex);
    listLength--;
    var oldNode = node;
    node = VpTreeNode(oldNode.i);
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
    node.isReady = true;
    return [node];
  }

  VpTreeNode findNthElement(List<VpTreeNode> nodeList, 
                            int left, 
                            int nth, 
                            int right,
                            Function(VpTreeNode, VpTreeNode) comp) {
    if (nth <= 0 || nth > (right - left + 1))
      throw ("VPTree.nth_element: nth must be in range [1, right-left+1] (nth=$nth)");
    var pivotIndex;
    var pivotNewIndex;
    var pivotDist;
    for (;;) {
      pivotIndex = medianOf3(nodeList, left, right, (left + right) >> 1, comp);
      pivotNewIndex = partition(nodeList, left, right, pivotIndex, comp);
      pivotDist = pivotNewIndex - left + 1;
      if (pivotDist == nth) {
        return nodeList[pivotNewIndex];
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

  partition(List<VpTreeNode> elements, int left, int right, int pivotIndex,
      Function(VpTreeNode, VpTreeNode) comp) {
    var pivotValue = elements[pivotIndex];
    var swap = elements[pivotIndex];
    elements[pivotIndex] = elements[right];
    elements[right] = swap;
    var storeIndex = left;
    for (var i = left; i < right; i++) {
      if (comp(elements[i], pivotValue)) {
        swap = elements[storeIndex];
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

  distanceComparator(VpTreeNode a, VpTreeNode b) {
    return a.dist < b.dist;
  }

  selectVPIndex(List<VpTreeNode> nodeList) {
    return (Random().nextInt(1) * nodeList.length).floor().toInt();
  }

  VpTree load(List<SpacePoint> spacePoints, String stringifiedTree,
      Function(SpacePoint, SpacePoint) computeDistanceCallback) {
    var vpTree = VpTree.fromJson(json.decode(stringifiedTree), computeDistanceCallback);
    return new VpTree(
        spacePoints,
        vpTree.treeNodes,
        computeDistanceCallback);
  }

  infComparator(int a, int b) {
    return a < b;
  }

  VpTreeNode select(List<VpTreeNode> nodeList, 
                    int k, 
                    Function(VpTreeNode, VpTreeNode) comp) {
    if (k < 0 || k >= nodeList.length) {
      throw ("VPTree.select: k must be in range [0, list.length-1] (k=$k)");
    }
    return findNthElement(nodeList, 0, k + 1, nodeList.length - 1, comp);
  }
}
