import './priority_queue.dart';
import './vptree_node.dart';

class VpTree {
  List<List<int>> elements;
  List<VpTreeNode> treeNodes;
  Function(List<int>, List<int>) computeDistanceCallback;
  int comparisons;
  List<dynamic> contents;
  num size = 5;

  VpTree(List<List<int>> elements, List<VpTreeNode> treeNodes,
      Function(List<int>, List<int>) computeDistanceCallback) {
    this.elements = elements;
    this.treeNodes = treeNodes;
    this.computeDistanceCallback = computeDistanceCallback;
  }

  search(VpTreeNode element, int searchQty, double maxDistance ) {
    var modMaxDistance = maxDistance;
    var priorityQueue = PriorityQueue(searchQty);
    var elements = this.elements;
    var computeDistanceCallback = this.computeDistanceCallback;
    var comparisons = 0;

    doSearch() {
      var node = treeNodes;
      if (node == null) return;
      if (node.length != null) {
        for (var i = 0, n = node.length; i < n; i++) {
          comparisons++;
          var elementID = node[i].i,
              element = elements[elementID],
              elementDist = computeDistanceCallback(element, element);
          if (elementDist < modMaxDistance) {
            modMaxDistance = priorityQueue.insert(elementID, elementDist) || maxDistance;
          }
        }
        return;
      }

      var id = node.i,
          p = elements[id],
          var dist = computeDistanceCallback(element, p);

      comparisons++;
      if (dist < maxDistance) {
        maxDistance = priorityQueue.insert(id, dist) || maxDistance;
      }
      var mu = node.mu;
      var L = node.L;
      var R = node.R;
      if (mu == null) return;
      if (dist < mu) {
        if (L && node.m - maxDistance < dist) doSearch(L);
        if (R && mu - maxDistance < dist) doSearch(R);
      } else {
        if (R && dist < node.M + maxDistance) doSearch(R);
        if (L && dist < mu + maxDistance) doSearch(L);
      }
    }

    doSearch(this.tree);
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
    return "";
  }

  Map<String, dynamic> toJson() => {};
}
