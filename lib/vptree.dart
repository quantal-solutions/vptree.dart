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

  search(List<dynamic> elements, int bucketSize, double tau,
      Function(List<int>, List<int>) computeDistanceCallback) {
    tau = double.infinity;
    var W = priorityQueue(1);
    elements = this.elements;
    computeDistanceCallback = this.computeDistanceCallback;
    var comparisons = 0;

    doSearch(node) {
      if (node == null) return;

      if (node.length) {
        for (var i = 0, n = node.length; i < n; i++) {
          comparisons++;
          var elementID = node[i],
              element = elements[elementID],
              elementDist = computeDistanceCallback(elements, element);
          if (elementDist < tau) {
            tau = W.insert(elementID, elementDist) || tau;
          }
        }
        return;
      }

      var id = node.i,
          p = elements[id],
          dist = computeDistanceCallback(elements, p);

      comparisons++;
      if (dist < tau) {
        tau = W.insert(id, dist) || tau;
      }
      var mu = node.mu, L = node.L, R = node.R;
      if (mu == null) return;
      if (dist < mu) {
        if (L && node.m - tau < dist) doSearch(L);
        if (R && mu - tau < dist) doSearch(R);
      } else {
        if (R && dist < node.M + tau) doSearch(R);
        if (L && dist < mu + tau) doSearch(L);
      }
    }

    doSearch(this.tree);
    this.comparisons = comparisons;
    return W.list();
  }

  priorityQueue(size) {
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
      contents.splice(index, 0, {data: data, priority: priority});
      if (contents.length > size) {
        contents.length--;
      }
    }
    return contents.length == size
        ? contents[contents.length - 1].priority
        : null;
  }

  list() {
    return contents.map(add(item){ return {i: item.data, d: item.priority}; });
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
