import 'dart:convert';
import './priority_queue.dart';
import './vptree_node.dart';
import './priority_queue_item.dart';

class VpTree {
  List<List<int>> elements;
  List<VpTreeNode> treeNodes;
  Function(List<int>, List<int>) computeDistanceCallback;
  int comparisons;

  VpTree(List<List<int>> elements, List<VpTreeNode> treeNodes,
      Function(List<int>, List<int>) computeDistanceCallback) {
    this.elements = elements;
    this.treeNodes = treeNodes;
    this.computeDistanceCallback = computeDistanceCallback;
  }

  List<PriorityQueueItem> search(
      List<int> quertElement, int searchQty, double maxDistance) {
    var modMaxDistance = maxDistance;
    var priorityQueue = PriorityQueue(searchQty);
    var elements = this.elements;
    var computeDistanceCallback = this.computeDistanceCallback;
    var comparisons = 0;

    doSearch(List<VpTreeNode> treeNodes) {
      if (treeNodes == null) return;

      if (treeNodes.length > 1) {
        for (var i = 0, n = treeNodes.length; i < n; i++) {
          comparisons++;
          var elementID = treeNodes[i].i,
              element = elements[elementID],
              elementDist = computeDistanceCallback(quertElement, element);
          if (elementDist < modMaxDistance) {
            var insertedDistance = priorityQueue.insert(elementID, elementDist);
            modMaxDistance =
                insertedDistance != null ? insertedDistance : modMaxDistance;
          }
        }
        return;
      }

      var id = treeNodes[0].i, p = elements[id];
      var dist = computeDistanceCallback(quertElement, p);

      comparisons++;
      if (dist < modMaxDistance) {
        var insertedDistance = priorityQueue.insert(id, dist);
        modMaxDistance =
            insertedDistance != null ? insertedDistance : modMaxDistance;
      }

      var mu = treeNodes[0].mu;
      var L = treeNodes[0].L;
      var R = treeNodes[0].R;
      if (!treeNodes[0].isReady) return;
      if (dist < mu) {
        if (L != null && treeNodes[0].min - modMaxDistance < dist) doSearch(L);
        if (R != null && mu - modMaxDistance < dist) doSearch(R);
      } else {
        if (R != null && dist < treeNodes[0].max + maxDistance) doSearch(R);
        if (L != null && dist < mu + maxDistance) doSearch(L);
      }
    }

    doSearch(this.treeNodes);
    this.comparisons = comparisons;
    return priorityQueue.list();
  }

  stringify() {
    // var stack = [root || tree], s = '';
    // while (stack.length) {
    // 	var node = stack.pop();

    // 	if (node.length) return '['+node.join(',')+']';

    // 	s += '{i:' + node.i;
    // 	if (node.hasOwnProperty('m')) {
    // 		s += ',m:' + node.m + ',M:' + node.M + ',mu:' + node.mu;
    // 	}
    // 	if (node.hasOwnProperty('b')) {
    // 		s += ',b:[' + node.b + ']';
    // 	}
    // 	if (node.hasOwnProperty('L')) {
    // 		var L = node.L;
    // 		if (L) {
    // 			s += ',L:';
    // 			if (L.length) s += '[' + L + ']';
    // 			else s += stringify(L);
    // 		}
    // 	}
    // 	if (node.hasOwnProperty('R')) {
    // 		var R = node.R;
    // 		if (R) {
    // 			s += ',R:';
    // 			if (R.length) s += '[' + R + ']';
    // 			else s += stringify(R);
    // 		}
    // 	}
    // 	s += '}';
    // }

    String stringify() {
      return json.encode(toJson());
    }
  }

  factory VpTree.fromJson(Map<String, dynamic> json,
      Function(List<int>, List<int>) computeDistanceCallback) {
    List<dynamic> elementsRaw = json['elements'];
    var elements = List<List<int>>();
    elementsRaw.forEach((elementContents) {
      var coords = List<int>();
      if (elementContents is List) {
        elementContents.forEach((elementContents) {
          if (elementContents is int) {
            coords.add(elementContents);
          }
        });
      }
      elementContents.add(coords);
    });
    List<dynamic> treeNodesRaw = json['treeNodes'];
    var treeNodes = List<VpTreeNode>();
    treeNodesRaw.forEach((treeNodeRaw) {
      var treeNode = VpTreeNode.fromJson(treeNodeRaw);
      treeNodes.add(treeNode);
    });
    return VpTree(elements, treeNodes, computeDistanceCallback);
  }

  Map<String, dynamic> toJson() =>
      {'elements': this.elements, 'treeNodes': this.treeNodes};
}
