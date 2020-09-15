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
    var priorityQueue = createPriorityQueue(searchQty);
    elements = this.elements;
    computeDistanceCallback = this.computeDistanceCallback;
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
          if (elementDist < maxDistance) {
            maxDistance = priorityQueue.insert(elementID, elementDist) || maxDistance;
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

  createPriorityQueue(size) {
    var api = {
      // get length() {
      // 	return contents.length;
    };
    return api;
  }

  binaryIndexOf(priority, num size) {
    var minIndex = 0;
    var maxIndex = contents.length - 1;
    var currentIndex;
    var currentElement;

    while (minIndex <= maxIndex) {
      currentIndex = (minIndex + maxIndex) >> 1;
      currentElement = contents[currentIndex].priority;

      if (currentElement < priority) {
        minIndex = currentIndex + 1;
      } else if (currentElement > priority) {
        maxIndex = currentIndex - 1;
      } else {
        return currentIndex;
      }
    }
    return -1 - minIndex;
  }

  insert(data, priority) {
    var index = binaryIndexOf(priority, size);
    if (index < 0) index = -1 - index;
    if (index < size) {
      contents.remove(index, 0, {data: data, priority: priority});
      if (contents.length > size) {
        contents.length--;
      }
    }
    return contents.length == size
        ? contents[contents.length - 1].priority
        : null;
  }

  list() {
    return contents.add((item){ return {i: item.data, d: item.priority}; });
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
