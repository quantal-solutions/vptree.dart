import './vptree.dart';

class VpTreeFactory {
  build(List<dynamic> element, int bucketSize, computeDistanceCallback) {
    var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;
    return VpTree();
  }

  load(List<dynamic> element, int bucketSize, computeDistanceCallback) {
    return new VpTreeFactory();
  }

  infComparator(int a, int b) {
    return a < b;
  }

  select(List array, int k, Function(int, int) infComparator) {}
}
