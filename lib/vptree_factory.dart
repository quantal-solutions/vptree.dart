import './vptree.dart';

class VpTreeFactory {
  build(List<dynamic> element, int bucketSize, Function(List<int>,List<int>) computeDistanceCallback) {
    var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;
  }
  load(List<dynamic> element, int bucketSize, computeDistanceCallback) {
    return new VpTreeFactory();
  }

  infComparator(int a, int b) {
    return a < b;
  }

  select(List array, int k, Function(int, int) infComparator) {}

  stringify(root, tree){
    var stack = [root || tree], s = '';
		while (stack.length) {
			var node = stack.pop();

			if (node.length) return '['+node.join(',')+']';

			s += '{i:' + node.i;
			if (node.hasOwnProperty('m')) {
				s += ',m:' + node.m + ',M:' + node.M + ',μ:' + node.μ;
			}
			if (node.hasOwnProperty('b')) {
				s += ',b:[' + node.b + ']';
			}
			if (node.hasOwnProperty('L')) {
				var L = node.L;
				if (L) {
					s += ',L:';
					if (L.length) s += '[' + L + ']';
					else s += stringify(L);
				}
			}
			if (node.hasOwnProperty('R')) {
				var R = node.R;
				if (R) {
					s += ',R:';
					if (R.length) s += '[' + R + ']';
					else s += stringify(R);
				}
			}
			s += '}';
		}
		return "";
  }
}
