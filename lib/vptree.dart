import 'package:vptree/vptree_node.dart';

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

  search(List<dynamic> element, int bucketSize) {}

  stringify() {
    // var stack = [root || tree], s = '';
    // while (stack.length) {
    // 	var node = stack.pop();

    // 	if (node.length) return '['+node.join(',')+']';

    // 	s += '{i:' + node.i;
    // 	if (node.hasOwnProperty('m')) {
    // 		s += ',m:' + node.m + ',M:' + node.M + ',μ:' + node.μ;
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
